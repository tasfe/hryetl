package com.banggo.scheduler.ro;

import java.io.Serializable;

public class InterruptRO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5542542131861782505L;

	private Boolean isInterruptSuccess ; // 中断成功或失败
	
	public Boolean getIsInterruptSuccess() {
		return isInterruptSuccess;
	}

	public void setIsInterruptSuccess(Boolean isInterruptSuccess) {
		this.isInterruptSuccess = isInterruptSuccess;
	}

	@Override
	public String toString() {
		return "InterruptRO [isInterruptSuccess=" + isInterruptSuccess + "]";
	}


}
