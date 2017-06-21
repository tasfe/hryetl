package com.banggo.scheduler.event;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.executer.ScheChainMemberExecuter;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.service.ScheChainService;
import com.banggo.scheduler.service.ScheJobService;

public class ExecuteFinishedListener implements Listener {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ExecuteFinishedListener.class);
	
	@Resource
	protected ScheJobService scheJobService;
	
	@Resource
	protected ScheChainService scheChainService;
	
	
	@Resource
	protected  ScheChainMemberExecuter scheChainMemberExecuter;
	
	
	@Override
	public void onEvent(Event e) {
		if (e == null){
			return ;
		}
		
		ExecuteFinishedEvent event = (ExecuteFinishedEvent)e;
		
		ScheExecuter scheExecuter = event.getScheExecuter();
		if (scheExecuter == null){
			return;
		}
		
		// 检查是否有任务链在等待该任务执行完成
		List<ScheChainExecuterDetail> executerDetailList = scheChainService.queryRunningChainDetailWaitForScheExecuter(scheExecuter.getId());
		if (executerDetailList == null || executerDetailList.size() == 0){
			return;
		}
		
		for (ScheChainExecuterDetail executerDetail : executerDetailList) {
		 	try {
				startNext(scheExecuter,executerDetail);
			} catch (Exception exp) {
				logger.error(exp);
			}
		}

	}

	private void startNext(ScheExecuter scheExecuter,
			ScheChainExecuterDetail executerDetail) {
		// 更新通知状态
		setScheChainExecuterDetailNotifyStatus(executerDetail);
					
		ScheChainMember currentMember = scheChainService.retrieveScheChainMember(executerDetail.getScheChainMemeberId());
		ScheChainExecuter scheChainExecuter = scheChainService.retrieveScheChainExecuter(executerDetail.getScheChainExecuterId());
		
		if (ScheChainMember.TERMINATE_ON_ERROR.equals(currentMember.getTerminateOnError())
				&& !ScheExecuter.RESULT_SUCCESS.equals(scheExecuter.getResult())){
			// 未知结果也认为是失败
			scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
			return ;
		}
		
		// 执行后续节点
		List<ScheChainMember> scheChainMemberList = scheChainMemberExecuter.getNext(currentMember);
		if (scheChainMemberList != null && scheChainMemberList.size() > 0){
			// 触发任务
			for (ScheChainMember scheChainMember : scheChainMemberList) {
				try {
					scheChainMemberExecuter.execute(scheChainMember,scheChainExecuter);
				} catch (ExecuteException exception) {
					// 检查本节点是否执行失败，是否允许失败。如果执行失败，且不允许失败，则终止整个任务链的执行
					if (ScheChainMember.TERMINATE_ON_ERROR.equals(scheChainMember.getTerminateOnError())){
						scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
						break;
					}
				}
			}
			
		}else{
			// 没有后续节点，检查是否都执行完了，如果所有节点都执行完成，则关闭这个执行记录
			if (scheChainService.isAllChainMemberExecuted(scheChainExecuter)){
				scheChainMemberExecuter.terminateScheChain(scheChainExecuter);
			}
		}
	}

	private void setScheChainExecuterDetailNotifyStatus(
			ScheChainExecuterDetail executerDetail) {
		executerDetail.setStatus(ScheChainExecuterDetail.STATUS_NOTIFIED);
		scheChainService.updateScheChainExecuterDetail(executerDetail);
	}

	

	@Override
	public boolean isListenTo(Event e) {
		if (e.getEventName().equalsIgnoreCase(ExecuteFinishedEvent.eventName)){
			return true;
		}
		return false;
	}
	

}
