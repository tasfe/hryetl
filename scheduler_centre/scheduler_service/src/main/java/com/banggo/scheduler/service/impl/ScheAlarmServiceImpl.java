package com.banggo.scheduler.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.banggo.scheduler.async.service.AsyncExecuteService;
import com.banggo.scheduler.dao.daointerface.ScheAlarmDAO;
import com.banggo.scheduler.dao.daointerface.ScheAlarmRecordDAO;
import com.banggo.scheduler.dao.daointerface.ScheUserDAO;
import com.banggo.scheduler.dao.dataobject.ScheAlarm;
import com.banggo.scheduler.dao.dataobject.ScheAlarmMore;
import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;
import com.banggo.scheduler.dao.dataobject.ScheUser;
import com.banggo.scheduler.service.ScheAlarmService;

public class ScheAlarmServiceImpl implements ScheAlarmService {

	@Resource
	private ScheAlarmDAO scheAlarmDAO;
	
	@Resource
	private ScheAlarmRecordDAO scheAlarmRecordDAO;
	
	@Resource
	private ScheUserDAO scheUserDAO;
	
	
	
	@Resource
	private AsyncExecuteService asyncExecuteService;

	@Override
	public void saveAlaram(ScheAlarm scheAlarm) {
		 scheAlarmDAO.insert(scheAlarm);
	}

	@Override
	public ScheAlarm retrieveScheAlarm(long id) {
		return scheAlarmDAO.selectByPrimaryKey(Long.valueOf(id).intValue());
	}

	@Override
	public int updateScheAlarm(ScheAlarm scheAlarm) {
		return scheAlarmDAO.updateByPrimaryKeySelective(scheAlarm);
	}

	@Override
	public List<ScheAlarmMore> queryScheAlarm(Map params) {
		return scheAlarmDAO.select(params);
	}

	@Override
	public int queryScheAlarmSize(Map params) {
		return scheAlarmDAO.count(params);
	}

	@Override
	public int deleteScheAlarm(long id) {
		return scheAlarmDAO.deleteByPrimaryKey(Long.valueOf(id).intValue());
	}

	@Override
	public int countTimes(long scheAlarmId) {
		Map params = new HashMap();
		params.put("scheAlarmId",scheAlarmId);
		
		return scheAlarmRecordDAO.countAlertedTimes(params);
	}

	@Override
	public List<ScheUser> queryUserByUserGroup(Integer scheUserGroupId) {

		return scheUserDAO.queryUserByUserGroup(scheUserGroupId);
	}

	@Override
	public void saveAlarmRecord(ScheAlarmRecord scheAlarmRecord) {
		scheAlarmRecordDAO.insert(scheAlarmRecord);
	}

	@Override
	public int updatesaveAlarmRecord(ScheAlarmRecord scheAlarmRecord) {
		return scheAlarmRecordDAO.updateByPrimaryKey(scheAlarmRecord);
	}
	

	


}
