package com.banggo.scheduler.manager;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.manager.exception.SchedulerException;

public interface JobManager {
	
	
	/**
	 * 增加一个任务
	 * @param job
	 * @return
	 * @throws SchedulerException
	 */
	public long addJob(ScheJob job) throws SchedulerException;
	
	/**
	 * 更新一个任务的调度信息
	 * @param job
	 * @return
	 * @throws SchedulerException
	 */
	public long updateJob(ScheJob job) throws SchedulerException;

	/**
	 * 删除一个任务
	 * @param scheJobId
	 * @return
	 * @throws SchedulerException
	 */
	public int deleteJob(int scheJobId) throws SchedulerException;
	
	/**
	 * 暂停调度某个任务
	 * @return
	 * @throws SchedulerException
	 */
	public boolean pauseJob(int scheJobId) throws SchedulerException;
	
	/**
	 * 继续调度某个任务
	 * @param scheJobId
	 * @return
	 * @throws SchedulerException
	 */
	public boolean resumeJob(int scheJobId) throws SchedulerException;

}
