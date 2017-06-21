package com.banggo.scheduler.service;

import java.util.List;
import java.util.Map;

import com.banggo.scheduler.dao.dataobject.ScheChain;
import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;

public interface ScheChainService {
	/**
	 * @param scheJobId
	 * @return
	 */
	public ScheChain retrieveActivityScheChainByJobId(int scheJobId); 
	
	/**
	 * 查找指定任务的起始节点
	 * @param scheChainId
	 * @param startJobId
	 * @return
	 */
	public ScheChainMember startNode(int scheChainId, int startJobId);
	
	
	/**
	 * @param scheChainId
	 * @return
	 */
	public ScheChain retrieveScheChain(int scheChainId);

	/**
	 * @param chainExecuter
	 * @return
	 */
	public int saveScheChainExecuter(ScheChainExecuter chainExecuter);
	
	
	/**
	 * @param detail
	 * @return
	 */
	public void saveSCheChainExecuterDetail(ScheChainExecuterDetail detail);
	
	
	/**
	 * @param intValue
	 */
	public ScheChainMember retrieveScheChainMember(int scheChainMemberId);
	
	
	/**
	 * @param scheExecuterId
	 * @return
	 */
	public List<ScheChainExecuterDetail> queryRunningChainDetailWaitForScheExecuter(int scheExecuterId);

	/**
	 * @param scheChainExecuterId
	 * @return
	 */
	public ScheChainExecuter retrieveScheChainExecuter(Integer scheChainExecuterId);

	
	/**
	 * @param executerDetail
	 */
	public void updateScheChainExecuterDetail(ScheChainExecuterDetail executerDetail);
			
	
	/**
	 * @param scheChainExecuter
	 */
	public void updateSCheChainExecuter(ScheChainExecuter scheChainExecuter);

	/**
	 * 检查是否所有的任务节点都执行完成
	 * @param scheChainExecuter TODO
	 * @param integer
	 * @return
	 */
	public boolean isAllChainMemberExecuted(ScheChainExecuter scheChainExecuter);

	/**
	 * @param barrierJobId
	 * @param scheChainExecuterId
	 * @return
	 */
	public ScheChainBarrier retrieveScheChainBarrier(int barrierJobId,
			int scheChainExecuterId);

	/**
	 * 查询共有多少个汇聚节点
	 * @param scheChainExecuter
	 * @param scheJobId
	 * @return
	 */
	public int countBarrier(ScheChainExecuter scheChainExecuter,
			Integer scheJobId);

	/**
	 * 
	 * @param barrier
	 */
	public void saveScheChainBarrier(ScheChainBarrier barrier);

	/**
	 * @param existsBarrier
	 */
	public void updateScheChainBarrier(ScheChainBarrier existsBarrier);

	/**
	 * @param existsBarrier
	 * @return
	 */
	public ScheChainMember getMainMemberOfBarrier(
			ScheChainBarrier existsBarrier);

	/**
	 * 根据任务链ID和version查找任务链成员
	 * @param scheChainId
	 * @param version
	 * @return
	 */
	public List<ScheChainMember> queryChainMember(int scheChainId, Integer version);

	/**
	 * 查询任务链
	 * @param params
	 * @return
	 */
	public List<ScheChain> queryScheChain(Map params);

	/**
	 * 查询任务链的个数
	 * @param params
	 * @return
	 */
	public int countScheChain(Map params);

	/**
	 * 更新任务链
	 * @param scheChain
	 * @return
	 */
	public int updateSche(ScheChain scheChain);

	/**
	 * 保存任务链成员
	 * @param member
	 * @return
	 */
	public int saveScheChainMember(ScheChainMember member);

	/**
	 * 保存任务链
	 * @param chain
	 * @return
	 */
	public int saveScheChain(ScheChain chain);

	/**
	 *  计算总数
	 * @param params
	 * @return
	 */
	public int countScheChainExecuter(Map params);

	/**
	 * @param params
	 * @return
	 */
	public List<ScheChainExecuter> queryScheChainExecuter(Map params);

	public List<Integer> queryScheExecuterIdByChainExecuter(
			int scheChainExecuteId);

	public ScheChain retriveScheChainByChainName(String chainName);



	
	
}
