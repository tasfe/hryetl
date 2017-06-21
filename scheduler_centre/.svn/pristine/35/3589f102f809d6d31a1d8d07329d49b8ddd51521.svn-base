package com.banggo.scheduler.service;

import org.apache.log4j.Logger;

import com.banggo.scheduler.exception.CallbackException;
import com.banggo.scheduler.interfaces.TaskCallback;
import com.banggo.scheduler.po.CallbackPO;
import com.banggo.scheduler.ro.CallbackRO;
import com.caucho.hessian.client.HessianProxyFactory;

public class CallBackService {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CallBackService.class);

	private long connectTimeout = 30 * 1000;
	private long readTimeout = 60 * 1000;

	public CallBackService(long connectTimeout, long readTimeOut) {
		this.connectTimeout = connectTimeout;
		this.readTimeout = readTimeOut;
	}

	public CallBackService() {
	}

	public CallbackRO callback(String callbackUrl, CallbackPO callbackPO) throws CallbackException {
		HessianProxyFactory  factory = new HessianProxyFactory ();
	    factory.setConnectTimeout(connectTimeout);
	    factory.setReadTimeout(readTimeout);
	   
	    CallbackRO callbackRO = null;
		try {
			TaskCallback callback = (TaskCallback)factory.create(callbackUrl);
			callbackRO = callback.callback(callbackPO);
		} catch (Exception e) {
			logger.error("Callback error. url:" + callbackUrl + " content:" + callbackPO, e);

			throw new CallbackException(e.getMessage());
		} 
		
		return callbackRO;
	}
}
