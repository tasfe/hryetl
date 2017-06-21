package com.banggo.scheduler.dao.dataobject;

import java.util.Date;

public class ScheAlarmMore {
	
	private Integer id;
	private Integer scheJobId;
	private Integer frequency;
	private String frequencyUnit;
	private Integer status;
	private Date acceptAlarmBegin;
	private Date acceptAlarmEnd;
	private Integer scheUserGroupId;
	private Date createDate;
	private String createBy;
	private Date updateDate;
	private String updateBy;
	private Integer alarmMethod;
	private String jobName;
	private String groupName;

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

	public Integer getFrequency() {
		return frequency;
	}

	public void setFrequency(Integer frequency) {
		this.frequency = frequency;
	}

	public String getFrequencyUnit() {
		return frequencyUnit;
	}

	public void setFrequencyUnit(String frequencyUnit) {
		this.frequencyUnit = frequencyUnit;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Date getAcceptAlarmBegin() {
		return acceptAlarmBegin;
	}

	public void setAcceptAlarmBegin(Date acceptAlarmBegin) {
		this.acceptAlarmBegin = acceptAlarmBegin;
	}

	public Date getAcceptAlarmEnd() {
		return acceptAlarmEnd;
	}

	public void setAcceptAlarmEnd(Date acceptAlarmEnd) {
		this.acceptAlarmEnd = acceptAlarmEnd;
	}

	public Integer getScheUserGroupId() {
		return scheUserGroupId;
	}

	public void setScheUserGroupId(Integer scheUserGroupId) {
		this.scheUserGroupId = scheUserGroupId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}

	public boolean validate() {
		if (scheJobId == null)
			return false;
		return true;
	}

	public Integer getAlarmMethod() {
		return alarmMethod;
	}

	public void setAlarmMethod(Integer alarmMethod) {
		this.alarmMethod = alarmMethod;
	}

	public String getJobName() {
		return jobName;
	}

	public void setJobName(String jobName) {
		this.jobName = jobName;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	
	public boolean isAlertByMail(){
		return (alarmMethod & 1) > 0;
	}
	public boolean isAlertBySmsFullDay(){
		return (alarmMethod & 2) > 0;
	}
	public boolean isAlertBySmsLimit(){
		return (alarmMethod & 4) > 0;
	}

}