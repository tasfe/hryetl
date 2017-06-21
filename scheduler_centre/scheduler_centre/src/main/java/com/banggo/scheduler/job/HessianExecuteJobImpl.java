package com.banggo.scheduler.job;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;
import com.banggo.scheduler.frontctl.FrontController;
import com.banggo.scheduler.ro.ExecuteRO;
import com.banggo.scheduler.service.ScheBaseService;

@SuppressWarnings("rawtypes")
public class HessianExecuteJobImpl extends HessianJobSupport implements HessianExecuteJob {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(HessianExecuteJobImpl.class);

	@Autowired
	@Qualifier("propertiesFactory")
	private Properties properties;
	
	@Resource
	private ScheBaseService scheBaseService;
	
	@Override
	public void execute(ScheJobContext context) throws JobExecutionException  {
		executeInTemplate(context);
	}


	@Override
	protected void doScheJob(ScheExecuter scheExecuter,FrontController clientFrontCtl, String jobName, String jobGroup,
			Map params) {
		if (logger.isDebugEnabled()) {
			logger.debug("doScheJob(ScheExecuter, Task, String, String, Map) - start " + scheExecuter);
		}
		
		// 执行参数加回调地址
		setCallBackUrl(params);
		
		// 执行远程调用
		ExecuteRO ro = null;
		try{
			 ro = clientFrontCtl.execute(jobName, jobGroup, params);
		}catch (Throwable e) {
			logger.error("doScheJob(ScheExecuter, Task, String, String, Map)", e);

			scheExecuter.setStatus(ScheExecuterStatus.unknow);
			
			String errMsg = e.getMessage();
			if (ro != null && ro.getException() != null){
				errMsg = errMsg + "[应用异常：" + ro.getException() + " ]";
			}
			
			scheExecuter.setException(errMsg);
			return;
		}
		
		if (ro == null){
			scheExecuter.setStatus(ScheExecuterStatus.unknow);
			scheExecuter.setException("远程调用返回空值");
		}else{
			
			logger.info("jobName=" + jobName + " jobGroup=" + jobGroup + " 远程调用结果:" + ro);
			
			if (ro.isAccept()){
				scheExecuter.setStatus(ScheExecuterStatus.processing);
				scheExecuter.setRemoteExecNo(ro.getAppExecNo());
				scheExecuter.setRemoteCancelUrl(ro.getCancelUrl());
				scheExecuter.setRemoteExecBegin(ro.getBeginTime());
			}else{
				scheExecuter.setStatus(ScheExecuterStatus.finished);
				scheExecuter.setException(ro.getException());
				scheExecuter.setEndTime(new Date());
				scheExecuter.setResult(ScheExecuter.RESULT_FAILED);
			}
		}

		if (logger.isDebugEnabled()) {
			logger.debug("doScheJob(ScheExecuter, Task, String, String, Map) - end");
		}
	}


	@SuppressWarnings("unchecked")
	private void setCallBackUrl(Map params) {
		
		String callbackUrl = properties.getProperty("scheduler.centre.callback.url");
		params.put(FrontController.CALL_BACK_URL_KEY, callbackUrl);
	}


	@Override
	protected ScheExecuter createScheExecuter(ScheJobContext context,
			ScheJob scheJob) {
		ScheExecuter scheExecuter = null;
		if (ScheJob.DISALLOW_CONCURRENT.equalsIgnoreCase(scheJob
				.getIsAllowConcurrent()) && !context.isIgnoreConcurrency()) {
			scheExecuter = createScheExecuterInPessimisticLock(context,scheJob.getId()); // Pessimistic Lock
					
		} else {
			scheExecuter = createScheExecuter(context,scheJob.getId());
		}
		
		if (context.isManumalTriggerJob()){
		    // FIXME 临时解决方法
			// 保存人工触发的信息 
			ScheManualTrigger manualOp = new ScheManualTrigger();
			manualOp.setScheExecId(scheExecuter.getId());
			manualOp.setScheJobId(scheExecuter.getScheJobId());
			manualOp.setOperateBy("system"); 
			manualOp.setTriggerType(ScheManualTrigger.TRIGGERTYPE_TRIGGER_MANUAL);
			scheBaseService.saveManualOp(manualOp);
		}
		return scheExecuter;
	}
	
	private ScheExecuter createScheExecuterInPessimisticLock(
			ScheJobContext context, int scheJobId) {
		
		ScheExecuter scheExecuter = null;
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try{
			ScheJob scheJob = scheJobService.lock(scheJobId); // 上锁
			if (scheJob == null){
				throwFatalError(context);
			}
			
			// 检查是否有相同的任务正在运行
			if (!isExistsRunningTask(context)){
				scheExecuter = scheJobService.createScheExecuter(scheJobId,context.getQTZInstanceId());
			}
		
			// 解锁
			transactionService.commit(ts); 
		}catch(Throwable t){
			logger.error(t);
			transactionService.rollback(ts); 
		}
		
		return scheExecuter;
	}

	private ScheExecuter createScheExecuter(ScheJobContext context, int scheJobId) {
		return scheJobService.createScheExecuter(scheJobId,context.getQTZInstanceId());
	}
	
	private boolean isExistsRunningTask(ScheJobContext context){
		List<ScheExecuter> runningJobList = scheJobService.retrieveRunningScheJob(context.getAppName(), context.getJobName(), context.getJobGroup());
		if (runningJobList != null && !runningJobList.isEmpty()){
			// 有任务正在运行
			logger.warn("任务:" + context + " 已经有正在运行的实例 ("+ runningJobList.get(0).getExecNo() + ")，本次不运行." );
			return true;
		}
		return false;
	}


	@Override
	protected FrontController createClientFrontController(ScheJobContext context, ScheJob scheJob,
			ScheExecuter scheExecuter) {
		FrontController clientFrontCtl = null;
		try {
			clientFrontCtl = (FrontController)getHessianProxyFactory(scheJob).create(scheJob.getRemoteUrl());
		} catch (Exception e) {  // HessianConnectionException
			scheExecuter.setStatus(ScheExecuterStatus.triggerFailed);
			scheExecuter.setEndTime(new Date());
			scheExecuter.setException(ScheExecuter.RESULT_FAILED);
			scheExecuter.setException(e.getMessage());
		} 
		
		return clientFrontCtl;
	}

}
