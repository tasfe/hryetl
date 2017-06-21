package com.banggo.scheduler.web.po;

import java.util.Date;

public class ScheChainExecRecordPO {

	private String appName;

	private String jobName;

	private String jobGroup;

	private String execNo; // 任务链编号
  
	private String status ; // 任务链执行状态

	private Date beginTimeFrom; // 任务链开始执行时间

	private Date beginTimeTo; // 任务链结束执行时间
	
	private Integer scheChianExecuterId;
	
	private String scheChainName;
	
	private Integer jobId;

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

	public String getExecNo() {
		return execNo;
	}

	public void setExecNo(String execNo) {
		this.execNo = execNo;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getBeginTimeFrom() {
		return beginTimeFrom;
	}

	public void setBeginTimeFrom(Date beginTimeFrom) {
		this.beginTimeFrom = beginTimeFrom;
	}

	public Date getBeginTimeTo() {
		return beginTimeTo;
	}

	public void setBeginTimeTo(Date beginTimeTo) {
		this.beginTimeTo = beginTimeTo;
	}

	public Integer getScheChianExecuterId() {
		return scheChianExecuterId;
	}

	public void setScheChianExecuterId(Integer scheChianExecuterId) {
		this.scheChianExecuterId = scheChianExecuterId;
	}

	public String getScheChainName() {
		return scheChainName;
	}

	public void setScheChainName(String scheChainName) {
		this.scheChainName = scheChainName;
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	

	


}
