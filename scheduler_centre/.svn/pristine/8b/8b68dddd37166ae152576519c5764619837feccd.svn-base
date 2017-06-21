package com.banggo.scheduler.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;

import com.banggo.scheduler.dao.daointerface.ScheUserDAO;
import com.banggo.scheduler.dao.dataobject.ScheUser;
import com.banggo.scheduler.service.ScheUserService;

public class ScheUserServiceImpl implements ScheUserService {

	private Logger logger = Logger.getLogger(ScheUserServiceImpl.class);
	
	@Resource
	private ScheUserDAO scheUserDAO;
	
	public void saveScheUser(ScheUser record) {
		scheUserDAO.insert(record);
	}
	
	public void updateScheUser(ScheUser record) {
		scheUserDAO.updateByPrimaryKeySelective(record);
	}
	
	public List<ScheUser> queryAllScheUser(Map params) {
		return scheUserDAO.selectByList(params);
	}
}
