package com.banggo.scheduler.dao.dataobject;

import java.util.Date;

public class ScheChainExecuterDetail {

	
	public final static String STATUS_UN_NOTIFIED = "0";
	public final static String STATUS_NOTIFIED = "1";

	private Integer id;
	
	private Integer scheChainExecuterId;
	
	private Integer scheChainMemeberId;
	
	private Integer scheExecuterId;
	
	private String status;
	
	private Date createDate;
	
	private Date updateDate;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getScheChainExecuterId() {
		return scheChainExecuterId;
	}

	public void setScheChainExecuterId(Integer scheChainExecuterId) {
		this.scheChainExecuterId = scheChainExecuterId;
	}

	public Integer getScheChainMemeberId() {
		return scheChainMemeberId;
	}

	public void setScheChainMemeberId(Integer scheChainMemeberId) {
		this.scheChainMemeberId = scheChainMemeberId;
	}

	public Integer getScheExecuterId() {
		return scheExecuterId;
	}

	public void setScheExecuterId(Integer scheExecuterId) {
		this.scheExecuterId = scheExecuterId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
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

}