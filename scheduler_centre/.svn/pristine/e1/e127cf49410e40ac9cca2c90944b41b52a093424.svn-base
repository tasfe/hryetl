package com.banggo.scheduler.ro;

import java.io.Serializable;

public class CallbackRO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7946770016171047826L;
	
	
	private boolean isAccept = true; // 调度系统是否接收了回调
	private String msg; // 调度系统处理完回调后，回传给应用系统消息
	public boolean isAccept() {
		return isAccept;
	}
	public void setAccept(boolean isAccept) {
		this.isAccept = isAccept;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	@Override
	public String toString() {
		return "CallbackRO [isAccept=" + isAccept + ", msg=" + msg + "]";
	}
	
	
}
