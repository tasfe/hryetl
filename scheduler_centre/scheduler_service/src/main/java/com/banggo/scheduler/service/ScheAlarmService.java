package com.banggo.scheduler.service;

import java.util.List;
import java.util.Map;

import com.banggo.scheduler.dao.dataobject.ScheAlarm;
import com.banggo.scheduler.dao.dataobject.ScheAlarmMore;
import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;
import com.banggo.scheduler.dao.dataobject.ScheUser;

public interface ScheAlarmService {
	
	/**
	 * @param scheAlarm
	 * @return
	 */
	public void saveAlaram(ScheAlarm scheAlarm);

	/**
	 * @param id
	 * @return
	 */
	public ScheAlarm retrieveScheAlarm(long id);

	/**
	 * @param scheAlarm
	 * @return
	 */
	public int updateScheAlarm(ScheAlarm scheAlarm);


	/**
	 * @param params
	 * @return
	 */
	public List<ScheAlarmMore> queryScheAlarm(Map params);
	
	
	/**
	 * 根据参数查询总数
	 * 
	 * @param params
	 * @return
	 */
	public int queryScheAlarmSize(Map params);
	
	/**
	 * @param id
	 * @return
	 */
	public int deleteScheAlarm(long id);
	
	/**
	 * 返回指定报警配置在指定频率内，已通知的次数
	 * @param scheAlarmId
	 * @return
	 */
	public int countTimes(long scheAlarmId);

	public List<ScheUser> queryUserByUserGroup(Integer scheUserGroupId);

	public void saveAlarmRecord(ScheAlarmRecord scheAlarmRecord);
	public int updatesaveAlarmRecord(ScheAlarmRecord scheAlarmRecord);

}
