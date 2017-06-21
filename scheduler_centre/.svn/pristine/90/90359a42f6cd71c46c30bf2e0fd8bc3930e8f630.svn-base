package com.banggo.scheduler.support;

import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;

import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;
import org.springframework.beans.factory.FactoryBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.web.context.ServletContextAware;

@SuppressWarnings("rawtypes")
public class QuartzSchedulerFactoryBean implements ServletContextAware,InitializingBean, FactoryBean<Scheduler>{
	private ServletContext servletContext;
	
	private Scheduler scheduler;
	
   private String qtzSchedulerFactoryKey = "scheduler.factory.key";

	
	private Map registeMap;
    public void setRegisteMap(Map registeMap) {
		this.registeMap = registeMap;
	}
    public void setQtzSchedulerFactoryKey(String qtzSchedulerFactoryKey) {
    	this.qtzSchedulerFactoryKey = qtzSchedulerFactoryKey;
    }
   
	
    
	@Override
	public void afterPropertiesSet() throws Exception {
		 
		// 注册实现类
		if (registeMap == null || registeMap.isEmpty()) {
			return;
		}
		
		StdSchedulerFactory factory = (StdSchedulerFactory)servletContext.getAttribute(qtzSchedulerFactoryKey);
		this.scheduler = factory.getScheduler();
		
		Set<Map.Entry> set = registeMap.entrySet();
		for (Iterator iterator = set.iterator(); iterator.hasNext();) {
			Map.Entry entry = (Map.Entry) iterator.next();
			scheduler.getContext().put((String)entry.getKey(), entry.getValue());
		}
		
		initQtzSchedulerInstanceIdHolder(scheduler);
	}

	private void initQtzSchedulerInstanceIdHolder(Scheduler scheduler) {
		String instanceId = "null";
		try {
			instanceId = scheduler.getSchedulerInstanceId();
		} catch (SchedulerException e) {
		}
		
		QtzSchedulerInstanceIdHolder.setQtzSchedulerInstanceIdHolder(instanceId);
	}
	
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		
	}

	@Override
	public Scheduler getObject() throws Exception {
		return scheduler;
	}

	@Override
	public Class<?> getObjectType() {
		return Scheduler.class;
	}

	@Override
	public boolean isSingleton() {
		return true;
	}

}
