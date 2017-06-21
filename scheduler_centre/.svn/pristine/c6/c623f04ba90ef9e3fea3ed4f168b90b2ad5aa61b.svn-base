package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheAlarm;

public interface ScheAlarmDAO {
	void insert(ScheAlarm record) throws DataAccessException;

	int updateByPrimaryKey(ScheAlarm record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheAlarm record) throws DataAccessException;

	ScheAlarm selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;

	List<com.banggo.scheduler.dao.dataobject.ScheAlarmMore> select(Map params);

	int count(Map params);

}