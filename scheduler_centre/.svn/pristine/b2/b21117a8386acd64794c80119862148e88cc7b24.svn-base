package com.banggo.scheduler.dao.dataobject;

import java.util.Date;

public class ScheExecuter {
	
	public static final String RESULT_SUCCESS = "1";
	public static final String RESULT_FAILED = "0";
	
    
    private Integer id;

  
    private Integer scheJobId;

  
    private String execNo;

  
    private String status;

  
    private Date beginTime;

  
    private Date endTime;

   
    private String remoteExecNo;

   
    private Date remoteExecBegin;

   
    private Date remoteExecEnd;

   
    private String remoteCancelUrl;

   
    private String result;

    private String exception;

    private Date createDate;

    private Date updateDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getScheJobId() {
		return scheJobId;
	}

	public void setScheJobId(Integer scheJobId) {
		this.scheJobId = scheJobId;
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
	public void setStatus(ScheExecuterStatus status) {
		this.status = status.getCode();
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

	public String getRemoteCancelUrl() {
		return remoteCancelUrl;
	}

	public void setRemoteCancelUrl(String remoteCancelUrl) {
		this.remoteCancelUrl = remoteCancelUrl;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	public void setResult(boolean result) {
		this.result = result ? RESULT_SUCCESS : RESULT_FAILED;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		this.exception = exception;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "ScheExecuter [id=" + id + ", scheJobId=" + scheJobId
				+ ", execNo=" + execNo + ", status=" + status + ", beginTime="
				+ beginTime + ", endTime=" + endTime + ", remoteExecNo="
				+ remoteExecNo + ", remoteExecBegin=" + remoteExecBegin
				+ ", remoteExecEnd=" + remoteExecEnd + ", remoteCancelUrl="
				+ remoteCancelUrl + ", result=" + result + ", exception="
				+ exception + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}

  
}