package com.banggo.scheduler.manager;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.manager.exception.SchedulerException;

public class ExecuteManagerTest extends SpringTestCase{
	@Resource
	private ExecuteManager executeManager;
	
	@Test
	public void runImmediately() throws SchedulerException, ExecuteException{
		boolean rs = executeManager.runImmediately(92,true);
		Assert.assertTrue(rs);
	}
	
	@Test
	public void interrupt() throws SchedulerException, ExecuteException{
		executeManager.interrupt(18);
	}
	
}
