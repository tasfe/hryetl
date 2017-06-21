package com.banggo.scheduler.service;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.service.mail.MailService;

public class MailServiceTest extends SpringTestCase{
  @Autowired
	private MailService mailService;
  
  @Test
  public void send(){
	  mailService.send("scheduler", "scheduler alarm", "nixuw@163.com");
  }
}
