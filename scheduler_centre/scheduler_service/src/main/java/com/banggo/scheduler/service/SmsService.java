package com.banggo.scheduler.service;

import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.metersbonwe.sms.bean.Message;
import com.metersbonwe.sms.bean.State;
import com.metersbonwe.sms.bean.User;
import com.metersbonwe.sms.send.api.SMSService;

public class SmsService {
	private static final Logger logger = Logger.getLogger(SmsService.class);

	private SMSService smsProvider;
	private User user;
	private String sendTypeFullDay;
	private String sendTypeLimit;
	private String channelCode;
	
	

	/**
	 * 发送短信
	 * @param content
	 * @param phones
	 * @param sendType
	 * @throws Exception
	 */
	public void sendSms(String content, Set<String> phones, String sendType)
			throws Exception {
	    if (logger.isDebugEnabled()){
	    	logger.debug("发送短信到：" + phones.toString() + " 发送类型:" + sendType + " 发送内容：" + content);
	    }
	    
		if (StringUtils.isEmpty(content) || phones == null
				|| phones.size() == 0) {
			throw new Exception("短信内容或收件人为空");
		}

		Message msg = new Message();
		msg.setMsgContent(content);
		msg.setSendType(sendType);
		msg.setChannelCode(channelCode);
		for (String phone : phones) {
			msg.setPhoneNO(phone);
			State s = smsProvider.send(user, msg);
			if (logger.isDebugEnabled()) {
				logger.debug(s.getPhoneNo() + ":" + s.getMessage() + " 发送状态："
						+ s.getState());
			}
			if (!State.SUCCESSFULLY.equals(s.getState())){
				throw new Exception("短信发送失败：" + s.getState());
			}
		}
	}

	/**
	 * 发送短信，某个时间内不发
	 * @param content
	 * @param phones
	 * @throws Exception
	 */
	public void sendSmsLimit(String content, Set<String> phones)
			throws Exception {
		sendSms(content, phones, sendTypeLimit);
	}

	/**
	 * 发送短信，全天发
	 * @param content
	 * @param phones
	 * @throws Exception
	 */
	public void sendSmsFUllDay(String content, Set<String> phones)
			throws Exception {
		sendSms(content, phones, sendTypeFullDay);
	}

	public void setSmsProvider(SMSService smsProvider) {
		this.smsProvider = smsProvider;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setSendTypeFullDay(String sendTypeFullDay) {
		this.sendTypeFullDay = sendTypeFullDay;
	}

	public void setSendTypeLimit(String sendTypeLimit) {
		this.sendTypeLimit = sendTypeLimit;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}
}
