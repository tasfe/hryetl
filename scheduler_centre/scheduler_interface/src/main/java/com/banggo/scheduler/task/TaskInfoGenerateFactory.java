package com.banggo.scheduler.task;

public interface TaskInfoGenerateFactory {
	
	/**
	 * 生成执行编号
	 * @param context
	 * @return
	 */
	public String generateAppExecNo(TaskExecuteRequest context);

	/**
	 * 生成取消任务地址
	 * @param context
	 * @return
	 */
	public String generateCancelURL(TaskExecuteRequest context);
}
