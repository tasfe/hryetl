package com.banggo.scheduler.async.service.impl;

import java.util.concurrent.Future;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.InitializingBean;

import com.banggo.scheduler.async.exception.AsyncExecuteServiceException;
import com.banggo.scheduler.async.service.AsyncExecuteService;
import com.banggo.scheduler.async.task.AsyncTask;

public class AsyncExecuteServiceImpl implements AsyncExecuteService,InitializingBean {

	private ThreadPoolExecutor threadPoolExecutor;
	
	private int corePoolSize;
	private int maximumPoolSize;
	private int keepAliveTime; // 当超过核心池数量时，工作线程无任务的等待时间，单位S
	private int workQueueSize;
	private RejectedExecutionHandler rejectHandler;
	
	
	
	public void setCorePoolSize(int corePoolSize) {
		this.corePoolSize = corePoolSize;
	}

	public void setMaximumPoolSize(int maximumPoolSize) {
		this.maximumPoolSize = maximumPoolSize;
	}

	public void setKeepAliveTime(int keepAliveTime) {
		this.keepAliveTime = keepAliveTime;
	}

	public void setWorkQueueSize(int workQueueSize) {
		this.workQueueSize = workQueueSize;
	}

	public void setRejectHandler(RejectedExecutionHandler rejectHandler) {
		this.rejectHandler = rejectHandler;
	}

	@Override
	public <V> Future<V> submitTask(AsyncTask<V> asyncTask) {
		return threadPoolExecutor.submit(asyncTask);
	}

	@Override
	public void stop() {
		threadPoolExecutor.shutdown();
	}

	@Override
	public void start() {
		if (corePoolSize <= 0 || maximumPoolSize <= 0 || keepAliveTime <=0 || workQueueSize <= 0){
			throw new AsyncExecuteServiceException("AsyncExecuteService初始化失败，参数corePoolSize、maximumPoolSize、keepAliveTime、workQueueSize需大于0");
		}
		
		maximumPoolSize = Math.max(corePoolSize, maximumPoolSize);
		
		if (rejectHandler == null){
			rejectHandler = new ThreadPoolExecutor.CallerRunsPolicy();
		}
		
		threadPoolExecutor = new ThreadPoolExecutor(corePoolSize, maximumPoolSize, keepAliveTime, TimeUnit.SECONDS, new LinkedBlockingQueue<Runnable>(workQueueSize), rejectHandler);
		
	}


	@Override
	public int getWorkerSize() {
		return threadPoolExecutor.getActiveCount();
	}

	@Override
	public int getWaitTaskSize() {
		return threadPoolExecutor.getQueue().size();
	}
	

	@Override
	public long getCompletedTaskCount() {
		return threadPoolExecutor.getCompletedTaskCount();
	}
	
	@Override
	public boolean isRunning() {
		return !threadPoolExecutor.isShutdown();
	}
	
	@Override
	public void afterPropertiesSet() throws Exception {
		start();
	}

	


}
