package com.banggo.scheduler.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.daointerface.ScheExecuterDAO;
import com.banggo.scheduler.dao.daointerface.ScheJobDAO;
import com.banggo.scheduler.dao.daointerface.ScheJobParamsDAO;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.dataobject.ScheJobParams;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;
import com.banggo.scheduler.dao.ro.ScheJobRO;
import com.banggo.scheduler.manager.util.JobUtils;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;

public class ScheJobServiceImpl implements ScheJobService {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ScheJobServiceImpl.class);

	@Resource
	private ScheJobDAO scheJobDAO;

	@Resource
	private ScheJobParamsDAO scheJobParamsDAO;

	@Resource
	private ScheExecuterDAO scheExecuterDAO;

	@Resource
	private TransactionService transactionService;

	@Override
	public long saveJob(ScheJob scheJob) {
		int pk = -1;
		if (scheJob == null) {
			return pk;
		}

		TransactionStatus ts = transactionService.begin(); // 启动事务

		try {
			scheJob.setStatus(ScheJob.STATUS_NOMAL);
			
			pk = scheJobDAO.insert(scheJob);
			if (pk == -1) {
				logger.warn("保存scheJob出错 " + scheJob);
				return -1;
			}

			List<ScheJobParams> paramsList = scheJob.getScheJobParamsList();
			if (paramsList != null && !paramsList.isEmpty()) {
				for (Iterator<ScheJobParams> iterator = paramsList.iterator(); iterator
						.hasNext();) {
					ScheJobParams scheJobParams = iterator.next();
					if (scheJobParams.getName() == null){
						continue;
					}
					scheJobParams.setScheJobId(pk);
					scheJobParamsDAO.insert(scheJobParams);
				}
			}

			transactionService.commit(ts); // 提交事务
		} catch (Throwable t) {
			transactionService.rollback(ts);
		}

		return pk;
	}

	@Override
	@SuppressWarnings({ "rawtypes" })
	public ScheJob retrieveActivityScheJob(String appName, String jobName,
			String jobGroup) {

		Map params = createBaseMap(appName, jobName, jobGroup);

		return scheJobDAO.selectActivity(params);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map createBaseMap(String appName, String jobName, String jobGroup) {
		Map params = new HashMap();
		if (StringUtils.isNotEmpty(appName)) {
			params.put("appName", appName);
		}
		if (StringUtils.isNotEmpty(jobName)) {
			params.put("jobName", jobName);
		}
		if (StringUtils.isNotEmpty(jobGroup)) {
			params.put("jobGroup", jobGroup);
		}
		return params;
	}

	@Override
	public List<ScheExecuter> retrieveRunningScheJob(String appName,
			String jobName, String jobGroup) {
		Map params = createBaseMap(appName, jobName, jobGroup);
		return scheExecuterDAO.queryRunnig(params);
	}

	@Override
	public ScheJob lock(int shceJobId) {
		return scheJobDAO.selectForupdate(shceJobId);
	}

	@Override
	public ScheExecuter createScheExecuter(int scheJobId,String hostId) {
		ScheExecuter se = new ScheExecuter();
		se.setBeginTime(new Date());
		se.setScheJobId(scheJobId);
		se.setStatus(ScheExecuterStatus.init);
		se.setExecNo(JobUtils.genExecuterNo(hostId));

		int pk = scheExecuterDAO.insert(se);
		se.setId(pk);

		return se;
	}

	@Override
	public int updateScheExecuter(ScheExecuter record) {
		// 状态与其它更新分开
		int effCount = 0;
		String status = record.getStatus();

		if (status != null) {
			TransactionStatus ts = transactionService.begin(); // 启动事务
			try {
				record.setStatus((String) null);
				effCount = scheExecuterDAO.updateByPrimaryKeySelective(record);

				// 更新状态,状态只能从小更新到大，不能逆向
				int count = scheExecuterDAO
						.updateStatus(record.getId(), status);

				record.setStatus(status); // 设置回去
				if (count == 0) {
					logger.warn("更新状态失败,可能状态已过期." + record);
				}

				transactionService.commit(ts);
				effCount = Math.min(effCount, count);

			} catch (Exception e) {
				e.printStackTrace();
				transactionService.rollback(ts);
			}
		} else {
			effCount = scheExecuterDAO.updateByPrimaryKeySelective(record);
		}

		return effCount;
	}

	@Override
	public ScheJob retrieveScheJob(int scheJobId) {
		return scheJobDAO.selectByPrimaryKey(scheJobId);
	}

	@Override
	public int updateScheJob(ScheJob scheJob,boolean cascadeJobParams){
		if (cascadeJobParams){
			return updateScheJob(scheJob);
		}else{
			return scheJobDAO.updateByPrimaryKey(scheJob);
		}
	}
	
	@Override
	public int updateScheJob(ScheJob scheJob) {
		int count = 0;
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try{
			// 删除旧的参数
			int jpCount = scheJobParamsDAO.deleteByScheJobId(scheJob.getId());
			if (logger.isInfoEnabled()){
				logger.info("删除任务参数记录：" + jpCount + " 条, scheJobId=" + scheJob.getId());
			}
			
			// 更新
			count = scheJobDAO.updateByPrimaryKey(scheJob);
			
			// 保存新的参数
			List<ScheJobParams> paramsList = scheJob.getScheJobParamsList();
			if (paramsList != null && !paramsList.isEmpty()) {
				for (Iterator<ScheJobParams> iterator = paramsList.iterator(); iterator
						.hasNext();) {
					ScheJobParams scheJobParams = iterator.next();
					if (scheJobParams.getName() == null){
						continue;
					}
					scheJobParams.setScheJobId(scheJob.getId());
					scheJobParamsDAO.insert(scheJobParams);
				}
				
				if (logger.isInfoEnabled()){
					logger.info("保存新的任务参数记录:" + paramsList.size() + " 条");
				}
			}

			transactionService.commit(ts);
		}catch (Exception e) {
			transactionService.rollback(ts);
		}
		return count;
	}

	@Override
	public ScheJob getScheJobByExecuterId(int scheExecuterId) {
		return scheJobDAO.selectByExecuterId(scheExecuterId);
	}

	@Override
	public ScheExecuter retrieveScheExecuter(int scheExecuterId) {
		return scheExecuterDAO.selectByPrimaryKey(scheExecuterId);
	}

	@Override
	public ScheExecuter getScheExecuterByNo(String execNo, String remoteExecNo) {
		Map params = new HashMap();
		params.put("execNo", execNo);
		params.put("remoteExecNo", remoteExecNo);
		return scheExecuterDAO.select(params);
	}

	@Override
	public List<ScheExecRecordRO> queryScheExecuter(Map params) {
		// TODO Auto-generated method stub
		return scheExecuterDAO.query(params);
	}

	@Override
	public List<ScheJobRO> queryScheJob(Map params) {
		return scheJobDAO.query(params);
	}

	@Override
	public int queryScheJobSize(Map params) {
		return scheJobDAO.querySize(params);
	}

	@Override
	public int queryScheExecuterSize(Map params) {
		return scheExecuterDAO.count(params);
	}

	@Override
	public List<ScheJob> retrieveActiveScheJobByParamName(
			String paramName, String paramValue) {
		Map params = new HashMap();
		params.put("paramName", paramName);
		params.put("paramValue", paramValue);
		params.put("status", ScheJob.STATUS_NOMAL);
		return scheJobDAO.selectByParamNameValue(params);
	}

}
