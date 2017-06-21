package com.banggo.scheduler.dao.daointerface;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;

public interface ScheAlarmRecordDAO {
	void insert(ScheAlarmRecord record) throws DataAccessException;

	int updateByPrimaryKey(ScheAlarmRecord record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheAlarmRecord record) throws DataAccessException;

	ScheAlarmRecord selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;
	
	int countAlertedTimes(Map params);
}