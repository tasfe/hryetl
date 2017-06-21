package com.banggo.scheduler.dao.dataobject;

import java.util.Date;

public class ScheChainBarrier {
    
    private Integer id;

   
    private Integer scheChainExecuterId;

  
    private Integer barrierJobId;

   
    private Integer waitCount;

   
    private Integer scheChainVersion;

   
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


	public Integer getBarrierJobId() {
		return barrierJobId;
	}


	public void setBarrierJobId(Integer barrierJobId) {
		this.barrierJobId = barrierJobId;
	}


	public Integer getWaitCount() {
		return waitCount;
	}


	public void setWaitCount(Integer waitCount) {
		this.waitCount = waitCount;
	}


	public Integer getScheChainVersion() {
		return scheChainVersion;
	}


	public void setScheChainVersion(Integer scheChainVersion) {
		this.scheChainVersion = scheChainVersion;
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