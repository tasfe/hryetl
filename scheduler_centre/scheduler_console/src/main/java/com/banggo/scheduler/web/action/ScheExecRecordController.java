
package com.banggo.scheduler.web.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionStatus;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.dataobject.ScheExecuterStatus;
import com.banggo.scheduler.dao.dataobject.ScheManualTrigger;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;
import com.banggo.scheduler.manager.ExecuteManager;
import com.banggo.scheduler.manager.exception.ExecuteException;
import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.service.transaction.TransactionService;
import com.banggo.scheduler.web.po.ScheExecRecordPO;

/** 
 * 功能: 定时任务执行记录操作  <p> 
 * 用法:
 * @version 1.0
 */
@Controller
@RequestMapping("/fired")
@SuppressWarnings({ "rawtypes", "unchecked" })
public class ScheExecRecordController {
	private static final String NULLVALUE = "-1";

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ScheExecRecordController.class);

	@Resource
	private ScheBaseService scheBaseService;
	
	@Resource
	private ScheJobService scheJobService;
	
	@Resource
	private ExecuteManager executeManager;
	
	@Resource
	private TransactionService transactionService;

	@RequestMapping(value="/query.htm")
	public View queryJobFired(ScheExecRecordPO queryObject, Paginator page, ModelMap map) {
		Map params = new HashMap();
		
		if (queryObject.getJobId() != null){
	    	params.put("jobId", queryObject.getJobId());
	    }
		
		String appName = queryObject.getAppName();
	    if (StringUtils.isNotBlank(appName) && !StringUtils.equalsIgnoreCase(NULLVALUE, appName)){
	    	params.put("appName", "%" + appName + "%");
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getJobName())){
	    	params.put("jobName", "%" + queryObject.getJobName() + "%");
	    }

	    if (StringUtils.isNotBlank(queryObject.getJobGroup())){
	    	params.put("jobGroup", "%" + queryObject.getJobGroup() + "%");
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getStatus()) && !StringUtils.equalsIgnoreCase(NULLVALUE, queryObject.getStatus())){
	    	params.put("status",  queryObject.getStatus() );
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getResult()) && !StringUtils.equalsIgnoreCase(NULLVALUE, queryObject.getResult())){
	    	params.put("result",  queryObject.getResult() );
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getExecNo())){
	    	params.put("execNo", "%" + queryObject.getExecNo() + "%");
	    }
	    
	    if (StringUtils.isNotBlank(queryObject.getRemoteExecNo())){
	    	params.put("remoteExecNo", "%" + queryObject.getRemoteExecNo() + "%");
	    }
	    
	    if ( queryObject.getBeginTimeFrom() != null){
	    	params.put("beginTimeFrom", queryObject.getBeginTimeFrom());
	    }
	    
	    if ( queryObject.getBeginTimeTo() != null){
	    	params.put("beginTimeTo", queryObject.getBeginTimeTo());
	    }
		
	    // 计算总数
		final int size = this.scheJobService.queryScheExecuterSize(params);
		page.setItems(size);
		
		params.put("skip", page.getOffset());
		params.put("pageSize", page.getItemsPerPage());
		
		List<ScheExecRecordRO> resultList = scheJobService.queryScheExecuter(params);
	    map.put("total", size);
		map.put("topics", resultList);
//		map.put("pg", page);
		
		return new MappingJacksonJsonView();
	}
	
	@RequestMapping(value="/detail.htm")
	public View queryExecuterRecord(int execId,ModelMap map){
		Map params = new HashMap();
		params.put("execId", execId);
		List<ScheExecRecordRO> resultList = scheJobService.queryScheExecuter(params);
		if (resultList == null || resultList.isEmpty()){
			map.put("errorMsg", "指定的记录不存在," + execId);
			return new MappingJacksonJsonView();
			//return "/common/error";
		}
		
	    map.put("scheExecRecordRO", resultList.get(0));
	    
	    return new MappingJacksonJsonView();
	}
	
	@RequestMapping(value="/interrupt.htm")
	public View interruptExecuter(int execId,ModelMap map){
		ScheExecuter scheExecuter = scheJobService.retrieveScheExecuter(execId);
		if (scheExecuter == null ){
			map.put("errorMsg", "指定的记录不存在," + execId);
			
			return new MappingJacksonJsonView();
		}
		

		if (ScheExecuterStatus.toEnum(scheExecuter.getStatus()) != ScheExecuterStatus.processing
				&& ScheExecuterStatus.toEnum(scheExecuter.getStatus()) != ScheExecuterStatus.unknow){
			map.put("errorMsg", "任务:" + scheExecuter.getExecNo() + " 不能中断");
			
			return new MappingJacksonJsonView();
		}
		
		
		// 记录操作者
		ScheManualTrigger manualOp = new ScheManualTrigger();
		manualOp.setScheExecId(scheExecuter.getId());
		manualOp.setScheJobId(scheExecuter.getScheJobId());
		manualOp.setOperateBy("system"); // TODO
		manualOp.setTriggerType(ScheManualTrigger.TRIGGERTYPE_TERMINATE);
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		try {
			scheJobService.updateScheExecuter(scheExecuter);
			scheBaseService.saveManualOp(manualOp);
			executeManager.interrupt(execId);
			
			transactionService.commit(ts);
			map.put("success", "true");
		} catch (ExecuteException e) {
			logger.error("中断任务" + execId + " 出错,原因:" + e);
			map.put("errorMsg", "操作出错:" + e.getMessage());
			
			transactionService.rollback(ts);
			map.put("failure", "true");
			return new MappingJacksonJsonView();
		}
		return new MappingJacksonJsonView();
	}
	
	
	/**
	 * 构造基础模型
	 * @param request
	 * @param map
	 */
	@ModelAttribute
	public void prepareData(HttpServletRequest request,ModelMap map){
		map.put("scheAppNames", scheBaseService.scheAppNames());
		map.put("scheExecuterStatus", ScheExecuterStatus.values());
		
	}
	
	@InitBinder
	protected void bindDateFormate(HttpServletRequest request, 
			ServletRequestDataBinder binder) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CustomDateEditor dateEditor = new CustomDateEditor(fmt, true);
		binder.registerCustomEditor(Date.class, dateEditor);
	}
	
}
