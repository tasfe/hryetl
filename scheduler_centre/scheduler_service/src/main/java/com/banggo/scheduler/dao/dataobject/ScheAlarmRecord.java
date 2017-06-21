package com.banggo.scheduler.dao.dataobject;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

public class ScheAlarmRecord {
	public static final String NOTIFY_RESULT_SUCCESS = "1";
	public static final String NOTIFY_RESULT_FAILED = "0";
	
	public static final String STATUS_NOTIFY = "1";
	public static final String STATUS_UNNOTIFY = "0" ;
	
	private Integer id;
	private Integer scheJobId;
	private Integer scheAlarmId;
	private Integer scheExecId;
	private Date alarmTime;
	private Integer scheUserGroupId;
	private String result;
	private String status;
	private Integer retryCount;
	private Date createDate;
	private Date updateDate;
	
	private Set mailTo = new HashSet();
	private Set smsTo = new HashSet();
	private Set smsLimitTo = new HashSet();
	private ScheExecuter scheExecuter;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	
	public Integer getScheAlarmId() {
		return scheAlarmId;
	}

	public void setScheAlarmId(Integer scheAlarmId) {
		this.scheAlarmId = scheAlarmId;
	}

	public Integer getScheExecId() {
		return scheExecId;
	}

	public void setScheExecId(Integer scheExecId) {
		this.scheExecId = scheExecId;
	}

	public Date getAlarmTime() {
		return alarmTime;
	}

	public void setAlarmTime(Date alarmTime) {
		this.alarmTime = alarmTime;
	}

	public Integer getScheUserGroupId() {
		return scheUserGroupId;
	}

	public void setScheUserGroupId(Integer scheUserGroupId) {
		this.scheUserGroupId = scheUserGroupId;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getRetryCount() {
		return retryCount;
	}

	public void setRetryCount(Integer retryCount) {
		this.retryCount = retryCount;
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

	public Integer getScheJobId() {
		return scheJobId;
	}

	public void setScheJobId(Integer scheJobId) {
		this.scheJobId = scheJobId;
	}
	
	public void addMailTo(ScheUser user){
		if (StringUtils.isNotBlank(user.getEmail())){
		  mailTo.add(user.getEmail());
		}
	}
	
	public void addSmsTo(ScheUser user){
		if (StringUtils.isNotBlank(user.getMobile())){
			smsTo.add(user.getMobile());
		}
	}
	
	public void addSmsLimitTo(ScheUser user){
		if (StringUtils.isNotBlank(user.getMobile())){
			smsLimitTo.add(user.getMobile());
		}
	}

	public Set getMailTo() {
		return mailTo;
	}

	public Set getSmsTo() {
		return smsTo;
	}

	public Set getSmsLimitTo() {
		return smsLimitTo;
	}

	public ScheExecuter getScheExecuter() {
		return scheExecuter;
	}

	public void setScheExecuter(ScheExecuter scheExecuter) {
		this.scheExecuter = scheExecuter;
	}

	@Override
	public String toString() {
		return "ScheAlarmRecord [id=" + id + ", scheJobId=" + scheJobId
				+ ", scheAlarmId=" + scheAlarmId + ", scheExecId=" + scheExecId
				+ ", alarmTime=" + alarmTime + ", scheUserGroupId="
				+ scheUserGroupId + ", result=" + result + ", status=" + status
				+ ", retryCount=" + retryCount + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + ", mailTo=" + mailTo
				+ ", smsTo=" + smsTo + ", smsLimitTo=" + smsLimitTo
				+ ", scheExecuter=" + scheExecuter + "]";
	}
	

}