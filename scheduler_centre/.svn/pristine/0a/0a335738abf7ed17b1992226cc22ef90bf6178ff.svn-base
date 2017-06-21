package com.banggo.scheduler.executer;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.executer.member.handler.NodeHandler;
import com.banggo.scheduler.executer.member.handler.NodeHandlerFactory;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.service.ScheChainService;

public class ScheChainMemberExecuter {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ScheChainMemberExecuter.class);

	
	@Resource
	private ScheChainService scheChainService;

	@Resource
	private NodeHandlerFactory nodeHandlerFactory;

	/**
	 * 执行指定链成员
	 * @param member
	 * @param scheChainExecuter
	 * @throws ExecuteException
	 */
	public void execute(ScheChainMember member,
			ScheChainExecuter scheChainExecuter)
			throws ExecuteException {
		
		if (member == null || scheChainExecuter == null){
			logger.error("错误的参数，ScheChainMember或ScheChainExecuter为空");
			throw new IllegalArgumentException("错误的参数，ScheChainMember或ScheChainExecuter为空");
		}
		
		try {
			NodeHandler nodeHandelr = nodeHandlerFactory.getHandler(member.getScheJobId());
			nodeHandelr.handler(member, scheChainExecuter);
		} catch (Exception e) {
			logger.error("执行ScheChainMember:" + member.getId() + " 出错.ScheChainExecuterId = " + scheChainExecuter.getId(), e);
			
			String exception = scheChainExecuter.getException() == null? "" : scheChainExecuter.getException() + "\r\n\n\n";
			scheChainExecuter.setException(exception + e);
			scheChainService.updateSCheChainExecuter(scheChainExecuter);
			
			throw new ExecuteException(e);
		}

	}
	
	/**
	 * 执行指定链成员
	 * @param scheMemeberId
	 * @param scheChainExecuter
	 * @throws ExecuteException
	 */
	public void executer(int scheMemeberId,ScheChainExecuter scheChainExecuter) throws ExecuteException{
		ScheChainMember member = scheChainService.retrieveScheChainMember(scheMemeberId);
		execute(member, scheChainExecuter);
	}
	/**
	 * 　后续需要同时执行的MEMBER
	 * 
	 * @return
	 */
	public List<ScheChainMember> getNext(ScheChainMember member) {
		Integer nextNodeId = member.getRightNode();
		if (nextNodeId == null){
			return null;
		}
		
		ScheChainMember nextMember = scheChainService.retrieveScheChainMember(nextNodeId);
		if (nextMember == null){
			return null;
		}
		
		List<ScheChainMember> resultList = new ArrayList<ScheChainMember>();
		resultList.add(nextMember);
		
		recursionLeftNode(nextMember,resultList);
		return resultList;
	}
	
	/**
	 * @param scheChainMemberId
	 * @return
	 */
	public List<ScheChainMember> getNext(int scheChainMemberId) {
		
		ScheChainMember member = scheChainService.retrieveScheChainMember(scheChainMemberId);
		if (member == null){
			return null;
		}
		return getNext(member);
		
	}
	
	/**
	 * 递归查找指定节点的左节点，将结果保存在resultList中
	 * @param nextMember
	 * @param resultList
	 */
	private void recursionLeftNode(ScheChainMember member,
			List<ScheChainMember> resultList) {
		if (member == null || member.getLeftNode() == null){
			return;
		}
		
		ScheChainMember nextMember = scheChainService.retrieveScheChainMember(member.getLeftNode());
		if (nextMember == null){
			return ;
		}
		resultList.add(nextMember);
		
		recursionLeftNode(nextMember,resultList);
	}
	
	
	
	public void terminateScheChain(ScheChainExecuter scheChainExecuter) {
		if (scheChainExecuter == null){
			return;
		}
		
		scheChainExecuter.setEndTime(new Date());
		scheChainExecuter.setStatus(ScheChainExecuter.STATUS_TERMINATE);
		
		scheChainService.updateSCheChainExecuter(scheChainExecuter);
	}
	
}
