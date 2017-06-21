package com.banggo.scheduler.mapping;

import com.banggo.scheduler.exception.NoSuchTaskException;
import com.banggo.scheduler.task.Task;
import com.banggo.scheduler.task.TaskExecuteRequest;

/**
 * 通过类名反射查找Task
 *
 */
public class ReflectTaskMapping implements TaskMapping {

	
	public Task getTask(TaskExecuteRequest request) throws NoSuchTaskException{
		String className = request.getTaskClassName();
		
		Class taskClass = null;
		try {
			taskClass = this.getClass().getClassLoader().loadClass(className);
		} catch (ClassNotFoundException e) {
			throw new NoSuchTaskException(e.getMessage());
		}

		Task task = null;
		try {
			task = (Task) taskClass.newInstance();
		} catch (Exception e) {
			throw new NoSuchTaskException(e.getMessage());
		}
		
		return task;
	}

	public boolean support(TaskExecuteRequest context) {
		return context.getTaskClassName() != null;
	}

	public int getOrder() {
		return 0;
	}

}
