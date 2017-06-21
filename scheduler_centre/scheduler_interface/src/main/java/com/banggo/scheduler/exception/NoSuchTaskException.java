package com.banggo.scheduler.exception;

public class NoSuchTaskException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1241087486989378495L;

	public NoSuchTaskException(String msg){
		super(msg);
	}
}