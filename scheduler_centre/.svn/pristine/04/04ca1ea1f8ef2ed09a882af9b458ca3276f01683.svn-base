package com.banggo.scheduler.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.banggo.scheduler.dao.daointerface.ScheApplicationDAO;
import com.banggo.scheduler.dao.daointerface.ScheManualTriggerDAO;
import com.banggo.scheduler.dao.dataobject.ScheApplication;
import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;
import com.banggo.scheduler.service.ScheBaseService;

public class ScheBaseServiceImpl implements ScheBaseService {

	@Resource
	private ScheApplicationDAO scheApplicationDAO;
	
	@Resource
	private ScheManualTriggerDAO scheManualTriggerDAO;
	

	@Override
	public List<String> scheAppNames() {
		
		 List<ScheApplication> scheAppList = scheApplicationDAO.query(null);
		 if (scheAppList == null || scheAppList.isEmpty()){
			 return null;
		 }
		 
		 List<String> resultList = new ArrayList<String>(scheAppList.size());
		 for (ScheApplication scheApplication : scheAppList) {
			 resultList.add(scheApplication.getAppName());
		 }
		 
		return resultList;
	}

	@Override
	public int saveManualOp(ScheManualTrigger manualOp) {
		return scheManualTriggerDAO.insert(manualOp);
	}

	@Override
	public Date currentTimeFromDB() {
		return scheApplicationDAO.now();
	}
	


}
