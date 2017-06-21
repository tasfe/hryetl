package com.banggo.scheduler.dao.daointerface;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheUserGroupMember;

public interface ScheUserGroupMemberDAO {
	void insert(ScheUserGroupMember record) throws DataAccessException;

	int updateByPrimaryKey(ScheUserGroupMember record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheUserGroupMember record)
			throws DataAccessException;

	ScheUserGroupMember selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;
	
	int deleteByGroupId(Integer groupId) throws DataAccessException;
}