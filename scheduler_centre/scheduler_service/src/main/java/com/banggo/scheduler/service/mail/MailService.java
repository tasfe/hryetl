
package com.banggo.scheduler.service.mail;

import java.io.InputStream;
import java.util.Date;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.mail.MailException;
import org.springframework.mail.MailPreparationException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;

/** 
 * 功能: 提供邮件发送服务  <p> 
 * 用法:
 * @version 1.0
 */

public class MailService implements InitializingBean,JavaMailSender{
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(MailService.class);
	
	private Properties mailServerConfProp;
	
	private JavaMailSenderImpl sender;
		
	public void setMailServerConfProp(Properties mailServerConfProp) {
		this.mailServerConfProp = mailServerConfProp;
	}
	
	// 要设置的邮件参数
   
	public MailService() {		
	}
	
	
	// 初始化JavaMail
	public void afterPropertiesSet() throws Exception {
		if (mailServerConfProp == null){
			throw new Exception("MailService init failed. Please check the property:mailServerConfProp");
		}
		
		sender = new JavaMailSenderImpl();
		// 初始sender
		sender.setJavaMailProperties(mailServerConfProp);
		String password = (String)mailServerConfProp.get("mail.smtp.pwd");
	   sender.setPassword(password);
	    
	}
	
	public void send(SimpleMailMessage simpleMessage) throws MailException {
		sender.send(simpleMessage);
	}

	public void send(SimpleMailMessage[] simpleMessages) throws MailException {
		sender.send(simpleMessages);
	}

	public MimeMessage createMimeMessage() {
		return sender.createMimeMessage();
	}

	public MimeMessage createMimeMessage(InputStream contentStream)
			throws MailException {
		return sender.createMimeMessage(contentStream);
	}

	public void send(MimeMessage mimeMessage) throws MailException {
		sender.send(mimeMessage);
	}

	public void send(MimeMessage[] mimeMessages) throws MailException {
		sender.send(mimeMessages);
	}

	public void send(MimeMessagePreparator mimeMessagePreparator)
			throws MailException {
		sender.send(mimeMessagePreparator);
	}

	public void send(MimeMessagePreparator[] mimeMessagePreparators)
			throws MailException {
		sender.send(mimeMessagePreparators);
	}
	
	/**
	 * 发送HTML格式邮件
	 * @param subject
	 * @param content
	 * @param to
	 * @throws MailException
	 */
	public void sendHtml(String subject, String content, Set<String> to)
			throws MailException {
		if (to == null || to.size() == 0) {
			throw new MailPreparationException("The receiver can't be null");
		}

		if (StringUtils.isEmpty(subject)) {
         throw new MailPreparationException("The subject of mail can't be null");
		}
		if (StringUtils.isEmpty(content)) {
			throw new MailPreparationException("The body of mail can't be null");
		}

		MimeMessageHelper helper = null;
		try {
			helper = new MimeMessageHelper(createMimeMessage(), true, "UTF-8");
			helper.setTo((String[]) to.toArray(new String[0]));

			helper.setSubject(StringUtils.trim(subject));
			helper.setSentDate(new Date());
			helper.setText(StringUtils.trim(content), true);
		} catch (MessagingException e1) {
			logger.error("send(String, String, String) - exception ignored", e1); //$NON-NLS-1$
			throw new MailPreparationException(e1.getMessage());
		}

		// 发送
		send(helper.getMimeMessage());
	}
	
    /**
     * 发送HTML格式邮件
     * @param subject 邮件主题  
     * @param content 邮件内容
     * @param to 收件人, 多个收件人，中间可以用";"隔开
     * @throws MailException
     */
    public void sendHtml(String subject, String content, String to) throws MailException{
    	if (StringUtils.isBlank(to)){
    		throw new MailPreparationException("The receiver can't be null");
    	}
    	
    	Set<String> toSet = new HashSet<String>();
    	StringTokenizer token = new StringTokenizer(to,";");
    	int count = token.countTokens();
    	if (count == 0){
			// 没有收件人
			throw new MailPreparationException("Invalidate receivers.");
		}
    	
    	for (int i = 0; i < count; i ++){
			toSet.add(StringUtils.trim((String)token.nextElement()));
		}
    	
    	sendHtml(subject, content, toSet);
    }
    
    /**
     * 发送非HTML格式邮件
     * @param subject 邮件主题
     * @param content 邮件内容
     * @param to  收件人
     * @throws MailException
     */
    public void send(String subject, String content, String to) throws MailException{
    	if (StringUtils.isEmpty(subject)){
    		throw new MailPreparationException("The subject of mail can't be null");
    	}
    	if (StringUtils.isEmpty(content)){
    		throw new MailPreparationException("The body of mail can't be null");
    	}
    	if (StringUtils.isEmpty(to)){
    		throw new MailPreparationException("The receiver can't be null");
    	}
		
    	MimeMailMessage mail = new MimeMailMessage(createMimeMessage());
    	mail.setTo(StringUtils.trim(to));
    	mail.setSubject(StringUtils.trim(subject));
    	mail.setText(StringUtils.trim(content));
    	mail.setSentDate(new Date());
    	
    	// 发送
    	send(mail.getMimeMessage());
    }

}
