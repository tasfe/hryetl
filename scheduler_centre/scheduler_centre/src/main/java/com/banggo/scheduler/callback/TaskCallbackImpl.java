package com.banggo.scheduler.callback;

import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.apache.log4j.Logger;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.banggo.scheduler.async.service.AsyncExecuteService;
import com.banggo.scheduler.async.task.AsyncTask;
import com.banggo.scheduler.async.task.PublishEventAsyncTask;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.event.EventPublisher;
import com.banggo.scheduler.event.ExecuteFinishedEvent;
import com.banggo.scheduler.interfaces.TaskCallback;
import com.banggo.scheduler.po.CallbackPO;
import com.banggo.scheduler.ro.CallbackRO;
import com.banggo.scheduler.service.ScheJobService;
import com.caucho.services.server.Service;

public class TaskCallbackImpl implements TaskCallback,Service {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TaskCallbackImpl.class);

	protected ScheJobService scheJobService;
	protected AsyncExecuteService asyncExecuteService;
	protected EventPublisher eventPublisher;
	
	@Override
	public CallbackRO callback(CallbackPO po) {
		if (logger.isDebugEnabled()) {
			logger.debug("callback(CallbackPO) - start " + po);
		}

		if (po == null ){
			CallbackRO returnCallbackRO = badCallback("请求参数不能为空");
			if (logger.isDebugEnabled()) {
				logger.debug("callback(CallbackPO) - end:请求参数不能为空");
			}
			return returnCallbackRO;
		}
		
	    // 根据executerNo 和 remoteExecuterNo查找对应的ScheExecuter
		ScheExecuter scheExecuter = findScheExecuter(po);
		if (scheExecuter == null){
			// 任务执行太快了，调用还没返回，回调就先到了
			logger.error("找不到scheExecuter?" + po.getExecNo() + "  " + po.getAppExecNo());
			
			// 找不到执行记录
			CallbackRO returnCallbackRO = badCallback("无对应的执行记录");
			if (logger.isDebugEnabled()) {
				logger.debug("callback(CallbackPO) - end:" + po);
			}
			return returnCallbackRO;
		}
		
		scheExecuter.setEndTime(new Date());
		scheExecuter.setRemoteExecEnd(po.getEndTime());
		scheExecuter.setResult(po.isSuccess());
		scheExecuter.setException(po.getException());
		scheExecuter.setStatus(ScheExecuterStatus.finished);
		
		try {
			scheJobService.updateScheExecuter(scheExecuter);
		} catch (Exception e) {
			logger.error("callback(CallbackPO)", e);

			CallbackRO returnCallbackRO = badCallback(e.getMessage());
			return returnCallbackRO;
		}
		
		// 异步通知执行完成
		AsyncTask<Void> asyncTask = new PublishEventAsyncTask(eventPublisher, new ExecuteFinishedEvent(scheExecuter));
		asyncExecuteService.submitTask(asyncTask);
		
		CallbackRO returnCallbackRO = done();
		if (logger.isDebugEnabled()) {
			logger.debug("callback(CallbackPO) - end:"+ returnCallbackRO);
		}
		return returnCallbackRO;
	}


	private void sleep(long sec) {
		sec = (sec <= 0) ? 1 : sec;
		try {
			Thread.sleep(sec*1000);
		} catch (InterruptedException e) {
			logger.error(e);
		} 
	}

	
	CallbackRO badCallback(String msg){
		CallbackRO rs = new CallbackRO();
		rs.setAccept(false);
		rs.setMsg(msg);
        return rs;
	}
	
	CallbackRO done(){
		CallbackRO rs = new CallbackRO();
		rs.setAccept(true);
		rs.setMsg("ok");
        return rs;
	}


	@Override
	public void init(ServletConfig config) throws ServletException {
		scheJobService = (ScheJobService)WebApplicationContextUtils
				.getRequiredWebApplicationContext(config.getServletContext())
				.getBean("scheJobService");
		
		asyncExecuteService = (AsyncExecuteService)WebApplicationContextUtils
				.getRequiredWebApplicationContext(config.getServletContext())
				.getBean("asyncExecuteService");
		
		eventPublisher = (EventPublisher)WebApplicationContextUtils
				.getRequiredWebApplicationContext(config.getServletContext())
				.getBean("eventPublisher");
	}


	@Override
	public void destroy() {
	}
	
	private ScheExecuter findScheExecuter(CallbackPO po) {
		ScheExecuter scheExecuter = null;
		int retryCnt = 0;
		do {
			scheExecuter = scheJobService.getScheExecuterByNo(po.getExecNo(),po.getAppExecNo());
			
			if (scheExecuter != null) {
				break;
			}

			// 任务执行太快了，调用还没返回，回调就先到了
			retryCnt++;
			sleep(2); // 2 sec
			logger.warn("找不到scheExecuter? [retry: " + retryCnt +"]"
					+ po.getExecNo() + "  " + po.getAppExecNo());

		} while (scheExecuter == null && retryCnt < 6);
		
		return scheExecuter;
	}
		
}
