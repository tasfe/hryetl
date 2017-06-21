package com.banggo.scheduler.frontctl;

import java.util.Map;

import com.banggo.scheduler.ro.ExecuteRO;
import com.banggo.scheduler.ro.InterruptRO;

public interface FrontController {
	/**
	 * 存放回调地址的键值
	 */
	String CALL_BACK_URL_KEY = "callbackUrl";
	/**
	 * 存放应用执行编号的键值
	 */
	String APP_EXECUTE_NO_KEY = "appExecNo";
	/**
	 * 存放执行编号的键值
	 */
	String EXECUTE_NO_KEY = "execNo";
	
	/**
	 * 存放任务实现类类名的键值
	 */
	String TASK_CLASS_NAME_KEY = "className";
	

	/**
	 * 根据参数定位到指定任务，并执行该任务。
	 * 
	 * 规定:
	 * 1)需要异步执行任务，在任务执行的同时返回ExecuteRO
	 * 2)任务执行完成后，需要执行回调，通知定时任务管理系统
	 * 
	 * @param taskName 任务名称
	 * @param taskGroup 任务组名称
	 * @param params 任务参数
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public ExecuteRO execute(String taskName, String taskGroup, Map params);

	/**
	 * 中断运行任务的线程
	 * 规定:
	 * 1) 任务线程不存在，或任务线程已执行完成时，InterruptRO.isInterruptSuccess = false，否则等于true
	 * 
	 * @param taskName 任务名称
	 * @param taskGroup 任务组名称
	 * @param params 任务参数
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public InterruptRO interrupt(String taskName, String taskGroup, Map params);
}
