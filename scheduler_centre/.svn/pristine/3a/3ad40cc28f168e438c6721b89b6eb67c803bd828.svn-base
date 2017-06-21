package com.banggo.scheduler.executer.member.handler;

import javax.annotation.Resource;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.executer.HessianJobExecuter;
import com.banggo.scheduler.manager.exception.ExecuteException;

public class HessianNodeHandler extends NodeHandler {
	@Resource
	private HessianJobExecuter hessianJobExecuter;
	
	@Override
	public void handler(ScheChainMember member,
			ScheChainExecuter scheChainExecuter) throws ExecuteException {
		
		try {
			ScheExecuter scheExecuter = hessianJobExecuter.execute(	member.getScheJobId());
				
			// 保存成员节点的执行记录
			saveScheChainExecuterDetail(scheChainExecuter, scheExecuter, member);
			if (ScheExecuterStatus.toEnum(scheExecuter.getStatus()) == ScheExecuterStatus.triggerFailed ||
					ScheExecuter.RESULT_FAILED.equals(scheExecuter.getResult())){
				throw new ExecuteException("触发失败");
			}
		} catch (Exception e) {
			throw new ExecuteException(e);
		}

	}

}
