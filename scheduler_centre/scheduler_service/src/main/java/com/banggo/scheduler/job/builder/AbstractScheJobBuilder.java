package com.banggo.scheduler.job.builder;

import java.util.Date;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;
import com.banggo.scheduler.job.JobAdapter;
import com.banggo.scheduler.manager.ExecuteManager;
import com.banggo.scheduler.manager.JobManager;
import com.banggo.scheduler.manager.exception.SchedulerException;
import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;

public abstract class AbstractScheJobBuilder implements ScheJobBuilder {


	@Resource
	private JobManager jobManager;
	
	@Resource
	private ScheJobService scheJobService;
	
	@Resource
	private ScheBaseService scheBaseService;
	@Resource
	private ExecuteManager executeManager;
	
	@Resource
	private TransactionService transactionService;
	
	@Override
	public String validateScheJob(ScheJob job) {
		String errorFiled = null;
        if (job == null){
    	  errorFiled = "任务不能为空";
    	  return errorFiled;
        }
        
		if (StringUtils.isEmpty(job.getAppName())) {
			errorFiled = "应用名称格式不对";
		} else if (StringUtils.isEmpty(job.getJobName())) {
			errorFiled = "任务名格式不对";
		} else if (StringUtils.isEmpty(job.getJobGroup())) {
			errorFiled = "任务组名格式不对";
		} else if (StringUtils.isEmpty(job.getCronExp())) {
			errorFiled = "Cron表达式格式不对";
		} else if (job.inValidateCron()) {
			errorFiled = "Cron表达式格式不对";
		} else if (job.inValidateDate()) {
			errorFiled = "开始结束时间格式不对";
		}

		return errorFiled;
	}

	@Override
	public String validateScheJobParams(ScheJob job) {
		return null;
	}

	@Override
	public void beforeCreate(ScheJob job) throws SchedulerException {
		// 检查是否存在
		ScheJob oldScheJob = scheJobService.retrieveActivityScheJob(job.getAppName(), job.getJobName(), job.getJobGroup());
		if (oldScheJob != null){
			throw new SchedulerException ("已经存在相同的任务，不能重复创建");
		}
				
		if (job.getBeginDate() == null ){
			job.setBeginDate(new Date());
		}
	}

	@Override
	public long create(ScheJob job) throws SchedulerException {
		return jobManager.addJob(job);
	}

	@Override
	public void beforeUpdate(ScheJob job) throws SchedulerException {
		checkExists(job);
	}
	
	
	@Override
	public int update(ScheJob job) throws SchedulerException {
		return ((Long)jobManager.updateJob(job)).intValue();
	}
	
	@Override
	public void beforeDelete(ScheJob job) throws SchedulerException {
		// do nothing
	}

	@Override
	public int delete(ScheJob job)  throws SchedulerException{
		return jobManager.deleteJob(job.getId());
	}

	@Override
	public boolean pause(ScheJob job) throws SchedulerException {
		return jobManager.pauseJob(job.getId());
	}

	@Override
	public boolean resume(ScheJob job) throws SchedulerException {
		return jobManager.resumeJob(job.getId());
	}

	@Override
	public boolean trigger(ScheJob job, boolean ignoreConcurrent)  throws SchedulerException{
		
		// 记录操作者
		ScheManualTrigger manualOp = new ScheManualTrigger();
		manualOp.setScheJobId(job.getId());
		manualOp.setOperateBy("system");
		if (ignoreConcurrent){
			manualOp.setTriggerType(ScheManualTrigger.TRIGGERTYPE_TRIGGER_FORCE);
		}else{
			manualOp.setTriggerType(ScheManualTrigger.TRIGGERTYPE_TRIGGER);
		}
		
		boolean result = false;
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			scheBaseService.saveManualOp(manualOp);
			result= executeManager.runImmediately(job,ignoreConcurrent);
			transactionService.commit(ts);
			
		} catch (Exception e) {
			transactionService.rollback(ts);
			throw new SchedulerException(e);
		} 
		
		return result;
	}

	private void checkExists(ScheJob job) throws SchedulerException{
		ScheJob oldScheJob = scheJobService.retrieveScheJob(job.getId());
		if (oldScheJob == null){
			 throw new SchedulerException ("任务" + job.getId() + " 不存在");
		}
	}
	
	@Override
	public abstract Class<? extends JobAdapter> getJobClass() ;

}
