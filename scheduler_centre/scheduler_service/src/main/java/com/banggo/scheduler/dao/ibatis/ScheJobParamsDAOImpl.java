package com.banggo.scheduler.dao.ibatis;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheJobParamsDAO;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;

public class ScheJobParamsDAOImpl implements ScheJobParamsDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public void insert(ScheJobParams record) {
		sqlMapClient.insert("SCHE_JOB_PARAMS.insert", record);
	}

	public int updateByPrimaryKey(ScheJobParams record) {
		int rows = sqlMapClient.update("SCHE_JOB_PARAMS.updateByPrimaryKey",
				record);
		return rows;
	}

	public int updateByPrimaryKeySelective(ScheJobParams record) {
		int rows = sqlMapClient.update(
				"SCHE_JOB_PARAMS.updateByPrimaryKeySelective", record);
		return rows;
	}

	public ScheJobParams selectByPrimaryKey(Integer id) {
		ScheJobParams key = new ScheJobParams();
		key.setId(id);
		ScheJobParams record = (ScheJobParams) sqlMapClient.queryForObject(
				"SCHE_JOB_PARAMS.selectByPrimaryKey", key);
		return record;
	}

	public int deleteByPrimaryKey(Integer id) {
		ScheJobParams key = new ScheJobParams();
		key.setId(id);
		int rows = sqlMapClient.delete("SCHE_JOB_PARAMS.deleteByPrimaryKey",
				key);
		return rows;
	}

	@Override
	public int deleteByScheJobId(int scheJobId) throws DataAccessException {
		int rows = sqlMapClient.delete("SCHE_JOB_PARAMS.deleteByScheJobId",
				scheJobId);
		return rows;
	}
}