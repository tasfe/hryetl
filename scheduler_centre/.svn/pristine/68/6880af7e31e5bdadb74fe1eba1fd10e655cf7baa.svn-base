package com.banggo.scheduler.dao.dataobject;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.quartz.CronExpression;

public class ScheJob {
    public final static String ALLOW_CONCURRENT = "1";
    public final static String DISALLOW_CONCURRENT = "0";
    
    public final static String STATUS_NOMAL = "1";
    public final static String STATUS_STOP = "0";
    
    
    public final static String IS_DELETE_TRUE = "1";
    public final static String IS_DELETE_FALSE = "0";
    
    public final static int TYPE_HESSIAN = 1; // 远程调用任务
    public final static int TYPE_JOB_CHAIN = -1; // 本地任务组任务
    public final static int TYPE_VIRTUAL = 0; // 虚拟任务
    
  
    
	private Integer id;

	private String appName;

	private String jobName;

	private String jobGroup;

	private Date beginDate;

	private Date endDate;

	private String status;

	private String cronExp;

	private String isAllowConcurrent;

	private String remoteUrl;

	private Integer connectTimeout;

	private Integer readTimeout;

	private String isDelete;

	private Date createDate;

	private String createBy;

	private Date updateDate;

	private String updateBy;
	
	private Integer type;

	private List<ScheJobParams> scheJobParamsList;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

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

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCronExp() {
		return cronExp;
	}

	public void setCronExp(String cronExp) {
		this.cronExp = cronExp;
	}

	public String getIsAllowConcurrent() {
		return isAllowConcurrent;
	}

	public void setIsAllowConcurrent(String isAllowConcurrent) {
		this.isAllowConcurrent = isAllowConcurrent;
	}

	public String getRemoteUrl() {
		return remoteUrl;
	}

	public void setRemoteUrl(String remoteUrl) {
		this.remoteUrl = remoteUrl;
	}

	public Integer getConnectTimeout() {
		return connectTimeout;
	}

	public void setConnectTimeout(Integer connectTimeout) {
		this.connectTimeout = connectTimeout;
	}

	public Integer getReadTimeout() {
		return readTimeout;
	}

	public void setReadTimeout(Integer readTimeout) {
		this.readTimeout = readTimeout;
	}

	public String getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(String isDelete) {
		this.isDelete = isDelete;
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

	public List<ScheJobParams> getScheJobParamsList() {
		return scheJobParamsList;
	}

	public void setScheJobParamsList(List<ScheJobParams> scheJobParamsList) {
		this.scheJobParamsList = scheJobParamsList;
	}
	
	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public boolean inValidateDate() {
		if (beginDate == null || endDate == null){
			return false;
		}
		return beginDate.after(endDate);
	}

	public boolean inValidateCron() {
		try {
			CronExpression.validateExpression(cronExp);
		} catch (ParseException e) {
			return true;
		}
		return false;
	}

	@Override
	public String toString() {
		return "ScheJob [id=" + id + ", appName=" + appName + ", jobName="
				+ jobName + ", jobGroup=" + jobGroup + ", beginDate="
				+ beginDate + ", endDate=" + endDate + ", status=" + status
				+ ", cronExp=" + cronExp + ", isAllowConcurrent="
				+ isAllowConcurrent + ", remoteUrl=" + remoteUrl
				+ ", connectTimeout=" + connectTimeout + ", readTimeout="
				+ readTimeout + ", isDelete=" + isDelete + ", createDate="
				+ createDate + ", createBy=" + createBy + ", updateDate="
				+ updateDate + ", updateBy=" + updateBy + ",type=" + type
				+ ", scheJobParamsList=" + scheJobParamsList + "]";
	}
	
	

}