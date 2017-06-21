package com.banggo.scheduler.job;

import org.quartz.JobExecutionException;

public interface IScheJob {
	/**
	 * 自定义任务执行者需要在scheduler context中定义该接口的实现类 以执行自定义的任务
	 * 
	 * @param context
	 * @throws JobExecutionException
	 */
	public void execute(ScheJobContext context) throws JobExecutionException;
}
