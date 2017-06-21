package com.banggo.scheduler.manager;

import static org.quartz.SimpleScheduleBuilder.simpleSchedule;
import static org.quartz.TriggerBuilder.newTrigger;

import java.util.Date;

import org.apache.log4j.Logger;
import org.quartz.JobDataMap;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;

import com.banggo.scheduler.manager.exception.QtzJobConstructException;

public abstract class QuartzJobConstruct {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(QuartzJobConstruct.class);

	protected Scheduler quartzScheduler;
	protected JobDataMap params;

	public QuartzJobConstruct(Scheduler quartzScheduler) {
		this.quartzScheduler = quartzScheduler;
	}

	protected JobDataMap buildJobDataMap() {
		return new JobDataMap();
	}

	protected abstract void buildScheJobContext();

	protected abstract JobDetail buildJobDetail();

	protected abstract Trigger buildTrigger();
	
	/**
	 * 一次运行一次的触发器
	 * @return
	 */
	protected Trigger buildOneTimeTrigger() {

		Trigger trigger = newTrigger()
				.startNow()
				.withPriority(10)
				.withSchedule(
						simpleSchedule()
								.withMisfireHandlingInstructionIgnoreMisfires())
				.build();
		return trigger;
	}
	

	public void construct() throws QtzJobConstructException {
		// 构建JobDataMap
		this.params = buildJobDataMap();
		
		// 构建自定义任务的上下文
		buildScheJobContext();

		// 构建JobDetail
		JobDetail jobDetail = buildJobDetail();
		
		// 构建Trigger
		Trigger trigger = buildTrigger();

		// 将任务加到Quartz中调度
		try {
			// 先删除旧的任务
			boolean isFoundAndDelete = quartzScheduler.deleteJob(jobDetail.getKey());
			if (logger.isInfoEnabled()){
				logger.info("从Quartz中寻找并删除同名的任务:" + jobDetail.getKey() + " 结果:" + isFoundAndDelete);
			}
			
			// 再增加新的任务
			Date firstTriggerDate = quartzScheduler.scheduleJob(jobDetail, trigger);
			
			if (logger.isInfoEnabled()){
			  logger.info("任务预计触发时间:" + firstTriggerDate);
			}
			
		} catch (SchedulerException e) {
			logger.error("construct()", e);
			
			throw new QtzJobConstructException("Quartz中增加任务失败");
		}
	}
}
