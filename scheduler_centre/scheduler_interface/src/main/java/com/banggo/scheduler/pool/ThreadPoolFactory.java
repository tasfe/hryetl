package com.banggo.scheduler.pool;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.RejectedExecutionHandler;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import com.banggo.scheduler.exception.FullLoadException;

public class ThreadPoolFactory {
	private static ThreadPoolFactory factory = new ThreadPoolFactory();

	private ThreadPoolExecutor pool;

	private ThreadPoolFactory() {

	}

	public synchronized void init(int coreWorkerNum, int maxWorkerNum,
			int queueSize, long keepAliveTime) {
		pool = new ThreadPoolExecutor(coreWorkerNum, maxWorkerNum,
				keepAliveTime, TimeUnit.SECONDS,
				new ArrayBlockingQueue<Runnable>(queueSize, true), new Reject());
	}

	public synchronized ThreadPoolExecutor getThreadPool() {
		return pool;
	}

	public static ThreadPoolFactory getInstance() {
		return factory;
	}

	class Reject implements RejectedExecutionHandler {

		public void rejectedExecution(Runnable r, ThreadPoolExecutor executor) {
			throw new FullLoadException("线程池已满，无法接收新的任务.");
		}

	}

}
