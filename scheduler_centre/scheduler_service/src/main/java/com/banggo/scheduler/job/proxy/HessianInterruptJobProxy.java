package com.banggo.scheduler.job.proxy;

import com.banggo.scheduler.job.HessianInterruptJob;
import com.banggo.scheduler.job.JobAdapter;

/**
 * 
 * 功能: 将Quartz的任务转为自己的任务(使用自定义的表结构记录
 * 任务)
 *
 */
public class HessianInterruptJobProxy extends JobAdapter {


	@Override
	protected String getJobInterfaceName() {
		return HessianInterruptJob.class.getName();
	}

}
