package com.banggo.scheduler.executer.member.handler;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.dao.DuplicateKeyException;

import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.executer.ScheChainMemberExecuter;
import com.banggo.scheduler.manager.exception.ExecuteException;

public class BarrierNodeHandler extends NodeHandler {
	private static final Logger logger = Logger
			.getLogger(BarrierNodeHandler.class);
	@Resource
	protected  ScheChainMemberExecuter scheChainMemberExecuter;
	
	@Override
	public void handler(ScheChainMember member,
			ScheChainExecuter scheChainExecuter) throws ExecuteException {
		ScheChainBarrier existsBarrier = scheChainService.retrieveScheChainBarrier(member.getScheJobId(),scheChainExecuter.getId());
		
		// 保存执行记录
		saveScheChainExecuterDetailNotify(scheChainExecuter, null, member);
		
		boolean isNew = false;
		if (existsBarrier == null){
			// insert
			try {
				existsBarrier = createBarrier(member, scheChainExecuter);
				isNew = true;
			} catch (DuplicateKeyException e) {
				// 并发情况下会出现此异常
				existsBarrier = scheChainService.retrieveScheChainBarrier(member.getScheJobId(),scheChainExecuter.getId());
				if (existsBarrier != null){
					isNew = false;
				}else{ // why?
					logger.error("保存barrier发生DuplicateKeyException,但又查不到数据？",e);
					throw e;
				}
			}catch (ExecuteException e) {
				throw e;
			}
		}
		
		if (!isNew){
			// 减１
			existsBarrier.setWaitCount(existsBarrier.getWaitCount() - 1);
			existsBarrier.setUpdateDate(new Date());
			scheChainService.updateScheChainBarrier(existsBarrier);
		}
		
		// ref_count是否＝０
		if (existsBarrier.getWaitCount() <= 0){
			// 根据以下事实,找到真正的任务，执行
			// 1) 汇聚任务对应的真实任务一定只挂在一个汇聚节点上
			// 2) 汇聚任务的右子节点一定是其对应的真实任务
			ScheChainMember mainBarrierMember = scheChainService.getMainMemberOfBarrier(existsBarrier);
			if (mainBarrierMember == null){
				throw new ExecuteException("汇聚任务找不到挂接任务的汇聚点ScheChainBarrierId=" + existsBarrier.getId());	
			}
			
			// FIXME 需要检查任务配置确认不会死循环
			List<ScheChainMember> nextMemberList = scheChainMemberExecuter.getNext(mainBarrierMember);
			if (nextMemberList == null ){
				throw new ExecuteException("汇聚节点memberId="+mainBarrierMember.getId()+"下没有真实的任务节点");
			}
			
			for (ScheChainMember scheChainMember : nextMemberList) {
				scheChainMemberExecuter.execute(scheChainMember, scheChainExecuter);
			}
			
		}

	}

	private ScheChainBarrier createBarrier(ScheChainMember member,
			ScheChainExecuter scheChainExecuter) throws ExecuteException {
		ScheChainBarrier barrier = new ScheChainBarrier();
		barrier.setBarrierJobId(member.getScheJobId());
		barrier.setScheChainExecuterId(scheChainExecuter.getId());
		barrier.setScheChainVersion(scheChainExecuter.getScheChainVersion());
		
		// wait count
		int waitCount = scheChainService.countBarrier(scheChainExecuter,member.getScheJobId());
		if (waitCount <= 0){
		  throw new ExecuteException("汇聚任务找不到相应的汇聚点");	
		}
		
		barrier.setWaitCount(waitCount - 1 ); // 减掉自己，因为已到达
		scheChainService.saveScheChainBarrier(barrier);
		return barrier;
	}

}
