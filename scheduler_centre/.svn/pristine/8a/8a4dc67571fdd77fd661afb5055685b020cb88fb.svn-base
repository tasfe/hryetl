package com.banggo.scheduler.event;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.banggo.scheduler.async.service.AsyncExecuteService;
import com.banggo.scheduler.async.task.AsyncTask;
import com.banggo.scheduler.async.task.SendMsgAsyncTask;
import com.banggo.scheduler.dao.dataobject.ScheAlarm;
import com.banggo.scheduler.dao.dataobject.ScheAlarmMore;
import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheUser;
import com.banggo.scheduler.service.ScheAlarmService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.SmsService;
import com.banggo.scheduler.service.mail.MailService;

public class SendAlarmMsgOnErrorListener implements Listener {
	private static final Logger logger = Logger.getLogger(SendAlarmMsgOnErrorListener.class);
	
	@Autowired
	private ScheAlarmService scheAlarmService;
	
	@Autowired
	private AsyncExecuteService asyncExecuteService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private ScheJobService scheJobService;
	
	@Autowired
	private 	SmsService smsService;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void onEvent(Event e) {
		if (e == null){
			return ;
		}
		
		ExecuteFinishedEvent event = (ExecuteFinishedEvent)e;
		
		ScheExecuter scheExecuter = event.getScheExecuter();
		if (scheExecuter == null){
			return;
		}
		
		// 检查是否执行失败
		if (ScheExecuterStatus.triggerFailed.getCode().equals(scheExecuter.getStatus())
				|| ScheExecuter.RESULT_FAILED.equals(scheExecuter.getResult() )){
			// 检查任务是否有配置失败通知
			Map params = new HashMap();
			params.put("jobId", scheExecuter.getScheJobId());
			params.put("status", ScheAlarm.SATAUS_NOMAL);
			List<ScheAlarmMore> scheAlarmList = scheAlarmService.queryScheAlarm(params);
			if (scheAlarmList == null || scheAlarmList.size() == 0){
				return;
			}
			
			// 一个用户出现在多个组里，对同一个错误，只接收一次通知
			Set hisMailTo = new HashSet();
			Set hisSmsTo = new HashSet();
			
			// 检查通知频率
			for (ScheAlarmMore scheAlarmMore : scheAlarmList) {
				int countTimes = scheAlarmService.countTimes(scheAlarmMore.getId());
				if (scheAlarmMore.getFrequency() != null && countTimes >= scheAlarmMore.getFrequency()){
				    logger.info("alarmId = " + scheAlarmMore.getId() + 
				    		" 通知频率:" + scheAlarmMore.getFrequency() + scheAlarmMore.getFrequencyUnit() + " 已通知" + countTimes + "次，到达最大值，本次不通知.");
				    continue;
				}
				
				// 查找用户组所有用户列表
				List<ScheUser> scheUserList = scheAlarmService.queryUserByUserGroup(scheAlarmMore.getScheUserGroupId());
				if (scheUserList == null || scheUserList.size() == 0){
					logger.warn("alarmId = " + scheAlarmMore.getId() + " 用户组:"  + scheAlarmMore.getScheUserGroupId() + "找不到用户");
					continue;
				}
				
				// 通知记录
				ScheAlarmRecord alarmRecord = new ScheAlarmRecord();
				alarmRecord.setScheExecuter(scheExecuter);
				alarmRecord.setScheAlarmId(scheAlarmMore.getId());
				alarmRecord.setScheJobId(scheExecuter.getScheJobId());
				alarmRecord.setScheExecId(scheExecuter.getId());
				alarmRecord.setScheUserGroupId(scheAlarmMore.getScheUserGroupId());

				// 通知方式
				for (ScheUser scheUser : scheUserList) {
					if (scheAlarmMore.isAlertByMail() && StringUtils.isNotBlank(scheUser.getEmail()) && !hisMailTo.contains(scheUser.getEmail())){
						alarmRecord.addMailTo(scheUser);
						hisMailTo.add(scheUser.getEmail());
					}
					
					if ( StringUtils.isNotBlank(scheUser.getMobile()) && !hisSmsTo.contains(scheUser.getMobile())){
						if (scheAlarmMore.isAlertBySmsFullDay()){
							alarmRecord.addSmsTo(scheUser);
						} else if (scheAlarmMore.isAlertBySmsLimit()){
							alarmRecord.addSmsLimitTo(scheUser);
						}
						
						hisSmsTo.add(scheUser.getMobile());
					}
					
				}
				
				// 异步发送消息
				AsyncTask<Void> asyncTask = new SendMsgAsyncTask(alarmRecord,mailService,scheAlarmService,scheJobService,smsService);
				asyncExecuteService.submitTask(asyncTask);
			}
		}
		
	
	}

	@Override
	public boolean isListenTo(Event e) {
		if (e.getEventName().equalsIgnoreCase(ExecuteFinishedEvent.eventName)){
			return true;
		}
		return false;
	}

}
