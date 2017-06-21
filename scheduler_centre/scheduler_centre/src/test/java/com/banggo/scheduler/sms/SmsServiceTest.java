package com.banggo.scheduler.sms;

import java.util.HashSet;
import java.util.Set;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.banggo.scheduler.SpringTestCase;
import com.banggo.scheduler.service.SmsService;

public class SmsServiceTest extends SpringTestCase{
	@Autowired
	private SmsService service;
  
  @Test
  public void send() throws Exception{
	  Set set = new HashSet();
	  set.add("13472661648");
	  service.sendSmsFUllDay("abc", set);
  }
}
