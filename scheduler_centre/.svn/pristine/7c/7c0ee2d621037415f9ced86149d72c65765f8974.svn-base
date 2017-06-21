package com.banggo.scheduler.executer;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;
import com.banggo.scheduler.frontctl.FrontController;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.ro.ExecuteRO;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;
import com.banggo.scheduler.support.QtzSchedulerInstanceIdHolder;
import com.caucho.hessian.client.HessianProxyFactory;

/**
 * 远程调用类型的任务执器
 * @author wuxin
 *
 */
@SuppressWarnings({"unchecked", "rawtypes" })
public class HessianJobExecuter {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(HessianJobExecuter.class);
	
	private static final int DEFAULT_READ_TIMEOUT = 60*1000; // 60s
	private static final int DEFAULT_CONN_TIMEOUT = 30*1000; // 30s
	
	@Resource
	protected ScheJobService scheJobService;
	
	@Resource
	protected TransactionService transactionService;
	
	@Autowired
	@Qualifier("propertiesFactory")
	private Properties properties;
	
	/**
	 * 执行指定的任务
	 * 
	 * @param scheJobId
	 * @param qtzInstanceId
	 *            执行该任务的Quartz实例ID
	 * @return ScheExecuter
	 * @throws ExecuteException
	 */
	public ScheExecuter execute(int scheJobId)
			throws ExecuteException {
		ScheJob scheJob = scheJobService.retrieveScheJob(scheJobId);
		if (scheJob == null
				|| ScheJob.IS_DELETE_TRUE.equals(scheJob.getIsDelete())) {
			logger.error("找不到对应的活动任务,无法触发:" + scheJob);
			throw new ExecuteException("找不到对应的活动任务,无法触发:" + scheJob);
		}

		// 记录远程调用
		ScheExecuterWrapper scheExecuterWrapper = createScheExecuter(scheJobId,QtzSchedulerInstanceIdHolder.getQtzSchedulerInstanceId());
		if (scheExecuterWrapper == null){
			throw new ExecuteException("无法创建执行记录" + scheJob);
		}
		
		if (scheExecuterWrapper.isJoin) {
			// 已经存在正在运行的任务
			return scheExecuterWrapper.scheExecuter;
			
		} else {
			ScheExecuter scheExecuter = scheExecuterWrapper.scheExecuter;
			// 执行远程调用
			FrontController frontCtl = createClientFrontController(scheJob,scheExecuterWrapper.scheExecuter);
			if (frontCtl != null) {
				doScheJob(scheExecuter, frontCtl, scheJob.getJobName(),
						scheJob.getJobGroup(),
						buildScheJobParam(scheExecuter, scheJob));
			} else {
				logger.error("创建的远程前端控制器失败，无法执行远程方法:" + scheExecuter);
			}

			// 保存远程调用结果 （如果保存结果时发生异常，结果没有正常保存，则可能存在一条状态为初始的执行记录.
			// 对并行的任务无影响；对串行的任务，5分钟后将忽略该记录）
			scheJobService.updateScheExecuter(scheExecuter);
			
			return scheExecuter;
		}
	}

	/**
	 * @param scheJobId
	 * @param qtzInstanceId
	 * @return
	 */
	private ScheExecuterWrapper createScheExecuter(int scheJobId,String qtzInstanceId) {
		ScheExecuterWrapper result = null; 

		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			ScheJob scheJob = scheJobService.lock(scheJobId); // 上锁
			if (scheJob == null) {
				throw new ExecuteException("无法锁定任务：" + scheJobId + "触发失败");
			}
			
            // 检查串行并行设置
			if (!ScheJob.ALLOW_CONCURRENT.equalsIgnoreCase(scheJob.getIsAllowConcurrent())){ // 串行
				// 检查是否有相同的任务正在运行
				ScheExecuter runningTask = getRunningExecuterId(scheJob.getAppName(),scheJob.getJobName(),scheJob.getJobGroup());
				if (runningTask != null){
					result = new ScheExecuterWrapper(runningTask,true);
				}
			}
			
			result = (result == null)? new ScheExecuterWrapper(scheJobService.createScheExecuter(scheJobId,qtzInstanceId),false):result;
 
			// 解锁
			transactionService.commit(ts);
		} catch (Throwable t) {
			logger.error(t);
			transactionService.rollback(ts);
		}

		return result;
	}
	
	/**
	 * @param appName
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	private ScheExecuter getRunningExecuterId(String appName,String jobName, String jobGroup){
		List<ScheExecuter> runningJobList = scheJobService.retrieveRunningScheJob(appName,jobName, jobGroup);
		if (runningJobList != null && !runningJobList.isEmpty()){
			// 有任务正在运行
			logger.warn("任务:" + jobName+"(" + jobGroup +  ") 有正在运行的实例 ("+ runningJobList.get(0).getExecNo() + ")" );
			return  runningJobList.get(0);
		}
		return null;
	}

   
   /**
	 * @param scheJob
	 * @return
	 */
	private HessianProxyFactory getHessianProxyFactory(ScheJob scheJob){
		long connectTimeout = (scheJob.getConnectTimeout() == null ) ? DEFAULT_CONN_TIMEOUT : 
			                  (scheJob.getConnectTimeout() <= 0) ? DEFAULT_CONN_TIMEOUT :scheJob.getConnectTimeout();
			
		long readTimeout =  (scheJob.getReadTimeout() == null ) ? DEFAULT_READ_TIMEOUT :
							(scheJob.getReadTimeout() <= 0 )? DEFAULT_READ_TIMEOUT : scheJob.getReadTimeout();
		
		HessianProxyFactory  factory = new HessianProxyFactory ();
	    factory.setConnectTimeout(connectTimeout);
	    factory.setReadTimeout(readTimeout);
		
		return factory;
	}
	

	
	/**
	 * @param scheJob
	 * @return
	 */
	
	private Map buildScheJobParam(ScheExecuter scheExecuter,ScheJob scheJob){
		Map result = new HashMap();
		if (scheJob == null  ){
			return result;
		}
		
		result.put(FrontController.EXECUTE_NO_KEY, scheExecuter.getExecNo());
		
		List<ScheJobParams> scheJobParamsList = scheJob.getScheJobParamsList();
		if (scheJobParamsList == null || scheJobParamsList.isEmpty()){
			return result;
		}
		for (ScheJobParams scheJobParams : scheJobParamsList) {
			result.put(scheJobParams.getName(), scheJobParams.getValue());
		}
		return result;
	}
	
	/**
	 * @param scheJob
	 * @param scheExecuter
	 * @return
	 */
	private FrontController createClientFrontController(ScheJob scheJob,
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
	
	/**
	 * @param scheExecuter
	 * @param clientFrontCtl
	 * @param jobName
	 * @param jobGroup
	 * @param params
	 */
	private void doScheJob(ScheExecuter scheExecuter,FrontController clientFrontCtl, String jobName, String jobGroup,
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
	
	/**
	 * @param params
	 */
	private void setCallBackUrl(Map params) {
		String callbackUrl = properties.getProperty("scheduler.centre.callback.url");
		params.put(FrontController.CALL_BACK_URL_KEY, callbackUrl);
	}
	
	
	/**
	 * 包装类
	 *
	 */
	private class ScheExecuterWrapper {
		private ScheExecuter scheExecuter;
		private boolean isJoin; // 是否加入之前存在的任务

		ScheExecuterWrapper(ScheExecuter scheExecuter, boolean isJoin) {
			this.scheExecuter = scheExecuter;
			this.isJoin = isJoin;
		}
	}

}
