package com.banggo.scheduler.dao.ibatis;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheManualTriggerDAO;
import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;

public class ScheManualTriggerDAOImpl implements ScheManualTriggerDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public int insert(ScheManualTrigger record) {
		Integer pk = (Integer)sqlMapClient.insert("SCHE_MANUAL_TRIGGER.insert", record);
		return pk == null? -1 : pk.intValue();
				
	}

	public int updateByPrimaryKey(ScheManualTrigger record) {
		int rows = sqlMapClient.update(
				"SCHE_MANUAL_TRIGGER.updateByPrimaryKey", record);
		return rows;
	}

	public int updateByPrimaryKeySelective(ScheManualTrigger record) {
		int rows = sqlMapClient.update(
				"SCHE_MANUAL_TRIGGER.updateByPrimaryKeySelective", record);
		return rows;
	}

	public ScheManualTrigger selectByPrimaryKey(Integer id) {
		ScheManualTrigger key = new ScheManualTrigger();
		key.setId(id);
		ScheManualTrigger record = (ScheManualTrigger) sqlMapClient
				.queryForObject("SCHE_MANUAL_TRIGGER.selectByPrimaryKey", key);
		return record;
	}

	public int deleteByPrimaryKey(Integer id) {
		ScheManualTrigger key = new ScheManualTrigger();
		key.setId(id);
		int rows = sqlMapClient.delete(
				"SCHE_MANUAL_TRIGGER.deleteByPrimaryKey", key);
		return rows;
	}
}