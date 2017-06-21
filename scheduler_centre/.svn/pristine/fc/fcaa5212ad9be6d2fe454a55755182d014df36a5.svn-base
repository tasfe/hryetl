package com.banggo.scheduler.job;

import java.util.regex.Pattern;

import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.SchedulerException;

/**
 * 功能：自定义任务的上下文
 *
 */
public class ScheJobContext {
	

	public final static String TARGET_APP_NAME = "targetAppName";
	public final static String TARGET_JOB_NAME = "targetJobName";
	public final static String TARGET_JOB_GROUP = "targetJobGroup";
	public final static String TARGET_EXECUTER_ID = "targetScheExecuterId";
	public final static String TARGET_IGNORE_CONCURRENCY = "targetIgnoreConcurrency";
	
	public final static int NULL_EXECUTERID = -99999;
	
	
	
	private String appName;
	private String jobName;
	private String jobGroup;
	private int executerId = NULL_EXECUTERID;
	private boolean ignoreConcurrency = false;
	


	private JobDataMap params;
	
	private JobExecutionContext qtzJobExecutionContext;
	public JobExecutionContext getQtzJobExecutionContext() {
		return qtzJobExecutionContext;
	}
	
	
	private ScheJobContext(JobDataMap params) {
		if  (params == null){
			params = new JobDataMap();
		}
		this.params = params;
	}
	
	public static ScheJobContext useJobDataMap(JobDataMap params){
		ScheJobContext context = new ScheJobContext(params);
		return context;
	}
	
	public static ScheJobContext useQtzJobExecutionContext(JobExecutionContext qtzJobExecutionContext){
		if (qtzJobExecutionContext == null){
			return useJobDataMap(null);
		}
		
		JobDataMap params = qtzJobExecutionContext.getJobDetail().getJobDataMap();	
		
		ScheJobContext context = new ScheJobContext(params);
		context.qtzJobExecutionContext = qtzJobExecutionContext;
		return context;
	}
	

	public ScheJobContext forApp(String appName) {
		this.appName = appName;
		return this;
	}

	
	public ScheJobContext withJobName(String jobName) {
		this.jobName = jobName;
		return this;
	}
	
	public ScheJobContext withJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
		return this;
	}
	
	public ScheJobContext withExecuterId(int executerId) {
		this.executerId = executerId;
		return this;
	}
	
	public ScheJobContext ignoreConcurrency (boolean ignoreConcurrency) {
		this.ignoreConcurrency = ignoreConcurrency;
		return this;
	}
	
	public String getJobName() {
		return jobName;
	}


	public String getJobGroup() {
		return jobGroup;
	}

	public String getAppName() {
		return appName;
	}
	

	public int getExecuterId() {
		return executerId;
	}
	
	public boolean isIgnoreConcurrency() {
		return ignoreConcurrency;
	}
	
	public String getQTZInstanceId(){
		String id = "";
		try {
			id = qtzJobExecutionContext.getScheduler().getSchedulerInstanceId();
		} catch (SchedulerException e) {
			// ignore
		}
		return id;
	}
	
	public boolean isManumalTriggerJob(){
		return Pattern.matches(".*_runonce_\\d+", qtzJobExecutionContext.getJobDetail().getKey().getName());
	}
	
	/*public JobDataMap getJobDataMap() {
		return params;
	}*/
	
	
	public void build(){
		params.put(TARGET_APP_NAME, this.appName);
		params.put(TARGET_JOB_NAME, this.jobName);
		params.put(TARGET_JOB_GROUP, this.jobGroup);
		params.put(TARGET_EXECUTER_ID, this.executerId);
		params.put(TARGET_IGNORE_CONCURRENCY, this.ignoreConcurrency);
	}
	
	public ScheJobContext reBuild(){
		if (params.containsKey(TARGET_APP_NAME)){
			this.appName = params.getString(TARGET_APP_NAME);
		}
		if (params.containsKey(TARGET_JOB_NAME)){
			this.jobName = params.getString(TARGET_JOB_NAME);
		}
		if (params.containsKey(TARGET_JOB_GROUP)){
			this.jobGroup = params.getString(TARGET_JOB_GROUP);
		}
		if (params.containsKey(TARGET_EXECUTER_ID)){
			this.executerId = params.getInt(TARGET_EXECUTER_ID);
		}
		if (params.containsKey(TARGET_IGNORE_CONCURRENCY)){
			this.ignoreConcurrency = params.getBoolean(TARGET_IGNORE_CONCURRENCY);
		}
		return this;
	}


	@Override
	public String toString() {
		return "ScheJobContext [appName=" + appName + ", jobName=" + jobName
				+ ", jobGroup=" + jobGroup + ", executerId=" + executerId
				+ ", ignoreConcurrency=" + ignoreConcurrency + "]";
	}

	
	
}
