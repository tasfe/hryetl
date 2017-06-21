package com.banggo.scheduler.po;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;

public class CallbackPO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4645145558068809470L;
	
	private Date endTime; // 应用结束执行任务的时间
	private String exception; // 应用执行过程中的异常
	private boolean isSuccess = false; // 应用执行结果
	
	private String execNo; // 调度系统的任务编号
	private String appExecNo;  // 应用系统的任务编号
	
	
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public String getException() {
		return exception;
	}
	
	public void setException(String exception) {
		if (exception != null ){
			exception = exception.substring(0,Math.min(65535/3, exception.length()));
		}
		this.exception = exception;
	}
	
	public void setException(Throwable t){
		setException(printStackTrace(t));
	}
	
	public boolean isSuccess() {
		return isSuccess;
	}
	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getExecNo() {
		return execNo;
	}
	public void setExecNo(String execNo) {
		this.execNo = execNo;
	}
	public String getAppExecNo() {
		return appExecNo;
	}
	public void setAppExecNo(String appExecNo) {
		this.appExecNo = appExecNo;
	}
	
	private String printStackTrace(Throwable t){
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		
		try {
			t.printStackTrace(new PrintStream(out,true,"utf-8"));
			return out.toString("utf-8");
		} catch (UnsupportedEncodingException e) {
		}
		return "unknow";
	}
	
	@Override
	public String toString() {
		return "CallbackPO [endTime=" + endTime + ", exception=" + exception
				+ ", isSuccess=" + isSuccess + ", execNo=" + execNo
				+ ", appExecNo=" + appExecNo + "]";
	}	

}
