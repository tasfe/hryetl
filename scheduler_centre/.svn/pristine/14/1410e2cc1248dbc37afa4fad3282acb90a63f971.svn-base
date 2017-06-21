package com.banggo.scheduler.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.banggo.scheduler.dao.daointerface.UpdateKettleDateDAO;
import com.banggo.scheduler.dao.dataobject.UpdateKettleDate;
import com.banggo.scheduler.service.UpdateKettleDateService;

public class UpdateKettleDateServiceImpl implements UpdateKettleDateService {

	@Resource
	private UpdateKettleDateDAO updateKettleDateDAO;

	@Override
	public List<UpdateKettleDate> query(Map params) {
		return updateKettleDateDAO.query(params);
	}

	@Override
	public int update(UpdateKettleDate updateKettleDate) {
		return updateKettleDateDAO.update(updateKettleDate);
	}

}
