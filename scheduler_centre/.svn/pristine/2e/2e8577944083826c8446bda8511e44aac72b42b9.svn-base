package com.banggo.scheduler.pool;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Future;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class FuturePool {
	public static final int DEFAULT_SIZE = 1000;
	
	private Map<String, Future> container = new HashMap<String, Future>();
	private static FuturePool instance = new FuturePool();
	
	private volatile Semaphore available;
	private volatile boolean init = false;

	private FuturePool() {
		
	}
	
	/**
	 * 初始化
	 * @param poolSize
	 */
	public void init(int poolSize){
		if (poolSize <= 0 ){
			poolSize = DEFAULT_SIZE;
		}
		
		available = new Semaphore(poolSize);
		init = true;
	}

	/**
	 * @return
	 */
	public static FuturePool getInstance() {
		return instance;
	}

	/**
	 * @param key
	 * @param future
	 */
	public void put(String key, Future future) {
		if (!init || key == null || future == null) {
			return;
		}
		boolean isGetAcuire = false;
		boolean isPutIn = false;
		try {
			isGetAcuire = available.tryAcquire(10, TimeUnit.MILLISECONDS);
			if (isGetAcuire) {
				synchronized (this) {
					Future thePutOne = container.put(key, future);
					isPutIn = (thePutOne != null);
				}
			}
		} catch (InterruptedException e) {
			// ignore
		} finally {
			if (isGetAcuire && !isPutIn) {
				available.release();
			}
		}

	}

	/**
	 * @param key
	 * @return
	 */
	public Future get(String key) {
		if (!init || key == null) {
			return null;
		}

		Future obj = null;
		synchronized (this) {
			obj = container.remove(key);
		}

		if (obj != null) {
			available.release();
		}
		return obj;

	}
}
