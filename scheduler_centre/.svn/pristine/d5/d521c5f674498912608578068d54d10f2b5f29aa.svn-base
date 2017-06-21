package com.banggo.scheduler.service;

import java.util.List;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;

public class ScheJobServiceTest extends SpringTestCase{
	@Resource
	private ScheJobService scheJobService;
	
	@Test
	public void updateStatus() {
		ScheExecuter record = new ScheExecuter();
		record.setId(18);
		record.setStatus("2");
		record.setRemoteExecNo("test");
		int count = scheJobService.updateScheExecuter(record);
		Assert.assertEquals(0, count);
		
	}
	
	@Test
	public void updateStatusSuccess() {
		ScheExecuter record = new ScheExecuter();
		record.setId(14);
		record.setStatus("2");  // 0 --> -1
		record.setRemoteExecNo("test");
		int count = scheJobService.updateScheExecuter(record);
		Assert.assertEquals(1,count);
		
	}
	
	
}
