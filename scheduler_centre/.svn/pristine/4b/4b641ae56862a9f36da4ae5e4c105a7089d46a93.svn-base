package com.banggo.scheduler.ro;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.Date;

public class ExecuteRO implements Serializable {


	/**
	 * 
	 */
	private static final long serialVersionUID = 5236535352884947102L;
	
	private String appExecNo; // 应用返回的应用自身的执行编号
	private String cancelUrl; // 应用中断任务的地址
	private Date beginTime;  // 应用开始执行任务的时间
	

	private boolean isAccept = true; // 应用是否接收任务
	private String exception; // 如果不能执收任务，应用返回的异常信息

	public String getAppExecNo() {
		return appExecNo;
	}

	public void setAppExecNo(String execNo) {
		this.appExecNo = execNo;
	}

	public boolean isAccept() {
		return isAccept;
	}

	public void setAccept(boolean isAccept) {
		this.isAccept = isAccept;
	}

	public String getException() {
		return exception;
	}

	public void setException(String exception) {
		if (exception == null ){
			return;
		}
		
		exception = exception.trim();
		if (exception.length() == 0){
			return;
		}
		
		this.exception = exception.substring(0,Math.min(65535/3, exception.length()));
	}
	
	public void setException(Throwable t){
		setException(printStackTrace(t));
	}


	public String getCancelUrl() {
		return cancelUrl;
	}

	public void setCancelUrl(String cancelUrl) {
		if (cancelUrl == null ){
			return;
		}
	
		if (cancelUrl.length() > 333){
			throw new IllegalArgumentException("URL超长，最大333");
		}
		
		this.cancelUrl = cancelUrl;
	}

	public Date getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
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
		return "ExecuteReturnObject [execNo=" + appExecNo + ", cancelUrl="
				+ cancelUrl + ", beginTime=" + beginTime + ", isAccept="
				+ isAccept + ", exception=" + exception + "]";
	}
	
	
}
