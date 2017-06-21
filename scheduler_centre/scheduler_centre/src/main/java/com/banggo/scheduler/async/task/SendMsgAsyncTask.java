package com.banggo.scheduler.async.task;

import java.util.Date;
import java.util.Set;

import org.apache.commons.codec.binary.Base64;

import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.service.ScheAlarmService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.SmsService;
import com.banggo.scheduler.service.mail.MailService;

public class SendMsgAsyncTask extends AsyncTask<Void> {

	private ScheAlarmRecord scheAlarmRecord;
	
	private MailService mailService;
	private ScheAlarmService scheAlarmService;
	private ScheJobService scheJobService;
	private SmsService smsService;

	public SendMsgAsyncTask(ScheAlarmRecord record,MailService mailService, ScheAlarmService scheAlarmService,ScheJobService scheJobService, SmsService smsService) {
		this.scheAlarmRecord = record;
		this.mailService = mailService;
		this.scheAlarmService = scheAlarmService;
		this.scheJobService = scheJobService;
		this.smsService = smsService;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Void doInAsync() {
		if (scheAlarmRecord == null ){
			return null;
		}
		
		if (logger.isDebugEnabled()){
			logger.debug(scheAlarmRecord);
		}
		
		// 任务名
		ScheJob scheJob = scheJobService.retrieveScheJob(scheAlarmRecord.getScheJobId());
		if (scheJob == null){
			// 任务不存在？
			logger.warn(scheAlarmRecord.getScheJobId() + " 不存在，不执行通知");
			return null;
		}
		
		String mailSubject = "定时任务：" + scheJob.getJobName() + "(" + scheJob.getJobGroup() + ")执行失败." ;
		try {
			// 发送邮件
			Throwable mailError = null;
			Set<String> mailToSet = scheAlarmRecord.getMailTo();
			try {
				if (mailToSet != null && mailToSet.size() > 0){
					// 解码exception
					String exception = scheAlarmRecord.getScheExecuter().getException();
					String content = "";
					if (exception != null){
						content = new String(Base64.decodeBase64(exception.getBytes("utf-8")),"utf-8").replaceAll("\r\n", "<br/>");
					}
					mailService.sendHtml(mailSubject, content, mailToSet);
				}
			} catch (Throwable e) {
				logger.error("发送邮件失败",e);
				mailError = e;
			}
			
			// 发送短信
			if (scheAlarmRecord.getSmsTo() != null && scheAlarmRecord.getSmsTo().size() > 0){
			  smsService.sendSmsFUllDay(mailSubject, scheAlarmRecord.getSmsTo());
			}
			if (scheAlarmRecord.getSmsLimitTo() != null && scheAlarmRecord.getSmsLimitTo().size() > 0){
			  smsService.sendSmsLimit(mailSubject, scheAlarmRecord.getSmsLimitTo());
			}
			
			if (mailError != null){
				throw mailError;
			}
			
			scheAlarmRecord.setResult(ScheAlarmRecord.NOTIFY_RESULT_SUCCESS);
			
		} catch (Throwable e1) {
			logger.error(e1);
			scheAlarmRecord.setResult(ScheAlarmRecord.NOTIFY_RESULT_FAILED);
		}
		
		// 保存记录
		scheAlarmRecord.setAlarmTime(new Date());
		scheAlarmRecord.setStatus(ScheAlarmRecord.STATUS_NOTIFY);
		
		try {
			scheAlarmService.saveAlarmRecord(scheAlarmRecord);
		} catch (Exception e) {
			logger.error(e);
			return null;
		}
	  return null;
	}

}
