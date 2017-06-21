package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheJobDAO;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.ro.ScheJobRO;

public class ScheJobDAOImpl implements ScheJobDAO {

	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	public int insert(ScheJob record) {
		Integer pk = (Integer) sqlMapClient.insert("SCHE_JOB.insert", record);
		return pk == null ? -1 : pk.intValue();
	}

	public int updateByPrimaryKey(ScheJob record) {
		int rows = sqlMapClient.update("SCHE_JOB.updateByPrimaryKey", record);
		return rows;
	}

	public int updateByPrimaryKeySelective(ScheJob record) {
		int rows = sqlMapClient.update("SCHE_JOB.updateByPrimaryKeySelective",
				record);
		return rows;
	}

	public ScheJob selectByPrimaryKey(Integer id) {
		ScheJob key = new ScheJob();
		key.setId(id);
		ScheJob record = (ScheJob) sqlMapClient.queryForObject(
				"SCHE_JOB.selectByPrimaryKey", key);
		return record;
	}

	public int deleteByPrimaryKey(Integer id) {
		ScheJob key = new ScheJob();
		key.setId(id);
		int rows = sqlMapClient.delete("SCHE_JOB.deleteByPrimaryKey", key);
		return rows;
	}

	@Override
	public ScheJob selectActivity(Map params) throws DataAccessException {
		return (ScheJob) sqlMapClient.queryForObject("SCHE_JOB.selectActivity",
				params);
	}

	@Override
	public ScheJob selectForupdate(Integer id) throws DataAccessException {
		ScheJob record = (ScheJob) sqlMapClient.queryForObject(
				"SCHE_JOB.selectForupdate", id);
		return record;
	}

	@Override
	public ScheJob selectByExecuterId(int scheExecuterId) {

		ScheJob record = (ScheJob) sqlMapClient.queryForObject(
				"SCHE_JOB.selectByExecuterId", scheExecuterId);
		return record;
	}

	@Override
	public List<ScheJobRO> query(Map params) {
		return sqlMapClient.queryForList("SCHE_JOB.query", params);
	}

	@Override
	public int querySize(Map params) {
		return (Integer) sqlMapClient.queryForObject("SCHE_JOB.querySize",
				params);
	}

	@Override
	public List<ScheJob> selectByParamNameValue(Map params) {
		return sqlMapClient.queryForList("SCHE_JOB.selectByParamNameValue",params);
	}
}