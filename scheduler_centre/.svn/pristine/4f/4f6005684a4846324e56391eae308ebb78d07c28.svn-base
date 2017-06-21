package com.banggo.scheduler.job;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.quartz.JobExecutionException;

import com.banggo.scheduler.constant.ScheChainConstant;
import com.banggo.scheduler.dao.dataobject.ScheChain;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.executer.ScheChainMemberExecuter;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.manager.util.JobUtils;
import com.banggo.scheduler.service.ScheChainService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.support.QtzSchedulerInstanceIdHolder;

public class StartJobChainJobImpl implements StartJobChainJob {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(StartJobChainJobImpl.class);

	@Resource
	protected ScheJobService scheJobService;
	
	@Resource
	protected ScheChainService scheChainService;
	
	@Resource
	protected  ScheChainMemberExecuter scheChainMemberExecuter;
	
	

	@Override
	public void execute(ScheJobContext context) throws JobExecutionException {
		// 查找任务链
		ScheJob scheJob = scheJobService.retrieveActivityScheJob(context.getAppName(), context.getJobName(), context.getJobGroup());
		if (scheJob == null){
			logger.error("找不到对应的活动任务,无法触发:" + context);
			throwFatalError(context);
		}
		
		ScheChain scheChain = scheChainService.retrieveActivityScheChainByJobId(scheJob.getId());
		if (scheChain == null){
			logger.error("找不到对应的任务链,无法触发:" + context);
			throwFatalError(context);
		}
		
		// 查找任务链起始节点
		ScheChainMember startNode = findStartNode(scheChain.getId());
		if (startNode == null){
			logger.error("找不到任务链的起始节点,无法触发:" + context);
			throwFatalError(context);
		}
		
		// 记录任务链执行记录
		ScheChainExecuter scheChainExecuter = saveScheChainExecuter(scheChain);
		
		// 执行起始节点
		try {
			scheChainMemberExecuter.execute(startNode,scheChainExecuter);
		} catch (ExecuteException e) {
			scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
			return;
		}
		
		// 执行后续节点
		List<ScheChainMember> scheChainMemberList = scheChainMemberExecuter.getNext(startNode);
		if (scheChainMemberList == null){
			scheChainExecuter.setException("起始节点:" + startNode.getId() + "后没有任务节点，执行失败");
			scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
			return;
		}
		
		// 触发第一个步骤中的任务
		for (ScheChainMember scheChainMember : scheChainMemberList) {
			try {
				scheChainMemberExecuter.execute(scheChainMember,scheChainExecuter);
			} catch (ExecuteException e) {
				// 检查本节点是否执行失败，是否允许失败。如果执行失败，且不允许失败，则终止整个任务链的执行
				if (ScheChainMember.TERMINATE_ON_ERROR.equals(scheChainMember.getTerminateOnError())){
					scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
					break;
				}
			}
		}
		
	}
	

	
	private ScheChainMember findStartNode(int scheChainId) {
		return scheChainService.startNode(scheChainId,ScheChainConstant.START_JOB_ID);
	}


	private ScheChainExecuter saveScheChainExecuter(ScheChain scheChain) {
		ScheChainExecuter chainExecuter = new ScheChainExecuter();
		chainExecuter.setBeginTime(new Date());
		chainExecuter.setScheChainId(scheChain.getId());
		chainExecuter.setScheChainVersion(scheChain.getVersion());
		
		chainExecuter.setStatus(ScheChainExecuter.STATUS_RUNNING);
		chainExecuter.setExecNo("chain_"
				+ JobUtils.genExecuterNo(QtzSchedulerInstanceIdHolder
						.getQtzSchedulerInstanceId())); // 生成任务链执行编号

		int id = scheChainService.saveScheChainExecuter(chainExecuter);
		chainExecuter.setId(id);
		return chainExecuter;

	}

	

	/**
	 * @param context
	 * @throws JobExecutionException
	 */
	protected void throwFatalError(ScheJobContext context)
			throws JobExecutionException {
		// 找到任务相关的信息，不再触发该任务
		JobExecutionException fatalError =  new JobExecutionException("找不到任务信息,不再触发任务:" + context);
		fatalError.setUnscheduleFiringTrigger(true);
		throw fatalError;
	}

}
