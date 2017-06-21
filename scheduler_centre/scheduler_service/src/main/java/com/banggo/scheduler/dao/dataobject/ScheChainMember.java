package com.banggo.scheduler.dao.dataobject;

public class ScheChainMember {
	
	public static final String TERMINATE_ON_ERROR = "1";
	public static final String CONTINUE_ON_ERROR = "0";

	private Integer id;

	private Integer scheChainId;
	
	private Integer scheJobId;
	
	private Integer leftNode;
	
	private Integer rightNode;
	
	private String terminateOnError;
	
	private Integer version;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getScheChainId() {
		return scheChainId;
	}

	public void setScheChainId(Integer scheChainId) {
		this.scheChainId = scheChainId;
	}

	public Integer getScheJobId() {
		return scheJobId;
	}

	public void setScheJobId(Integer scheJobId) {
		this.scheJobId = scheJobId;
	}

	public Integer getLeftNode() {
		return leftNode;
	}

	public void setLeftNode(Integer leftNode) {
		this.leftNode = leftNode;
	}

	public Integer getRightNode() {
		return rightNode;
	}

	public void setRightNode(Integer rightNode) {
		this.rightNode = rightNode;
	}

	public String getTerminateOnError() {
		return terminateOnError;
	}

	public void setTerminateOnError(String terminateOnError) {
		this.terminateOnError = terminateOnError;
	}

	public Integer getVersion() {
		return version;
	}

	public void setVersion(Integer version) {
		this.version = version;
	}

	

	
}