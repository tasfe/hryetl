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
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;
import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.scheduler.service.ScheChainService;
import com.banggo.scheduler.service.ScheJobService;
import com.banggo.scheduler.web.po.ScheChainExecRecordPO;

/**
 * 任务链执行查询
 * 
 */
@SuppressWarnings({"rawtypes","unchecked"})
@Controller
@RequestMapping(value = "/chainfired")
public class ScheChainExecuterController {

	@Resource
	private ScheChainService scheChainService;
	
	@Resource
	private ScheBaseService scheBaseService;
	
	@Resource
	private ScheJobService scheJobService;
	
	private static final String NULLVALUE = "-1";
	
	@RequestMapping(value="/query")
	public View queryJobFired(ScheChainExecRecordPO queryObject, Paginator page, ModelMap map) {
		Map params = new HashMap();
		
		if (queryObject.getJobId() != null){
	    	params.put("jobId", queryObject.getJobId());
	    }
		
		if (queryObject.getScheChianExecuterId() != null){
	    	params.put("scheChianExecuterId", queryObject.getScheChianExecuterId());
	    }
		
		if (StringUtils.isNotBlank(queryObject.getScheChainName())) {
			params.put("chainName", "%" + queryObject.getScheChainName().trim() + "%");
		}

		String appName = queryObject.getAppName();
	    if (StringUtils.isNotBlank(appName) && !StringUtils.equalsIgnoreCase(NULLVALUE, appName)){
	    	params.put("appName",  appName );
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
	    
	    
	    if (StringUtils.isNotBlank(queryObject.getExecNo())){
	    	params.put("execNo", "%" + queryObject.getExecNo() + "%");
	    }
	    
	    
	    if ( queryObject.getBeginTimeFrom() != null){
	    	params.put("beginTimeFrom", queryObject.getBeginTimeFrom());
	    }
	    
	    if ( queryObject.getBeginTimeTo() != null){
	    	params.put("beginTimeTo", queryObject.getBeginTimeTo());
	    }
		
	    // 计算总数
		final int size = this.scheChainService.countScheChainExecuter(params);
		page.setItems(size);
		
		params.put("skip", page.getOffset());
		params.put("pageSize", page.getItemsPerPage());
		
		List<ScheChainExecuter> resultList = scheChainService.queryScheChainExecuter(params);
	    map.put("total", size);
		map.put("scheChainExecuterList", resultList);
     	map.put("pg", page);
		
		return new MappingJacksonJsonView();
	}
	
	@RequestMapping(value="/detail")
	public View detail(int scheChainExecuteId, ModelMap model){
		ScheChainExecuter scheChainExecuter = scheChainService.retrieveScheChainExecuter(scheChainExecuteId);
		if (scheChainExecuter == null){
			model.put("errorMsg", "操作出错:任务链执行记录：" + scheChainExecuteId + " 不存在");
			return new MappingJacksonJsonView();
		}
		
		model.put("scheChainExecuter",scheChainExecuter);
		
		List<Integer> scheExecuterIds = scheChainService.queryScheExecuterIdByChainExecuter(scheChainExecuteId);
		if (scheExecuterIds != null && scheExecuterIds.size() > 0){
			Map params = new HashMap();
			params.put("execIdList", scheExecuterIds);
			// 根据scheExecuterId查询执行记录
			List<ScheExecRecordRO> resultList = scheJobService.queryScheExecuter(params);
			
			model.put("scheExecRecordROList",resultList);
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
		
	}
	
	@InitBinder
	protected void bindDateFormate(HttpServletRequest request, 
			ServletRequestDataBinder binder) {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CustomDateEditor dateEditor = new CustomDateEditor(fmt, true);
		binder.registerCustomEditor(Date.class, dateEditor);
	}
	
}
