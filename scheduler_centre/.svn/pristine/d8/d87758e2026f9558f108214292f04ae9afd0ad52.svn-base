
package com.banggo.scheduler.service.mail;

import org.springframework.mail.MailException;

/** 
 * 功能:  将 MailException非受检异常转换成受检异常<p> 
 * 用法:
 * @version 1.0
 */

public class MailSendException extends Throwable {
	
	private static final long serialVersionUID = -7063500979438142018L;
	private MailException e;
	public MailSendException(MailException e) {
		this.e = e;
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Throwable#getCause()
	 */
	public Throwable getCause() {
		return e.getCause();
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Throwable#getMessage()
	 */
	public String getMessage() {
		return e.getMessage();
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Throwable#getStackTrace()
	 */
	public StackTraceElement[] getStackTrace() {
		return e.getStackTrace();
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Throwable#getLocalizedMessage()
	 */
	public String getLocalizedMessage() {
		return e.getLocalizedMessage();
	}
}
