package com.banggo.scheduler.manager.impl;

import static com.banggo.scheduler.manager.util.JobUtils.buildJobGroupName;
import static com.banggo.scheduler.manager.util.JobUtils.buildJobName;
import static org.quartz.JobBuilder.newJob;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.Trigger;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.job.ScheJobContext;
import com.banggo.scheduler.job.builder.ScheJobBuilder;
import com.banggo.scheduler.job.builder.ScheJobBuilderFactory;
import com.banggo.scheduler.job.proxy.HessianInterruptJobProxy;
import com.banggo.scheduler.manager.ExecuteManager;
import com.banggo.scheduler.manager.QuartzJobConstruct;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.manager.exception.QtzJobConstructException;
import com.banggo.scheduler.service.ScheJobService;

public class ExecuteManagerImpl implements ExecuteManager {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ExecuteManagerImpl.class);

	
	private Scheduler quartzScheduler;
	
	@Resource
	private ScheJobBuilderFactory builderFactory;
	
	@Resource
	private ScheJobService scheJobService;
	
	public void setQuartzScheduler(Scheduler quartzScheduler) {
		this.quartzScheduler = quartzScheduler;
	}
	
	@Override
	public void interrupt(final int scheExecuterId) throws ExecuteException {
		final ScheJob job = scheJobService
				.getScheJobByExecuterId(scheExecuterId);
		if (job == null) {
			throw new ExecuteException("对应的Job不存在");
		}

		if (logger.isInfoEnabled()){
		   logger.info(job + " 增加中断类型元任务!" );	
		}
		
		try {
			new QuartzJobConstruct(quartzScheduler) {
				private  final String _CANCEL = "_cancel_" + scheExecuterId;
				
				@Override
				protected void buildScheJobContext() {
					ScheJobContext.useJobDataMap(params)
							.forApp(job.getAppName())
							.withJobName(job.getJobName())
							.withJobGroup(job.getJobGroup())
							.withExecuterId(scheExecuterId).build();
				}

				@Override
				protected JobDetail buildJobDetail() {
					JobDetail jobDetail = newJob(HessianInterruptJobProxy.class)
							.usingJobData(params)
							.withIdentity(buildJobName(job) + _CANCEL,
									buildJobGroupName(job) + _CANCEL).build();
					return jobDetail;
				}

				@Override
				protected Trigger buildTrigger() {
					return buildOneTimeTrigger();
				}

			}.construct();
		} catch (QtzJobConstructException e) {
			logger.error("interrupt(int)", e);
			
			throw new ExecuteException(e.getMessage());
		}

	}
	

	@Override
	public boolean runImmediately(int scheJobId, final boolean ignoreConcurrency)
			throws ExecuteException {

		final ScheJob job = scheJobService.retrieveScheJob(scheJobId);
		return runImmediately(job,ignoreConcurrency);
	}
	
	
	@Override
	public boolean runImmediately(int scheJobId) throws ExecuteException {
		return runImmediately(scheJobId,false);
	}

	@Override
	public boolean runImmediately(final ScheJob job, final boolean ignoreConcurrency)
			throws ExecuteException {
		
		if (job == null) {
			throw new ExecuteException("对应的Job不存在");
		}
		
		if (logger.isInfoEnabled()){
			   logger.info(job + " 增加立即触发元任务!ignoreConcurrency = " +  ignoreConcurrency);	
		  }

		try {
			new QuartzJobConstruct(quartzScheduler) {
				private  final String _RUNONCE = "_runonce_" + job.getId();
				
				@Override
				protected void buildScheJobContext() {
					ScheJobContext.useJobDataMap(params)
							.forApp(job.getAppName())
							.withJobName(job.getJobName())
							.withJobGroup(job.getJobGroup())
							.ignoreConcurrency(ignoreConcurrency).build();

				}

				@Override
				protected JobDetail buildJobDetail() {
					ScheJobBuilder jobBuilder = builderFactory.getScheJobBuilder(job.getType());
					JobDetail jobDetail = newJob(jobBuilder.getJobClass())
							.usingJobData(params)
							.withIdentity(buildJobName(job) + _RUNONCE,
									buildJobGroupName(job) + _RUNONCE).build();
					return jobDetail;
				}

				@Override
				protected Trigger buildTrigger() {
					return buildOneTimeTrigger();
				}

			}.construct();
		} catch (QtzJobConstructException e) {
			logger.error("runImmediately(int, boolean)", e);

			throw new ExecuteException(e.getMessage());
		}
		return true;

	}


}
