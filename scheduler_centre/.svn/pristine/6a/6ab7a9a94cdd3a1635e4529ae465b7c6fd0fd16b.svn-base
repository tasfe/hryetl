package com.banggo.scheduler.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.banggo.scheduler.dao.daointerface.ScheChainBarrierDAO;
import com.banggo.scheduler.dao.daointerface.ScheChainDAO;
import com.banggo.scheduler.dao.daointerface.ScheChainExecuterDAO;
import com.banggo.scheduler.dao.daointerface.ScheChainExecuterDetailDAO;
import com.banggo.scheduler.dao.daointerface.ScheChainMemberDAO;
import com.banggo.scheduler.dao.dataobject.ScheChain;
import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;
import com.banggo.scheduler.service.ScheChainService;


public class ScheChainServiceImpl implements ScheChainService {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ScheChainServiceImpl.class);

	@Resource
	private ScheChainDAO scheChainDAO;
	
	@Resource
	private ScheChainMemberDAO scheChainMemberDAO;
	
	@Resource
	private ScheChainExecuterDAO scheChainExecuterDAO;
	
	@Resource
	private ScheChainExecuterDetailDAO scheChainExecuterDetailDAO;
	
	@Resource
	private ScheChainBarrierDAO scheChainBarrierDAO;

	@Override
	public ScheChain retrieveActivityScheChainByJobId(int scheJobId) {
		return scheChainDAO.selectActivityByJobId(scheJobId);
	}

	@Override
	public int saveScheChainExecuter(ScheChainExecuter chainExecuter) {
		return scheChainExecuterDAO.insert(chainExecuter);
	}

	@Override
	public void saveSCheChainExecuterDetail(ScheChainExecuterDetail detail) {
		scheChainExecuterDetailDAO.insert(detail);
	}

	@Override
	public void updateSCheChainExecuter(ScheChainExecuter scheChainExecuter) {
		scheChainExecuterDAO.updateByPrimaryKey(scheChainExecuter);
	}

	@Override
	public ScheChain retrieveScheChain(int scheChainId) {
		return scheChainDAO.selectByPrimaryKey(scheChainId);
	}

	@Override
	public List<ScheChainExecuterDetail> queryRunningChainDetailWaitForScheExecuter(
			int scheExecuterId) {
		Map params = new HashMap();
		params.put("scheExecuterId", scheExecuterId);
		params.put("status", ScheChainExecuterDetail.STATUS_UN_NOTIFIED);
		
		return scheChainExecuterDetailDAO.queryActivity(params);
	}

	@Override
	public ScheChainMember startNode(int scheChainId, int startJobId) {
		Map params = new HashMap();
		params.put("scheChainId", scheChainId);
		params.put("scheJobId", startJobId);
		List<ScheChainMember> resultList =  scheChainMemberDAO.query(params);
		return (resultList == null || resultList.size() == 0)? null : resultList.get(0);
	}

	@Override
	public ScheChainMember retrieveScheChainMember(int scheChainMemberId) {
		return scheChainMemberDAO.selectByPrimaryKey(scheChainMemberId);
	}

	@Override
	public ScheChainExecuter retrieveScheChainExecuter(
			Integer scheChainExecuterId) {
		return scheChainExecuterDAO.selectByPrimaryKey(scheChainExecuterId);
	}

	@Override
	public void updateScheChainExecuterDetail(
			ScheChainExecuterDetail executerDetail) {
		scheChainExecuterDetailDAO.updateByPrimaryKey(executerDetail);
		
	}

	@Override
	public boolean isAllChainMemberExecuted(ScheChainExecuter scheChainExecuter) {
		Map params = new HashMap();
		params.put("scheChainExecuterId", scheChainExecuter.getId());
		params.put("version", scheChainExecuter.getScheChainVersion());
		params.put("scheChainId", scheChainExecuter.getScheChainId());
		
		List<ScheChainMember>  list = scheChainMemberDAO.selectUnExecuteFinishedMember(params);
		return !(list != null && list.size() > 0);
	}

	@Override
	public ScheChainBarrier retrieveScheChainBarrier(int barrierJobId,
			int scheChainExecuterId) {
		Map params = new HashMap();
		params.put("barrierJobId", barrierJobId);
		params.put("scheChainExecuterId", scheChainExecuterId);
		List<ScheChainBarrier> list = scheChainBarrierDAO.select(params);
		if (list != null && list.size() > 0){
			return list.get(0);
		}
				
		return  null ;
	}

	@Override
	public int countBarrier(ScheChainExecuter scheChainExecuter,
			Integer scheJobId) {
		Map params = new HashMap();
		params.put("onlyScheChainId", scheChainExecuter.getScheChainId());
		params.put("version", scheChainExecuter.getScheChainVersion());
		params.put("scheJobId", scheJobId);
		List<ScheChainMember> members = scheChainMemberDAO.query(params);
		if (members != null ){
			return members.size();
		}
		return 0;
	}

	@Override
	public void saveScheChainBarrier(ScheChainBarrier barrier) {
		if (barrier == null)
			return;
		scheChainBarrierDAO.insert(barrier);
	}

	@Override
	public void updateScheChainBarrier(ScheChainBarrier existsBarrier) {
		if (existsBarrier == null){
			return ;
		}
		scheChainBarrierDAO.updateByPrimaryKeySelective(existsBarrier);
	}

	@Override
	public ScheChainMember getMainMemberOfBarrier(ScheChainBarrier existsBarrier) {
		if (existsBarrier == null){
			return null;
		}
		ScheChainExecuter chainExecuter = retrieveScheChainExecuter(existsBarrier.getScheChainExecuterId());
		if (chainExecuter == null ){
			return null;
		}
		Map params = new HashMap();
		params.put("version", existsBarrier.getScheChainVersion());
		params.put("scheJobId", existsBarrier.getBarrierJobId());
		params.put("scheChainId", chainExecuter.getScheChainId());
		return scheChainMemberDAO.selectMainMemberOfBarrier(params);
	}

	@Override
	public List<ScheChainMember> queryChainMember(int scheChainId,
			Integer version) {
		Map params = new HashMap();
		params.put("onlyScheChainId", scheChainId);
		params.put("version", version);
		return scheChainMemberDAO.query(params);
	}

	@Override
	public List<ScheChain> queryScheChain(Map params) {
		return scheChainDAO.query(params);
	}

	@Override
	public int countScheChain(Map params) {
		return scheChainDAO.count(params);
	}

	@Override
	public int updateSche(ScheChain scheChain) {
		return scheChainDAO.updateByPrimaryKeySelective(scheChain);
	}

	@Override
	public int saveScheChainMember(ScheChainMember member) {
		return scheChainMemberDAO.insert(member);
	}

	@Override
	public int saveScheChain(ScheChain chain) {
		int pk = scheChainDAO.insert(chain);
		chain.setId(pk);
		return pk;
	}

	@Override
	public int countScheChainExecuter(Map params) {
		return scheChainExecuterDAO.countScheChainExecuter(params);
	}

	@Override
	public List<ScheChainExecuter> queryScheChainExecuter(Map params) {
		return scheChainExecuterDAO.selectScheChainExecuter(params);
	}

	@Override
	public List<Integer> queryScheExecuterIdByChainExecuter(
			int scheChainExecuteId) {
		return scheChainExecuterDAO.queryScheExecuterIdByChainExecuter(scheChainExecuteId);
	}

	@Override
	public ScheChain retriveScheChainByChainName(String chainName) {
		// TODO Auto-generated method stub
		return scheChainDAO.selectByChainName(chainName);
	}

}
