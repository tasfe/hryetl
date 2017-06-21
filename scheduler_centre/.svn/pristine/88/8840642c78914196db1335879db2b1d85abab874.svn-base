package com.banggo.scheduler.manager;

import java.util.Date;

import javax.annotation.Resource;

import junit.framework.Assert;

import org.junit.Test;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.manager.exception.SchedulerException;

public class JobManagerTest extends SpringTestCase{
	@Resource
	private JobManager jobManager;
	
	@Test
	public void addJob() throws SchedulerException{
		ScheJob job = new ScheJob();
		job.setAppName("mockapp2");
		job.setJobName("job1");
		job.setJobGroup("group1");
		job.setBeginDate(new Date());
		job.setCronExp("* 0/2 * * * ?");
		job.setRemoteUrl("http://localhost:8080/mock_app/task");
		long pk = jobManager.addJob(job);
		Assert.assertTrue(pk != -1);
		
		
	}
	
	@Test
	public void pauseJob() throws SchedulerException{
		boolean rt = jobManager.pauseJob(18);
		Assert.assertTrue(rt);
	}
	
	@Test
	public void resumeJob() throws SchedulerException{
		boolean rt = jobManager.resumeJob(18);
		Assert.assertTrue(rt);
	}
	
	@Test
	public void deleteJob() throws SchedulerException{
		int count = jobManager.deleteJob(22);
		Assert.assertEquals(1, count);
	}
}
