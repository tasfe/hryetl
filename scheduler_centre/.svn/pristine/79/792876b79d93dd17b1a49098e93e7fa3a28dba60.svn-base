package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheChainDAO;
import com.banggo.scheduler.dao.dataobject.ScheChain;

public class ScheChainDAOImpl implements ScheChainDAO {

	
	private SqlMapClientTemplate sqlMapClient;

	
	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	
	public int insert(ScheChain record) throws DataAccessException {
		return (Integer)sqlMapClient.insert("SCHE_CHAIN.insert", record);
	}

	
	public int updateByPrimaryKey(ScheChain record) throws DataAccessException {
		int rows = sqlMapClient.update(
				"SCHE_CHAIN.updateByPrimaryKey", record);
		return rows;
	}

	
	public int updateByPrimaryKeySelective(ScheChain record)
			throws DataAccessException {
		int rows = sqlMapClient.update(
				"SCHE_CHAIN.updateByPrimaryKeySelective",
				record);
		return rows;
	}

	
	public ScheChain selectByPrimaryKey(Integer id) throws DataAccessException {
		ScheChain key = new ScheChain();
		key.setId(id);
		ScheChain record = (ScheChain) sqlMapClient.queryForObject(
				"SCHE_CHAIN.selectByPrimaryKey", key);
		return record;
	}

	
	public int deleteByPrimaryKey(Integer id) throws DataAccessException {
		ScheChain key = new ScheChain();
		key.setId(id);
		int rows = sqlMapClient.delete(
				"SCHE_CHAIN.deleteByPrimaryKey", key);
		return rows;
	}


	@Override
	public ScheChain selectActivityByJobId(int scheJobId) {
		 return (ScheChain)sqlMapClient.queryForObject("SCHE_CHAIN.selectActivityByJobId", scheJobId);

	}


	@Override
	public List<ScheChain> query(Map params) {
		return sqlMapClient.queryForList("SCHE_CHAIN.query",params);
	}


	@Override
	public int count(Map params) {
	 Integer count =  (Integer)sqlMapClient.queryForObject("SCHE_CHAIN.count",params);
	  return count == null? 0 : count.intValue();
	}


	@Override
	public ScheChain selectByChainName(String chainName) {
		List<ScheChain> list = sqlMapClient.queryForList("SCHE_CHAIN.selectByChainName",chainName);
		if (list != null && list.size() > 0){
			return list.get(0);
		}
		return null;
	}
}