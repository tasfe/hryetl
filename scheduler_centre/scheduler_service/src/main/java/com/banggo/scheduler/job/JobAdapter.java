package com.banggo.scheduler.job;

import org.apache.log4j.Logger;

import org.apache.commons.lang.time.StopWatch;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.Scheduler;
import org.quartz.SchedulerContext;
import org.quartz.SchedulerException;

/**
 * 
 * 功能: 将Quartz的任务转为自己的任务(使用自定义的表结构记录
 * 任务)
 *
 */
public abstract class JobAdapter implements Job {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JobAdapter.class);


	@Override
	public void execute(JobExecutionContext qtzJobContext)
			throws JobExecutionException {
		
		// 重建自定义任务上下文
		ScheJobContext scheJobContext = ScheJobContext.useQtzJobExecutionContext(qtzJobContext).reBuild();
		
		// do some preCheck
		Scheduler scheduler = qtzJobContext.getScheduler();
		if (scheduler == null){
			throw new JobExecutionException("构建scheduler出错，执行结束");
		}
		
		SchedulerContext qtzSchedulerCtx = null;
		try {
			 qtzSchedulerCtx = scheduler.getContext();
		} catch (SchedulerException e) {
			throw new JobExecutionException("构建schedulerContext出错，执行结束," + e.getMessage());
		}
		
		if (qtzSchedulerCtx == null){
			throw new JobExecutionException("schedulerContext为空，执行结束" );
		}
		
		StopWatch watch = new StopWatch();
		watch.start(); // 计时
		if (logger.isInfoEnabled()){
			logger.info(this.getClass().getName() + " 开始执行:" + scheJobContext);
		}
		
		// 执行
		IScheJob job = (IScheJob)qtzSchedulerCtx.get(getJobInterfaceName());
		job.execute(scheJobContext);
				
		watch.stop(); // 结束计时
		if (logger.isInfoEnabled()){
			logger.info("执行结束,用时:" + watch.getTime());
		}
	}

	protected abstract String getJobInterfaceName() ;

}

