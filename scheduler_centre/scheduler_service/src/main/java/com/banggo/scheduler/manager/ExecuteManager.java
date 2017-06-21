package com.banggo.scheduler.manager;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.manager.exception.ExecuteException;

public interface ExecuteManager {
	/**
	 * 中断一个正在运行的任务
	 * 
	 * @param scheExecuterId
	 * @return
	 */
	public void interrupt(int scheExecuterId) throws ExecuteException;

	/**
	 * 立即运行一个任务
	 * @param scheJobId
	 * @param ignoreConcurrency 是否忽略串行并行设置
	 * @return
	 * @throws ExecuteException
	 */
	public boolean runImmediately(int scheJobId,boolean ignoreConcurrency)  throws ExecuteException;
	
	/**
	 * 立即运行一个任务
	 * @param scheJobId
	 * @return  如果任务设置了串行，且正在运行，则返回false
	 * @throws ExecuteException
	 */
	public boolean runImmediately(int scheJobId) throws ExecuteException;
	
	/**
	 * 立即运行一个任务
	 * @param job
	 * @param ignoreConcurrency
	 * @return
	 * @throws ExecuteException
	 */
	public boolean runImmediately(ScheJob job,boolean ignoreConcurrency)  throws ExecuteException;

}
