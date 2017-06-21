package com.banggo.scheduler.job;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionException;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;
import com.banggo.scheduler.frontctl.FrontController;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;
import com.caucho.hessian.client.HessianProxyFactory;

/**
 * 
 * 功能: 将Quartz的任务转为自己的任务(使用自定义的表结构记录
 * 任务)
 *
 */
@SuppressWarnings("rawtypes")
public abstract class HessianJobSupport  {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(HessianJobSupport.class);

	private static final int DEFAULT_READ_TIMEOUT = 60*1000; // 60s
	private static final int DEFAULT_CONN_TIMEOUT = 30*1000; // 30s
	
	@Resource
	protected ScheJobService scheJobService;
	
	@Resource
	protected TransactionService transactionService;
	
	public void executeInTemplate(ScheJobContext context)
			throws JobExecutionException {
		
		// 查询应用的信息
		if (scheJobService == null){
			logger.error("获取scheJobService出错，无法执行");
			throw new JobExecutionException("获取scheJobService出错，无法执行");
		}
		
		ScheJob scheJob = scheJobService.retrieveActivityScheJob(context.getAppName(), context.getJobName(), context.getJobGroup());
		if (scheJob == null){
			logger.error("找不到对应的活动任务,无法触发:" + context);
			throwFatalError(context);
		}

        // 记录远程调用
		ScheExecuter scheExecuter = createScheExecuter(context, scheJob);
		if (scheExecuter == null){
			logger.error("创建ScheExecuter失败，无法执行:" +  context);
			throw new JobExecutionException("创建ScheExecuter失败，无法执行");
		}
	
		// 执行远程调用
		FrontController frontCtl = createClientFrontController(context, scheJob,scheExecuter);
		if (frontCtl != null ){
			doScheJob(scheExecuter,frontCtl,scheJob.getJobName(), scheJob.getJobGroup(), buildScheJobParam(scheExecuter,scheJob));
		}else{
			logger.error("创建的远程前端控制器失败，无法执行远程方法:" +  context);
		}
		
		// 保存远程调用结果   （如果保存结果时发生异常，结果没有正常保存，则可能存在一条状态为初始的执行记录.
		// 对并行的任务无影响；对串行的任务，5分钟后将忽略该记录）
		scheJobService.updateScheExecuter(scheExecuter);		
	}

	/**
	 * @param context
	 * @throws JobExecutionException
	 */
	protected void throwFatalError(ScheJobContext context)
			throws JobExecutionException {
		// 找到任务相关的信息，不再触发该任务
		JobExecutionException fatalError =  new JobExecutionException("找不到任务信息,不再触发任务:" + context);
		fatalError.setUnscheduleFiringTrigger(true);
		throw fatalError;
	}

	
	/**
	 * @param scheJob
	 * @return
	 */
	protected HessianProxyFactory getHessianProxyFactory(ScheJob scheJob){
		long connectTimeout = (scheJob.getConnectTimeout() == null ) ? DEFAULT_CONN_TIMEOUT : 
			                  (scheJob.getConnectTimeout() <= 0) ? DEFAULT_CONN_TIMEOUT :scheJob.getConnectTimeout();
			
		long readTimeout =  (scheJob.getReadTimeout() == null ) ? DEFAULT_READ_TIMEOUT :
							(scheJob.getReadTimeout() <= 0 )? DEFAULT_READ_TIMEOUT : scheJob.getReadTimeout();
		
		HessianProxyFactory  factory = new HessianProxyFactory ();
	    factory.setConnectTimeout(connectTimeout);
	    factory.setReadTimeout(readTimeout);
	    
	    // 构造远程对象
	  //  Task task  = (Task)factory.create(StringUtils.trim(scheJob.getRemoteUrl()));
		
		return factory;
	}
	

	
	/**
	 * @param scheJob
	 * @return
	 */
	@SuppressWarnings({"unchecked" })
	protected Map buildScheJobParam(ScheExecuter scheExecuter,ScheJob scheJob){
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
	 * @param scheExecuter
	 * @param task
	 * @param jobName
	 * @param jobGroup
	 * @param params
	 */
	protected abstract void doScheJob(ScheExecuter scheExecuter,FrontController frontCtl,String jobName,String jobGroup,Map params);
    
	/**
	 * @param context
	 * @param scheJob
	 * @return
	 */
	protected abstract ScheExecuter createScheExecuter(ScheJobContext context,ScheJob scheJob);
	
	/**
	 * @param context
	 * @param scheJob
	 * @param scheExecuter
	 * @return
	 */
	protected abstract FrontController createClientFrontController(ScheJobContext context,ScheJob scheJob,ScheExecuter scheExecuter);
	
	
}

