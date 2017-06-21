package com.banggo.scheduler.job.builder;

import java.util.List;

import javax.annotation.Resource;

import com.banggo.scheduler.dao.dataobject.ScheChain;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;
import com.banggo.scheduler.job.JobAdapter;
import com.banggo.scheduler.job.proxy.StartJobChainJobProxy;
import com.banggo.scheduler.manager.exception.SchedulerException;
import com.banggo.scheduler.service.ScheChainService;

public class ChainScheJobBuilder extends AbstractScheJobBuilder {
  public final static String JOB_CHAIN_PARAM_NAME = "chainName";
	
  @Resource
  private ScheChainService scheChainService;
	
	@Override
	public String validateScheJobParams(ScheJob job) {
		String errorMsg = super.validateScheJobParams(job);
		String chainName = getChainName(job.getScheJobParamsList());
		if (chainName == null) {
			errorMsg = "缺少chainName参数";
		}
		
		// 检查chainName对应的任务链是否活动
		ScheChain chain = scheChainService.retriveScheChainByChainName(chainName);
		if (chain == null){
			errorMsg = "任务链：" + chainName + " 不存在";
		}
		return errorMsg;

	}
	
	private String getChainName(List<ScheJobParams> scheJobParamsList) {
		if (scheJobParamsList != null && scheJobParamsList.size() > 0){
			for (ScheJobParams scheJobParams : scheJobParamsList) {
				if (JOB_CHAIN_PARAM_NAME.equals(scheJobParams.getName())){
					return scheJobParams.getValue();
				}
			}
		}
		return null;
	}
	
	@Override
	public boolean resume(ScheJob job) throws SchedulerException {
		String errorMsg = validateScheJobParams(job);
		if (errorMsg != null)
			throw new SchedulerException(errorMsg);
		return super.resume(job);
	}
	
	@Override
	public boolean trigger(ScheJob job, boolean ignoreConcurrent)
			throws SchedulerException {
		String errorMsg = validateScheJobParams(job);
		if (errorMsg != null)
			throw new SchedulerException(errorMsg);
		
		return super.trigger(job, ignoreConcurrent);
	}
	
	@Override
	public Class<? extends JobAdapter> getJobClass() {
		return StartJobChainJobProxy.class;
	}

}
