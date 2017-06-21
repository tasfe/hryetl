package com.banggo.scheduler.task;

import com.banggo.scheduler.exception.FatalException;
import com.banggo.scheduler.exception.WarnningException;

public interface Task {
	/**
	 * 执行任务
	 * 
	 * 规定：
	 * 1) 任务运行过程中被中断(如，在页面执行中断操作)，则当前线程中断标志位将被设置.
	 *    如果任务需要响应中断，请检查中断标志位
	 *    
	 * @param context 执行上下文，包含任务参数、任务名称等信息
	 * @throws WarnningException 抛出该异常时认为任务执行成功，但有异常
	 * @throws FatalException 抛出该异常时认为任务执行失败
	 */
	public void execute(TaskExecuteRequest context) throws WarnningException,
			FatalException;
	
	
	/**
	 * @return 返回生成'任务执行编号'和'取消地址'的工厂类
	 */
	public TaskInfoGenerateFactory getTaskInfoGenFactory();
}
