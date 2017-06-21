package com.banggo.scheduler.mapping;

import com.banggo.scheduler.exception.NoSuchTaskException;
import com.banggo.scheduler.task.Task;
import com.banggo.scheduler.task.TaskExecuteRequest;

public interface TaskMapping extends Order {
    /**
     * @return
     */
    public Task getTask(TaskExecuteRequest request) throws NoSuchTaskException;
    
    /**
     * @param context
     * @return
     */
    public boolean support(TaskExecuteRequest request);
}
