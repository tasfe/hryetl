package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheUser;

public interface ScheUserDAO {
	void insert(ScheUser record) throws DataAccessException;

	int updateByPrimaryKey(ScheUser record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheUser record) throws DataAccessException;

	ScheUser selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;
	
	public List<ScheUser> selectByList(Map params);

	List<ScheUser> queryUserByUserGroup(Integer scheUserGroupId);
}