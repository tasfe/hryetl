package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheChainMemberDAO;
import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;

public class ScheChainMemberDAOImpl implements ScheChainMemberDAO {

	private SqlMapClientTemplate sqlMapClient;

	
	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	
	public int insert(ScheChainMember record) throws DataAccessException {
		Integer pk = (Integer)sqlMapClient.insert("SCHE_CHAIN_MEMBER.insert", record);
		return pk == null ? -1 : pk.intValue();
	}

	
	public int updateByPrimaryKey(ScheChainMember record) throws DataAccessException {
		int rows = sqlMapClient.update(
				"SCHE_CHAIN_MEMBER.updateByPrimaryKey", record);
		return rows;
	}

	
	public int updateByPrimaryKeySelective(ScheChainMember record)
			throws DataAccessException {
		int rows = sqlMapClient
				.update("SCHE_CHAIN_MEMBER.updateByPrimaryKeySelective",
						record);
		return rows;
	}

	
	public ScheChainMember selectByPrimaryKey(Integer id) throws DataAccessException {
		ScheChainMember key = new ScheChainMember();
		key.setId(id);
		ScheChainMember record = (ScheChainMember) sqlMapClient.queryForObject(
				"SCHE_CHAIN_MEMBER.selectByPrimaryKey", key);
		return record;
	}

	
	public int deleteByPrimaryKey(Integer id) throws DataAccessException {
		ScheChainMember key = new ScheChainMember();
		key.setId(id);
		int rows = sqlMapClient.delete(
				"SCHE_CHAIN_MEMBER.deleteByPrimaryKey", key);
		return rows;
	}


	@Override
	public ScheChainMember leftChild(ScheChainMember node) {
		return (ScheChainMember)sqlMapClient.queryForObject("SCHE_CHAIN_MEMBER.leftChild",node);
	}


	@Override
	public List<ScheChainMember> query(Map params) {
		return (List<ScheChainMember>) sqlMapClient.queryForList("SCHE_CHAIN_MEMBER.query",params);
	}


	@Override
	public List<ScheChainMember> selectUnExecuteFinishedMember(
			Map params) {
		return (List<ScheChainMember>) sqlMapClient.queryForList("SCHE_CHAIN_MEMBER.selectUnExecuteFinishedMember",params);
	}


	@Override
	public ScheChainMember selectMainMemberOfBarrier(
			Map params) {
		return (ScheChainMember)sqlMapClient.queryForObject("SCHE_CHAIN_MEMBER.selectMainMemberOfBarrier",params);
	}

}