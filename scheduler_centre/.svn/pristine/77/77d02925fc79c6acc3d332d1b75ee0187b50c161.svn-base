package com.banggo.scheduler.job.builder;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.job.JobAdapter;
import com.banggo.scheduler.manager.exception.SchedulerException;

public interface ScheJobBuilder {
	/**
	 * 检查job的有效性，如果无效返回错误信息
	 * @param job
	 * @return 
	 */
	public String validateScheJob(ScheJob job);
	/**
	 * 检查job参数的有效性，如果无效返回错误信息
	 * @param job
	 * @return
	 */
	public String validateScheJobParams(ScheJob job);
	
	/**
	 * @param job
	 * @throws SchedulerException 
	 */
	public void beforeCreate(ScheJob job) throws SchedulerException;
	
	/**
	 * 任务创建
	 * @param job
	 * @return
	 * @throws SchedulerException 
	 */
	public long create(ScheJob job) throws SchedulerException;
	
	/**
	 * @param job
	 * @throws SchedulerException 
	 */
	public void beforeUpdate(ScheJob job) throws SchedulerException;
	
    /**
     * 更新
     * @param job
     * @return
     * @throws SchedulerException 
     */
    public int update(ScheJob job) throws SchedulerException;
    
    /**
	 * @param job
	 * @throws SchedulerException 
	 */
	public void beforeDelete(ScheJob job) throws SchedulerException;
	
    /**
     * 删除
     * @param job
     * @return
     * @throws SchedulerException 
     */
    public int delete(ScheJob job) throws SchedulerException;
    
    /**
     * 暂停
     * @param job
     * @return
     * @throws SchedulerException 
     */
    public boolean pause(ScheJob job) throws SchedulerException;
    
    /**
     * 恢复
     * @param job
     * @return
     * @throws SchedulerException 
     */
    public boolean resume(ScheJob job) throws SchedulerException;
    
    /**
     * 触发
     * @param job
     * @return
     * @throws SchedulerException 
     */
    public boolean trigger(ScheJob job, boolean ignoreConcurrent) throws SchedulerException;
	
	/**
	 * 返回任务的实现类
	 * @return
	 */
	public Class<? extends JobAdapter> getJobClass();
}
