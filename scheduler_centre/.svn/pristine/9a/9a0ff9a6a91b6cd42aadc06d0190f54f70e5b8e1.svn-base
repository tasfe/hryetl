package com.banggo.scheduler.manager;

import static org.quartz.JobBuilder.newJob;

import javax.annotation.Resource;

import org.junit.After;
import org.junit.Test;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.job.proxy.HessianInterruptJobProxy;
import com.banggo.scheduler.manager.exception.QtzJobConstructException;
import com.banggo.scheduler.service.transaction.TransactionService;

public class QuartzSchedulerTest extends SpringTestCase {
   
	@Resource
	private Scheduler quartzScheduler;
	
	@Resource
	private TransactionService transactionService;
	
	@Test
	public void testTransaction(){
		TransactionStatus ts = transactionService.begin(); // 启动事务
		
		try {
			new QuartzJobConstruct(quartzScheduler) {
				
				@Override
				protected Trigger buildTrigger() {
					// TODO Auto-generated method stub
					return buildOneTimeTrigger();
				}
				
				@Override
				protected void buildScheJobContext() {
					// TODO Auto-generated method stub
					
				}
				
				@Override
				protected JobDetail buildJobDetail() {
					
					JobDetail jobDetail = newJob(HessianInterruptJobProxy.class)
							.usingJobData(params)
							.withIdentity("trans1","trans1").build();
					return jobDetail;
					
				}
			}.construct();
		} catch (QtzJobConstructException e) {
			
		}
		
		transactionService.commit(ts);
   }
	
	@After
	public void delete() throws SchedulerException{
		quartzScheduler.deleteJob(new JobKey("trans1", "trans1"));
	}
}
