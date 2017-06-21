package com.banggo.scheduler.dao.ro;

import java.util.Date;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;

public class ScheExecRecordRO {
	private String appName;

	private String jobName;

	private String jobGroup;
	
	private Integer jobId;

	private Integer execId;

	private String execNo;

	private String status;
	private String statusName;

	private Date beginTime;

	private Date endTime;

	private String remoteExecNo;

	private Date remoteExecBegin;

	private Date remoteExecEnd;

	private String remoteCancelUrl;
	
	private String result;

	private String exception;
	
	private String triggerType;
	
	

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

	public Integer getExecId() {
		return execId;
	}

	public void setExecId(Integer execId) {
		this.execId = execId;
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
		setStatusName();
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getRemoteExecNo() {
		return remoteExecNo;
	}

	public void setRemoteExecNo(String remoteExecNo) {
		this.remoteExecNo = remoteExecNo;
	}

	public Date getRemoteExecBegin() {
		return remoteExecBegin;
	}

	public void setRemoteExecBegin(Date remoteExecBegin) {
		this.remoteExecBegin = remoteExecBegin;
	}

	public Date getRemoteExecEnd() {
		return remoteExecEnd;
	}

	public void setRemoteExecEnd(Date remoteExecEnd) {
		this.remoteExecEnd = remoteExecEnd;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		if (ScheExecuter.RESULT_FAILED.equals(result)){
			this.result = "失败";
		}
		if (ScheExecuter.RESULT_SUCCESS.equals(result)){
			this.result = "成功";
		}
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public String getStatusName() {
		return statusName;
	}

	private void setStatusName() {
		// 转成名称
		ScheExecuterStatus enumStatus = ScheExecuterStatus.toEnum(this.status);
		if (enumStatus != null) {
			this.statusName = enumStatus.getName();
		}
	}

	public Integer getJobId() {
		return jobId;
	}

	public void setJobId(Integer jobId) {
		this.jobId = jobId;
	}

	public String getRemoteCancelUrl() {
		return remoteCancelUrl;
	}

	public void setRemoteCancelUrl(String remoteCancelUrl) {
		this.remoteCancelUrl = remoteCancelUrl;
	}

	public String getTriggerType() {
		return triggerType;
	}

	public void setTriggerType(String triggerType) {
		this.triggerType = triggerType;
	}
	
	
}
