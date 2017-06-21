package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheUserGroup;

public interface ScheUserGroupDAO {
	int insert(ScheUserGroup record) throws DataAccessException;

	int updateByPrimaryKey(ScheUserGroup record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheUserGroup record) throws DataAccessException;

	ScheUserGroup selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;
	
	List<ScheUserGroup> select(Map params);

	int count(Map params);
}