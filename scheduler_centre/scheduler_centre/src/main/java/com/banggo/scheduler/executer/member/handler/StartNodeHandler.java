package com.banggo.scheduler.executer.member.handler;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.manager.exception.ExecuteException;

public class StartNodeHandler extends NodeHandler {

	@Override
	public void handler(ScheChainMember member,
			ScheChainExecuter scheChainExecuter) throws ExecuteException {
		try {
			saveScheChainExecuterDetailNotify(scheChainExecuter, null, member);
		} catch (Exception e) {
			throw new ExecuteException(e);
		}
	}

}
