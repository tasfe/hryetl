package com.banggo.scheduler.task;

import com.banggo.scheduler.exception.FatalException;
import com.banggo.scheduler.exception.WarnningException;
import com.banggo.scheduler.exp.Expression;

public abstract class RunInOneNodeTask implements Task{

	public abstract void execute(TaskExecuteRequest context) throws WarnningException,
			FatalException ;
	
	public String appExecNo(TaskExecuteRequest context){
		return "app_" + context.getExecNo();
	}
	
	/**
	 * 检查任务是否被中断
	 * @return
	 */
	public boolean isInterrupted(){
		return Thread.currentThread().isInterrupted();
	}
	
	public TaskInfoGenerateFactory getTaskInfoGenFactory() {
		
		return new TaskInfoGenerateFactory() {
			
			public String generateCancelURL(TaskExecuteRequest context) {
				return Expression.REMOTE_URL;
			}
			
			public String generateAppExecNo(TaskExecuteRequest context) {
				return appExecNo(context);
			}
		};
	}
	
	

}
