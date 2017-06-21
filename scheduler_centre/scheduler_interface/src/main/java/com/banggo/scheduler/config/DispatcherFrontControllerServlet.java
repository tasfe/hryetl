package com.banggo.scheduler.config;

import org.apache.log4j.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import com.banggo.scheduler.mapping.TaskMapping;
import com.banggo.scheduler.mapping.TaskMappingRepository;
import com.banggo.scheduler.pool.FuturePool;
import com.banggo.scheduler.pool.ThreadPoolFactory;

public class DispatcherFrontControllerServlet extends HttpServlet {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(DispatcherFrontControllerServlet.class);

	/**
	 * 
	 */
	private static final long serialVersionUID = 1010955389529609457L;
	

	@Override
	public void init(ServletConfig config) throws ServletException {
		if (logger.isDebugEnabled()) {
			logger.debug("Being init scheduler interface framework");
		}
		
		// 初始化TaskMapping
		initTaskMapping(config);
		
		// 初始化FuturePool
		initFuturePool(config);
		
		// 初始化 ThreadPoolFactory
		initThreadPool(config);
		
		if (logger.isDebugEnabled()) {
			logger.debug("Init scheduler interface framework sucessfully.");
		}
	}
	
	private void initThreadPool(ServletConfig config) throws ServletException {
		int core_worker_num = parseInt(config.getInitParameter("core_worker_num"));
		int max_worker_num = parseInt(config.getInitParameter("max_worker_num"));
		int worker_keep_alive_in_ms = parseInt(config.getInitParameter("worker_keep_alive_in_sec"));
		int queue_size = parseInt(config.getInitParameter("queue_size"));
		
		if (core_worker_num <= 0){
			throw new ServletException("init threadpool failed. Please check init parameter:core_worker_num");
		}
		if (max_worker_num <= 0){
			throw new ServletException("init threadpool failed. Please check init parameter:max_worker_num");
		}
		if (worker_keep_alive_in_ms <= 0){
			throw new ServletException("init threadpool failed. Please check init parameter:worker_keep_alive_in_ms");
		}
		if (queue_size <= 0){
			throw new ServletException("init threadpool failed. Please check init parameter:queue_size");
		}
		
	   ThreadPoolFactory.getInstance().init(core_worker_num,max_worker_num,queue_size,worker_keep_alive_in_ms);
		
	}
	
	private int parseInt(String str){
		if (str == null || str.length() == 0){
			return -1;
		}
		try {
			return Integer.parseInt(str.trim());
		} catch (Exception e) {
			return -1;
		}
	}

	private void initFuturePool(ServletConfig config) {
		int poolSize = parseInt(config.getInitParameter("interrupt_holder_poolsize"));
		if (poolSize <= 0 ){
			poolSize = FuturePool.DEFAULT_SIZE;
		}
		
		FuturePool.getInstance().init(poolSize);
		
	}

	private void initTaskMapping(ServletConfig config) throws ServletException {
		String taskMappings = config.getInitParameter("taskMappings");
		if (taskMappings == null || taskMappings.length() == 0){
			throw new ServletException("Can't find taskMapping.Please check the servlet config.");
		}
		
		String[] taskMappingClassNames = taskMappings.split(",");
		for (int i = 0; i < taskMappingClassNames.length; i++) {
			String clsName = taskMappingClassNames[i].trim();
			
			Class clz = null;
			try {
				clz = this.getClass().getClassLoader().loadClass(clsName);
			} catch (ClassNotFoundException e) {
				throw new ServletException(e.getMessage());
			}
			
			try {
				TaskMapping mapping = (TaskMapping) clz.newInstance();
				TaskMappingRepository.getInstance().add(mapping);
				
				if (logger.isDebugEnabled()){
					logger.debug("find taskmapping:" + clsName + " Instance:" + mapping);
				}
				
			} catch (Exception e) {
				throw new ServletException(e.getMessage());
			} 
		}
		
	}

	@Override
	public void destroy() {
		ThreadPoolFactory.getInstance().getThreadPool().shutdown();
	}
}
