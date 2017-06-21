package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheChainExecuterDAO;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;

public class ScheChainExecuterDAOImpl implements ScheChainExecuterDAO {

	
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	public int insert(ScheChainExecuter record) throws DataAccessException {
		Integer pk = (Integer) sqlMapClient.insert("SCHE_CHAIN_EXECUTER.insert", record);
		return pk == null ? -1 : pk.intValue();
	}

	
	public int updateByPrimaryKey(ScheChainExecuter record) throws DataAccessException {
		int rows = sqlMapClient.update(
				"SCHE_CHAIN_EXECUTER.updateByPrimaryKey",
				record);
		return rows;
	}

	
	public int updateByPrimaryKeySelective(ScheChainExecuter record)
			throws DataAccessException {
		int rows = sqlMapClient
				.update("SCHE_CHAIN_EXECUTER.updateByPrimaryKeySelective",
						record);
		return rows;
	}

	
	public ScheChainExecuter selectByPrimaryKey(Integer id) throws DataAccessException {
		ScheChainExecuter key = new ScheChainExecuter();
		key.setId(id);
		ScheChainExecuter record = (ScheChainExecuter) sqlMapClient
				.queryForObject(
						"SCHE_CHAIN_EXECUTER.selectByPrimaryKey",
						key);
		return record;
	}

	
	public int deleteByPrimaryKey(Integer id) throws DataAccessException {
		ScheChainExecuter key = new ScheChainExecuter();
		key.setId(id);
		int rows = sqlMapClient.delete(
				"SCHE_CHAIN_EXECUTER.deleteByPrimaryKey", key);
		return rows;
	}


	@Override
	public int countScheChainExecuter(Map params) {
		Integer count = (Integer) sqlMapClient.queryForObject("SCHE_CHAIN_EXECUTER.count", params);
		return count == null ? -1 : count.intValue();
	}


	@Override
	public List<ScheChainExecuter> selectScheChainExecuter(Map params) {
		return sqlMapClient.queryForList("SCHE_CHAIN_EXECUTER.query",params);
	}


	@Override
	public List<Integer> queryScheExecuterIdByChainExecuter(
			int scheChainExecuteId) {
		return sqlMapClient.queryForList("SCHE_CHAIN_EXECUTER.queryScheExecuterIds",scheChainExecuteId);
	}
}