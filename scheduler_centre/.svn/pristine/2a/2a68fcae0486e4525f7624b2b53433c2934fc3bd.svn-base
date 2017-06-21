package com.banggo.scheduler.manager.impl;

import static com.banggo.scheduler.manager.util.JobUtils.buildJobGroupName;
import static com.banggo.scheduler.manager.util.JobUtils.buildJobName;
import static org.quartz.CronScheduleBuilder.cronSchedule;
import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.newTrigger;

import java.util.Calendar;
import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.job.ScheJobContext;
import com.banggo.scheduler.job.builder.ScheJobBuilder;
import com.banggo.scheduler.job.builder.ScheJobBuilderFactory;
import com.banggo.scheduler.manager.JobManager;
import com.banggo.scheduler.manager.QuartzJobConstruct;
import com.banggo.scheduler.manager.exception.QtzJobConstructException;
import com.banggo.scheduler.manager.exception.SchedulerException;
import com.banggo.scheduler.manager.util.JobUtils;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;

public class JobManagerImpl implements JobManager {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JobManagerImpl.class);
    
	
	private Scheduler quartzScheduler;
	
	@Resource
	private ScheJobService scheJobService;
	
	@Resource
	private ScheJobBuilderFactory builderFactory;
	
	@Resource
	private TransactionService transactionService;
	
	public void setQuartzScheduler(Scheduler quartzScheduler) {
		this.quartzScheduler = quartzScheduler;
	}
   
	public long addJob(ScheJob job) throws SchedulerException {
		assertValidate(job);
		
		long pk = -1; 
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			// 保存任务
			pk = scheJobService.saveJob(job);
			
			// Quartz 中增加任务 
			addQuartzJob(job);
			
			transactionService.commit(ts);  // 提交事务
		} catch (Throwable t) {
			logger.error("addJob(ScheJob)", t);

			pk = -1;
			transactionService.rollback(ts); // 回滚事务
		}
		return pk;
	}


	private void assertValidate(ScheJob job) throws SchedulerException {
		if (job == null || StringUtils.isEmpty(job.getAppName())
				|| StringUtils.isEmpty(job.getJobName())
				|| StringUtils.isEmpty(job.getCronExp())) {
			throw new SchedulerException("任务参数异常");
		}
	}

	public long updateJob(ScheJob job) throws SchedulerException {
		// 查找任务
		ScheJob oldJob = scheJobService.retrieveScheJob(job.getId());
		if (oldJob == null) {
			throw new SchedulerException("任务:" + job.getId() + "不存在");
		}
		
		if (logger.isInfoEnabled()){
			logger.info("更新任务，old=" + oldJob + " new=" + job);
		}

		int rtnCount = 0;
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			rtnCount = scheJobService.updateScheJob(job,true);
			if (ScheJob.STATUS_NOMAL.equals(job.getStatus())){ // 处理停止状态的任务不加入调度
			
				// 删除旧的Quartz任务
				quartzScheduler.deleteJob(new JobKey(buildJobName(oldJob),
						JobUtils.buildJobGroupName(oldJob)));
				
				 // Quartz里增加任务
				addQuartzJob(job);
			}
			
			transactionService.commit(ts);
		} catch (Throwable e) {
			logger.error("updateJob(ScheJob)", e);

			transactionService.rollback(ts);
			throw new SchedulerException("任务:" + job.getId()  + "更新失败，原因:" + e);
		}

		return rtnCount;
	}

	public int deleteJob(int scheJobId) throws SchedulerException {

		// 查找任务
		ScheJob scheJob = scheJobService.retrieveScheJob(scheJobId);
		if (scheJob == null){
			throw new SchedulerException("任务:" + scheJobId + "不存在");
		}
		
		if (logger.isInfoEnabled()){
			logger.info("删除任务" + scheJobId);
		}
		
		scheJob.setIsDelete(ScheJob.IS_DELETE_TRUE);
		
		int rtnCount = 0;
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			rtnCount = scheJobService.updateScheJob(scheJob,false);
			quartzScheduler.deleteJob(new JobKey(buildJobName(scheJob),JobUtils.buildJobGroupName(scheJob)));
			transactionService.commit(ts);
		} catch (Throwable e) {
			logger.error("deleteJob(int)", e);

			transactionService.rollback(ts);
			throw new SchedulerException("任务:" + scheJobId + "删除失败，原因:" + e);
		}
		
		return rtnCount;
	
	}

	public boolean pauseJob(int scheJobId) throws SchedulerException {
		// 查找任务
		ScheJob scheJob = scheJobService.retrieveScheJob(scheJobId);
		if (scheJob == null){
			throw new SchedulerException("任务:" + scheJobId + "不存在");
		}
		
		if (logger.isInfoEnabled()){
			logger.info("暂停任务" + scheJobId);
		}
		
		scheJob.setStatus(ScheJob.STATUS_STOP);
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			scheJobService.updateScheJob(scheJob,false);
			quartzScheduler.deleteJob(new JobKey(buildJobName(scheJob),JobUtils.buildJobGroupName(scheJob)));
			transactionService.commit(ts);
		} catch (Throwable e) {
			logger.error("pauseJob(int)", e);

			transactionService.rollback(ts);
			throw new SchedulerException("任务:" + scheJobId + "停止失败，原因:" + e);
		}
		
		return true;
	}

	public boolean resumeJob(int scheJobId) throws SchedulerException {
		
		if (logger.isInfoEnabled()){
			logger.info("恢复任务" + scheJobId);
		}
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			ScheJob scheJob = scheJobService.lock(scheJobId);
			if (scheJob == null) {
				// roll back at catch
				throw new SchedulerException("任务:" + scheJobId + " 不存在");
			}
			
			if (ScheJob.STATUS_NOMAL.equals(scheJob.getStatus())){
				// 已经是正常状态了
				throw new SchedulerException("任务:" + scheJobId + " 已经处于正常状态");
			}
			
			scheJob.setStatus(ScheJob.STATUS_NOMAL);
			
			// 检查任务开始结束时间设置
			Date begin = scheJob.getBeginDate();
			Date end = scheJob.getEndDate();
			Date now = new Date();
            
			if (begin == null){
				scheJob.setBeginDate(now);
			}
			
			if (end != null){
				if (end.before(now) || end.before(begin)){
					throw new SchedulerException("任务:" + scheJobId + "结束时间小于开始时间或小于当前时间");	
				}
			}
			
			scheJobService.updateScheJob(scheJob,false);
 
            // Quartz里增加任务
			addQuartzJob(scheJob);
			
			transactionService.commit(ts);
		} catch (Throwable e) {
			logger.error("resumeJob(int)", e);

			transactionService.rollback(ts);
			throw new SchedulerException(e.getMessage());
		}

		return true;
	}
	

	/**
	 * @param job
	 * @throws SchedulerException
	 */
	private void addQuartzJob(final ScheJob job) throws SchedulerException {
		try {
			new QuartzJobConstruct(quartzScheduler) {
				
				@Override
				protected void buildScheJobContext() {
					ScheJobContext.useJobDataMap(params).forApp(job.getAppName())
					.withJobName(job.getJobName())
					.withJobGroup(job.getJobGroup()).build();
					
				}
				
				@Override
				protected JobDetail buildJobDetail() {
					ScheJobBuilder jobBuilder = builderFactory.getScheJobBuilder(job.getType());
					JobDetail jobDetail = newJob(jobBuilder.getJobClass())
							.usingJobData(params)
							.withIdentity(buildJobName(job), buildJobGroupName(job))
							.build();
					return jobDetail;
				}
				
				@Override
				protected Trigger buildTrigger() {
					Date beginDate = job.getBeginDate() == null ? new Date(): job.getBeginDate();
					
					Calendar calendar = Calendar.getInstance();
					calendar.add(Calendar.YEAR, 50); // just for replace the 'if' statement
					Date endDate = job.getEndDate() == null ? calendar.getTime() : job.getEndDate();
					
					Trigger trigger = newTrigger()
							.startAt(beginDate)
							.endAt(endDate)
							.withSchedule(cronSchedule(job.getCronExp()).withMisfireHandlingInstructionDoNothing())
							.build();
					return trigger;
				}
			}.construct();
		} catch (QtzJobConstructException e) {
			logger.error("addQuartzJob(ScheJob)", e);

			throw new SchedulerException(e.getMessage());
		}
	}

}
