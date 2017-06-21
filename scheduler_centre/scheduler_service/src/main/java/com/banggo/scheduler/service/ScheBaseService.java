package com.banggo.scheduler.service;

import java.util.Date;
import java.util.List;

import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;

public interface ScheBaseService {
	/**
	 * 列出所有的应用名称
	 * @return
	 */
	public List<String> scheAppNames();
	
	/**
	 * 保存用户操作记录
	 * @param manualOp
	 * @return
	 */
	public int saveManualOp(ScheManualTrigger manualOp);
	
	/**
	 * 返回数据库当前时间
	 * @return
	 */
	public Date currentTimeFromDB();
	
}
