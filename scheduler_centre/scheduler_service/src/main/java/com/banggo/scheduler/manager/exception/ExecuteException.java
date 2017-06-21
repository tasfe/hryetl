package com.banggo.scheduler.manager.exception;

public class ExecuteException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 29215767897419795L;

	public ExecuteException(String msg) {
		super(msg);

	}

	public ExecuteException(Exception e) {
		super(e);
	}
}
