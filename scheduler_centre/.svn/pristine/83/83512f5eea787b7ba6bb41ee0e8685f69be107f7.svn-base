package com.banggo.scheduler.dao.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheExecuterDAO;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;

public class ScheExecuterDAOImpl implements ScheExecuterDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public int insert(ScheExecuter record) {
		encodeException(record);
		
		Integer pk = (Integer)sqlMapClient.insert("SCHE_EXECUTER.insert", record);
		return pk;
	}

	private void encodeException(ScheExecuter record) {
		if (record != null && record.getException() != null ){
			try {
				record.setException(new String(Base64.encodeBase64(record.getException().getBytes("utf-8")),"utf-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int updateByPrimaryKey(ScheExecuter record) {
		encodeException(record);
		int rows = sqlMapClient.update("SCHE_EXECUTER.updateByPrimaryKey",
				record);
		return rows;
	}

	public int updateByPrimaryKeySelective(ScheExecuter record) {
		encodeException(record);
		int rows = sqlMapClient.update(
				"SCHE_EXECUTER.updateByPrimaryKeySelective", record);
		return rows;
	}

	public ScheExecuter selectByPrimaryKey(Integer id) {
		ScheExecuter key = new ScheExecuter();
		key.setId(id);
		ScheExecuter record = (ScheExecuter) sqlMapClient.queryForObject(
				"SCHE_EXECUTER.selectByPrimaryKey", key);
		
		decodeException(record);
		return record;
	}

	private void decodeException(ScheExecuter record) {
		if (record != null &&  record.getException() != null ){
			try {
				record.setException(new String(Base64.decodeBase64(record.getException().getBytes("utf-8")),"utf-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public int deleteByPrimaryKey(Integer id) {
		ScheExecuter key = new ScheExecuter();
		key.setId(id);
		int rows = sqlMapClient.delete("SCHE_EXECUTER.deleteByPrimaryKey", key);
		return rows;
	}

	@Override
	public List<ScheExecuter> queryRunnig(Map params) throws DataAccessException {
		List<ScheExecuter> result = sqlMapClient.queryForList("SCHE_EXECUTER.queryRunnig",params);
		for (ScheExecuter scheExecuter : result) {
			decodeException(scheExecuter);
		}
		return result;
	}

	@Override
	public ScheExecuter select(Map params) throws DataAccessException {
		ScheExecuter record = (ScheExecuter) sqlMapClient.queryForObject(
				"SCHE_EXECUTER.select", params);
		decodeException(record);
		return record;
	}

	@Override
	public List<ScheExecRecordRO> query(Map params) throws DataAccessException {
		List<ScheExecRecordRO> result = sqlMapClient.queryForList("SCHE_EXECUTER.query",params);
		for (ScheExecRecordRO scheExecRecordRO : result) {
			if ( scheExecRecordRO.getException() != null ){
				try {
					scheExecRecordRO.setException(new String(Base64.decodeBase64(scheExecRecordRO.getException().getBytes("utf-8")),"utf-8"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}

	@Override
	public int count(Map params) throws DataAccessException {
		Integer count = (Integer)sqlMapClient.queryForObject("SCHE_EXECUTER.count",params);
		return count == null? 0 : count.intValue();
	}

	@Override
	public int updateStatus(Integer id, String status) {
		if (status == null){
			return 0;
		}
		
		Map params = new HashMap();
		params.put("id", id);
		params.put("status", status);
		
		return sqlMapClient.update("SCHE_EXECUTER.updateStatus", params);
	}
}