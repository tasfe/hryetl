package com.banggo.scheduler.job;

import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.quartz.JobExecutionException;

import com.banggo.scheduler.async.service.AsyncExecuteService;
import com.banggo.scheduler.async.task.AsyncTask;
import com.banggo.scheduler.async.task.PublishEventAsyncTask;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.event.EventPublisher;
import com.banggo.scheduler.event.ExecuteFinishedEvent;
import com.banggo.scheduler.exp.Expression;
import com.banggo.scheduler.frontctl.FrontController;
import com.banggo.scheduler.ro.InterruptRO;

@SuppressWarnings("rawtypes")
public class HessianInterruptJobImpl extends HessianJobSupport implements HessianInterruptJob {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(HessianInterruptJobImpl.class);
	
	@Resource
	protected AsyncExecuteService asyncExecuteService;
	
	@Resource
	protected EventPublisher eventPublisher;

	@Override
	public void execute(ScheJobContext context) throws JobExecutionException  {
		executeInTemplate(context);
	}


	@Override
	protected void doScheJob(ScheExecuter scheExecuter,FrontController clientFrontCtl, String jobName, String jobGroup,
			Map params) {
		if (logger.isDebugEnabled()) {
			logger.debug("doScheJob(ScheExecuter, FrontController, String, String, Map) - start " + scheExecuter);
		}
		
		// 执行远程调用
		InterruptRO ro = null;
		try{
			 ro = clientFrontCtl.interrupt(jobName, jobGroup, params);
		}catch (Exception e) {
			logger.error("doScheJob(ScheExecuter, FrontController, String, String, Map)", e);
			scheExecuter.setException(e.getMessage());
		}
		
		if (ro == null || ro.getIsInterruptSuccess() == null){
			scheExecuter.setException("中断返回空消息");
		}else{
			if (!ro.getIsInterruptSuccess()){ // 只有任务不存在，或任务已执行完成，才会中断失败
				scheExecuter.setStatus(ScheExecuterStatus.finished);
				scheExecuter.setEndTime(new Date());
			}
		}
		
		// 异步通知执行完成
		AsyncTask<Void> asyncTask = new PublishEventAsyncTask(eventPublisher, new ExecuteFinishedEvent(scheExecuter));
		asyncExecuteService.submitTask(asyncTask);
				

		if (logger.isDebugEnabled()) {
			logger.debug("doScheJob(ScheExecuter, FrontController, String, String, Map) - end");
		}
	}


	@Override
	protected ScheExecuter createScheExecuter(ScheJobContext context,
			ScheJob scheJob) {
		
	    int scheExecuterId = context.getExecuterId();
	    if (scheExecuterId == ScheJobContext.NULL_EXECUTERID){
	    	logger.warn("缺少必要的scheExecuterId,无法创建ScheExecuter:" + context);
	    	return null;
	    }
	    
	    // 根据ID查询
		return scheJobService.retrieveScheExecuter(scheExecuterId);
	}


	@Override
	protected FrontController createClientFrontController(ScheJobContext context, ScheJob scheJob,
			ScheExecuter scheExecuter) {
		FrontController frontCtl = null;
		
		String cancelUrl = scheExecuter.getRemoteCancelUrl();
		if (StringUtils.equalsIgnoreCase(cancelUrl, Expression.REMOTE_URL)){
			cancelUrl = scheJob.getRemoteUrl();
		}
		
		if (StringUtils.isBlank(cancelUrl)){
			scheExecuter.setException("中断地址为空，无法中断");
		}
		
		try {
			frontCtl = (FrontController)getHessianProxyFactory(scheJob).create(cancelUrl);
		} catch (Exception e) {
			scheExecuter.setException(e.getMessage()); // TODO 覆盖? 追加?
		} 
		
		return frontCtl;
	}

	@Override
	protected Map buildScheJobParam(ScheExecuter scheExecuter, ScheJob scheJob) {
		
		Map params =  super.buildScheJobParam(scheExecuter, scheJob);
		// 加上应用的执行编号
		params.put(FrontController.APP_EXECUTE_NO_KEY, scheExecuter.getRemoteExecNo());
		return params;
	}
}
