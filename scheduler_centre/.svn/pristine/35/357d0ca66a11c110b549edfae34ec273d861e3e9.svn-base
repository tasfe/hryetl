package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.ro.ScheJobRO;

public interface ScheJobDAO {

	int insert(ScheJob record) throws DataAccessException;

	int updateByPrimaryKey(ScheJob record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheJob record) throws DataAccessException;

	ScheJob selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;

	ScheJob selectActivity(Map params) throws DataAccessException;

	ScheJob selectForupdate(Integer id) throws DataAccessException;

	ScheJob selectByExecuterId(int scheExecuterId);

	List<ScheJobRO> query(Map params);

	int querySize(Map params);

	List<ScheJob> selectByParamNameValue(Map params);
}