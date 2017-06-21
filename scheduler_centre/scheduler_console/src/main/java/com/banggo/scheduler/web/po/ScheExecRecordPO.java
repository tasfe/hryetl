package com.banggo.scheduler.web.po;

import java.util.Date;

public class ScheExecRecordPO {

	private String appName;

	private String jobName;

	private String jobGroup;

	private String execNo;

	private String status ;

	private Date beginTimeFrom;

	private Date beginTimeTo;

	private String remoteExecNo;
	
	private String result;
	
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

	public String getRemoteExecNo() {
		return remoteExecNo;
	}

	public void setRemoteExecNo(String remoteExecNo) {
		this.remoteExecNo = remoteExecNo;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}


}
