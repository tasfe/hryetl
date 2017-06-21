package com.banggo.scheduler.task;

import com.banggo.scheduler.exp.Expression;
import com.banggo.scheduler.frontctl.FrontController;

public class DefaultTaskInfoGenFactory implements TaskInfoGenerateFactory {

	private static DefaultTaskInfoGenFactory instance = new DefaultTaskInfoGenFactory();
	private DefaultTaskInfoGenFactory(){
		
	}
	
	public String generateAppExecNo(TaskExecuteRequest context) {
		if (context  == null){
			return "";
		}
		return "app_" + context.getParam(FrontController.EXECUTE_NO_KEY);
	}

	public String generateCancelURL(TaskExecuteRequest context) {
		return Expression.REMOTE_URL;
	}
	
	public static DefaultTaskInfoGenFactory getInstance(){
		return instance;
	}

}
