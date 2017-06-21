package com.banggo.scheduler.dao.ibatis;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.UpdateKettleDateDAO;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;
import com.banggo.scheduler.dao.dataobject.UpdateKettleDate;

public class UpdateKettleDateDaoImpl implements UpdateKettleDateDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public int updateByPrimaryKey(ScheJobParams record) {
		int rows = sqlMapClient.update("SCHE_JOB_PARAMS.updateByPrimaryKey",
				record);
		return rows;
	}

	public ScheJobParams selectByPrimaryKey(Integer id) {
		ScheJobParams key = new ScheJobParams();
		key.setId(id);
		ScheJobParams record = (ScheJobParams) sqlMapClient.queryForObject(
				"SCHE_JOB_PARAMS.selectByPrimaryKey", key);
		return record;
	}

	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<UpdateKettleDate> query(Map params) throws DataAccessException {
		if (params == null)
			params = new HashMap();
		List<UpdateKettleDate> list = sqlMapClient.queryForList("UPDATE_KETTLE_DATE.query",params);
		return list;
	}

	@Override
	public int update(UpdateKettleDate updateKettleDate)
			throws DataAccessException {
		return sqlMapClient.update("UPDATE_KETTLE_DATE.update", updateKettleDate);
	}
}