package com.banggo.scheduler.frontctl;

import org.apache.log4j.Logger;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;

import com.banggo.scheduler.exception.CallbackException;
import com.banggo.scheduler.exception.FatalException;
import com.banggo.scheduler.exception.FullLoadException;
import com.banggo.scheduler.exception.NoSuchTaskException;
import com.banggo.scheduler.exception.WarnningException;
import com.banggo.scheduler.mapping.TaskMapping;
import com.banggo.scheduler.mapping.TaskMappingRepository;
import com.banggo.scheduler.po.CallbackPO;
import com.banggo.scheduler.pool.FuturePool;
import com.banggo.scheduler.pool.ThreadPoolFactory;
import com.banggo.scheduler.ro.ExecuteRO;
import com.banggo.scheduler.ro.InterruptRO;
import com.banggo.scheduler.service.CallBackService;
import com.banggo.scheduler.task.Task;
import com.banggo.scheduler.task.TaskExecuteRequest;
import com.banggo.scheduler.task.TaskInfoGenerateFactory;

@SuppressWarnings("rawtypes")
public class DispatcherFrontController implements FrontController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(DispatcherFrontController.class);
	
	/* (non-Javadoc)
	 * @see com.banggo.scheduler.frontctl.FrontController#execute(java.lang.String, java.lang.String, java.util.Map)
	 */
	public ExecuteRO execute(String taskName, String taskGroup, Map params) {
		if (logger.isDebugEnabled()){
			logger.debug("receive a job :" + taskName + "(" + taskGroup + ")");
		}
        // create context
		final TaskExecuteRequest context = new TaskExecuteRequest(taskName, taskGroup, params);
        
		// create return object
		ExecuteRO ro = createExecuteRO();
		
		// find a mapping
		TaskMapping taskMapping = findTaskMapping(context);
		if (taskMapping == null){
			// 找不到taskMapping?
			ro.setAccept(false);
			ro.setException("Can't find any TaskMapping for " + taskName + "(" + taskGroup + ") Please check the config.");
			logger.error("Can't find any TaskMapping for " + taskName + "(" + taskGroup + ")");
			return ro;
		}
		
		// 获取Task
		Task task = null;
		try {
			task = taskMapping.getTask(context);
		} catch (NoSuchTaskException e) {
			logger.error("Can't find any Task binder " + taskName + "(" + taskGroup + ")",e);
			ro.setAccept(false);
			ro.setException(e);
			return ro;
		}catch (Throwable t) {
			logger.error("Error occurred when try to find a Task binder for " + taskName + "(" + taskGroup + ")",t);
			ro.setAccept(false);
			ro.setException(t);
			return ro;
		}
		
		// 设置应用编号和取消地址
		TaskInfoGenerateFactory taskInfoFactory = task.getTaskInfoGenFactory(); 
		if (taskInfoFactory != null){
			String appExecNo = taskInfoFactory.generateAppExecNo(context);
			String cancelUrl = taskInfoFactory.generateCancelURL(context);
			
			ro.setAppExecNo(appExecNo);
			ro.setCancelUrl(cancelUrl);
			
			context.setAppExecNo(appExecNo);
		}
		
		final Task sweetTask = task;
		
		// 加到线程池中执行
		ThreadPoolExecutor executor = ThreadPoolFactory.getInstance().getThreadPool();
	
		try{
			Future future = executor.submit(new Runnable() {

				public void run() {
					
					if (logger.isDebugEnabled()){
						logger.debug("Task=" + sweetTask + " begin..." );
					}

					CallbackPO po = new CallbackPO();
					
					if (Thread.currentThread().isInterrupted()) {
						// 任务被中断
						po.setSuccess(false);
						po.setException("interrupted");
					} else {

						try {
							// 执行任务
							sweetTask.execute(context);
							po.setSuccess(true);
						} catch (WarnningException e) {
							logger.warn(e);
							
							po.setSuccess(true);
							po.setException(e);
							
						} catch (FatalException e) {
							logger.error(e);
							
							po.setSuccess(false);
							po.setException(e);
							
						}catch (Throwable t) {
                            logger.error(t);
                            
							po.setSuccess(false);
                            po.setException(t);
						}
					}
					
					po.setEndTime(new Date());
					po.setAppExecNo(context.getAppExecNo());
					po.setExecNo(context.getExecNo());

					if (logger.isDebugEnabled()){
						logger.debug("Task=" + sweetTask + " do callback. " + po );
					}
					// 执行回调
					CallBackService cs = new CallBackService();

					try {
						cs.callback(context.getCallbackUrl(), po);
					} catch (CallbackException e) {
						logger.error(e);
					} finally {
						// 从future pool池中移除future
						FuturePool.getInstance().get(createKey(context));
					}
					
					if (logger.isDebugEnabled()){
						logger.debug("Task=" + sweetTask + " end..." );
					}
				}
			} );
			
			if (logger.isDebugEnabled()){
				logger.debug("add job to thread pool success. Task=" + sweetTask + " [" + taskName + "(" + taskGroup + ")]" );
			}
			// 放入future pool中
			FuturePool.getInstance().put(createKey(context), future);	
			
		}catch(FullLoadException e){
			logger.error("add job to thread pool failed. Task=" + sweetTask + " [" + taskName + "(" + taskGroup + ")]" ,e);

			ro.setAccept(false);
			ro.setException(e);
			return ro;
		}
		// 返回
		return ro;
	}
	
	
	/* (non-Javadoc)
	 * @see com.banggo.scheduler.frontctl.FrontController#interrupt(java.lang.String, java.lang.String, java.util.Map)
	 */
	public InterruptRO interrupt(String taskName, String taskGroup, Map params) {
		if (logger.isDebugEnabled()){
			logger.debug("receive a interrupt job :" + taskName + "(" + taskGroup + ")");
		}
		
		// create context
		TaskExecuteRequest context = new TaskExecuteRequest(taskName,taskGroup, params);

		// 执行中断
		Future future = FuturePool.getInstance().get(createKey(context));
				
		// create return object
		InterruptRO ro = new InterruptRO();
		ro.setIsInterruptSuccess(future != null && future.cancel(true));

		if (logger.isDebugEnabled()){
			logger.debug("interrupt job :" + taskName + "(" + taskGroup + ") finished. Result is " + ro.getIsInterruptSuccess());
		}
		
		return ro;

	}
	

	/**
	 * @param context
	 * @return
	 */
	private String createKey(TaskExecuteRequest context){
	     return context.getExecNo() + ":" + context.getAppExecNo();
	}
	
	/**
	 * @return
	 */
	private ExecuteRO createExecuteRO(){
		ExecuteRO ro = new ExecuteRO();
		ro.setBeginTime(new Date());
		ro.setAccept(true);
		return ro;
	}
	
	
	/**
	 * @param context
	 * @return
	 */
	private TaskMapping findTaskMapping(TaskExecuteRequest context){
		TaskMapping[] taskMappings = TaskMappingRepository.getInstance().getTaskMappings();
		for (TaskMapping taskMapping : taskMappings) {
			if (taskMapping.support(context)){
				return taskMapping;
			}
		}
		return null;
	}

}
