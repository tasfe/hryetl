package com.banggo.scheduler.job.builder;

import org.apache.commons.lang.StringUtils;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.job.JobAdapter;
import com.banggo.scheduler.job.proxy.HessianExecuteJobProxy;

public class HessianScheJobBuilder extends AbstractScheJobBuilder {

	@Override
	public String validateScheJob(ScheJob job) {
		String errorMsg = super.validateScheJob(job);
		if (errorMsg != null){
			return errorMsg;
		}
		
		if (StringUtils.isEmpty(job.getRemoteUrl())) {
			errorMsg = "应用系统URL格式不对";
		}
		return errorMsg;
	}
	
	@Override
	public Class<? extends JobAdapter> getJobClass() {
		return HessianExecuteJobProxy.class;
	}

}
