package com.banggo.scheduler.executer.member.handler;

import javax.annotation.Resource;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.service.ScheChainService;

public abstract class NodeHandler {
	@Resource
	protected ScheChainService scheChainService;
	
	public abstract void handler(ScheChainMember member,
			ScheChainExecuter scheChainExecuter) throws ExecuteException;
	
	protected void saveScheChainExecuterDetail(
			ScheChainExecuter scheChainExecuter, ScheExecuter scheExecuter, ScheChainMember scheChainMember) {
		saveScheChainExecuterDetail(scheChainExecuter,scheExecuter,scheChainMember,false);
	}
	
	protected void saveScheChainExecuterDetailNotify(
			ScheChainExecuter scheChainExecuter, ScheExecuter scheExecuter, ScheChainMember scheChainMember) {
		saveScheChainExecuterDetail(scheChainExecuter,scheExecuter,scheChainMember,true);
	}
	
	private void saveScheChainExecuterDetail(
			ScheChainExecuter scheChainExecuter, ScheExecuter scheExecuter, ScheChainMember scheChainMember,boolean notifyFlag) {
		
		ScheChainExecuterDetail detail = new ScheChainExecuterDetail();
		detail.setScheChainExecuterId(scheChainExecuter.getId());
		if (scheExecuter != null){
			detail.setScheExecuterId(scheExecuter.getId());
		}
		
		if (notifyFlag){
			detail.setStatus(ScheChainExecuterDetail.STATUS_NOTIFIED);
		}else{
			detail.setStatus(ScheChainExecuterDetail.STATUS_UN_NOTIFIED);
		}
		
		detail.setScheChainMemeberId(scheChainMember.getId());
		
		scheChainService.saveSCheChainExecuterDetail(detail);
	}
}
