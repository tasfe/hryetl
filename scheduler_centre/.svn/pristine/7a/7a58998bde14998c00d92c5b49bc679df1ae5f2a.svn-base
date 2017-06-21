package com.banggo.scheduler.async.task;

import java.util.concurrent.Callable;

import org.apache.log4j.Logger;

public abstract class AsyncTask<V> implements Callable<V> {
	protected static Logger logger = Logger.getLogger(AsyncTask.class);

	@Override
	public V call() throws Exception {
		try {
			return doInAsync();
		} catch (Throwable e) {
			logger.error(e);
		}
		
		return null;
	}

	/**
	 * 由任务执行线程调用
	 * @return
	 */
	public abstract V doInAsync();
}
