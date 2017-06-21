package com.banggo.scheduler.service;

import java.util.List;
import java.util.Map;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;
import com.banggo.scheduler.dao.ro.ScheJobRO;

public interface ScheJobService {
	/**
	 * 保存任务及任务参数到数据库 (需要运行在事务环境)
	 * 
	 * @param scheJob
	 * @return
	 */
	public long saveJob(ScheJob scheJob);

	/**
	 * 获取活动任务信息
	 * 
	 * @param appName
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	public ScheJob retrieveActivityScheJob(String appName, String jobName,
			String jobGroup);

	/**
	 * 查找指定正在运行的任务
	 * 
	 * @param appName
	 * @param jobName
	 * @param jobGroup
	 * @return
	 */
	public List<ScheExecuter> retrieveRunningScheJob(String appName,
			String jobName, String jobGroup);

	/**
	 * 给指定记录加行锁
	 * 
	 * @param shceJobId
	 * @return
	 */
	public ScheJob lock(int scheJobId);

	/**
	 * 创建执行记录
	 * 
	 * @param shceJobId
	 * @return
	 */
	public ScheExecuter createScheExecuter(int shceJobId, String hostId);

	/**
	 * @param scheExecuterId
	 * @return
	 */
	public ScheExecuter retrieveScheExecuter(int scheExecuterId);

	/**
	 * 更新执行记录
	 * 
	 * @param record
	 * @return
	 */
	public int updateScheExecuter(ScheExecuter record);

	/**
	 * 根据jobId查找JOB
	 * 
	 * @param scheJobId
	 * @return
	 */
	public ScheJob retrieveScheJob(int scheJobId);

	/**
	 * 更新job
	 * 
	 * @param scheJob
	 * @return
	 */
	public int updateScheJob(ScheJob scheJob);
	
	/**
	 * 是否同步更新任务参数
	 * @param scheJob
	 * @param cascadeJobParams
	 * @return
	 */
	public int updateScheJob(ScheJob scheJob,boolean cascadeJobParams);

	/**
	 * @param scheExecuterId
	 * @return
	 */
	public ScheJob getScheJobByExecuterId(int scheExecuterId);

	/**
	 * @param execNo
	 * @param remoteExecNo
	 * @return
	 */
	public ScheExecuter getScheExecuterByNo(String execNo, String remoteExecNo);

	/**
	 * @param params
	 * @return
	 */
	public List<ScheExecRecordRO> queryScheExecuter(Map params);
	
	/**
	 * 计算总数
	 * @param params
	 * @return
	 */
	public int queryScheExecuterSize(Map params);

	/**
	 * 根据参数查询
	 * 
	 * @param params
	 * @return
	 */
	public List<ScheJobRO> queryScheJob(Map params);

	/**
	 * 根据参数查询总数
	 * 
	 * @param params
	 * @return
	 */
	public int queryScheJobSize(Map params);

	/**
	 * 根据任务参数查询活动的任务
	 * @param paramName
	 * @param paramValue
	 * @return
	 */
	public List<ScheJob> retrieveActiveScheJobByParamName(
			String paramName, String paramValue);
}
