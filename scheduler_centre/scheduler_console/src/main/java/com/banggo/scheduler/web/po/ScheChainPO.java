package com.banggo.scheduler.web.po;


public class ScheChainPO {

	private String appName;

	private String jobName;

	private String jobGroup;

	private String queryVersion; // 任务链版本


	private String scheChainName;

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getJobGroup() {
		return jobGroup;
	}

	public void setJobGroup(String jobGroup) {
		this.jobGroup = jobGroup;
	}

	

	public String getScheChainName() {
		return scheChainName;
	}

	public void setScheChainName(String scheChainName) {
		this.scheChainName = scheChainName;
	}

	public String getQueryVersion() {
		return queryVersion;
	}

	public void setQueryVersion(String queryVersion) {
		this.queryVersion = queryVersion;
	}

   
}
