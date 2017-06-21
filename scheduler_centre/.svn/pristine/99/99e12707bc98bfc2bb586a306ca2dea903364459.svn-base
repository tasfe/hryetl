package com.banggo.scheduler.web.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.dao.dataobject.ScheAlarm;
import com.banggo.scheduler.dao.dataobject.ScheAlarmMore;
import com.banggo.scheduler.service.ScheAlarmService;
import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.united.client.dataobject.User;
import com.banggo.united.client.facade.UserStore;

/**
 * 任务报警管理（增加，查询）
 * 
 */
@Controller
@RequestMapping(value = "/alarm")
public class ScheAlarmController {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(ScheAlarmController.class);

	@Resource
	private ScheBaseService scheBaseService;

/*	@Resource
	private ScheJobService scheJobService;*/
	
	@Resource
	private ScheAlarmService scheAlarmService;

	private static final String NULLVALUE = "-1";
	
	/**
	 * 新建
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/new" })
	public View createTask(ModelMap model) {
		 return new MappingJacksonJsonView();
	}
	
	/**
	 * 创建任务
	 * @param model
	 * @param scheJob
	 * @return
	 */
	@RequestMapping(value = { "/create" },method=RequestMethod.POST)
	public View addTask(ModelMap model,
			@ModelAttribute("scheAlarm") ScheAlarm scheAlarm,
			HttpServletRequest request) {
		if (scheAlarm == null || !scheAlarm.validate()){
			model.put("errorMsg", "操作失败:报警配置参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		try {
			User user = UserStore.get(request);
			if (user != null) {
				scheAlarm.setCreateBy(user.getUserName());
			}
			
			scheAlarm.setCreateDate(new Date());
			scheAlarmService.saveAlaram(scheAlarm);
			model.put("success", true);
		} catch (Exception e) {
			logger.error(e);
			model.put("errorMsg", "操作失败:保存错误!");
			model.put("success", false);
		}
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 更新任务
	 * @param model
	 * @param scheJob
	 * @return
	 */
	@RequestMapping(value = { "/update" }, method = RequestMethod.POST)
	public View updateTask(ModelMap model,
			@ModelAttribute("scheAlarm") ScheAlarm scheAlarm,
			HttpServletRequest request) {
		
		if (scheAlarm == null || !scheAlarm.validate()){
			model.put("errorMsg", "操作失败:报警配置参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		try {
			User user = UserStore.get(request);
			if (user != null) {
				scheAlarm.setUpdateBy(user.getUserName());
			}
			scheAlarm.setCreateDate(new Date());
			scheAlarmService.updateScheAlarm(scheAlarm);
			model.put("success", true);
		} catch (Exception e) {
			logger.error(e);
			model.put("errorMsg", "操作失败:更新错误!");
			model.put("success", false);
		}
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 更新状态
	 * @param model
	 * @param scheAlarmId
	 * @param flag
	 * @return
	 */
	@RequestMapping(value = { "/updateStatus" }, method = RequestMethod.GET)
	public View updateStatus(ModelMap model, String scheAlarmId, Integer flag) {
		
		if (StringUtils.isBlank(scheAlarmId)) {
			model.put("errorMsg", "操作失败:参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		String[] scheAlarmIds = scheAlarmId.split(",");
		
		for (String scheAlarm : scheAlarmIds) {
			try {
				ScheAlarm alarmModel = new ScheAlarm();
				alarmModel.setId(Integer.valueOf(scheAlarm));
				alarmModel.setStatus(flag);
				scheAlarmService.updateScheAlarm(alarmModel);
			} catch (NumberFormatException e) {
				model.put("errorMsg", "操作失败:状态更新出错");
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
		}
		
		model.put("success", true);
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 删除报警
	 * @param jobId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/delete" }, method = RequestMethod.GET)
	public View deleteJob(String scheAlarmId, ModelMap model) {
		String[] scheAlarmIds = scheAlarmId.split(",");
		
		for (String scheAlarm : scheAlarmIds) {
			try {
				scheAlarmService.deleteScheAlarm(Long.valueOf(scheAlarm));
			} catch (NumberFormatException e) {
				model.put("errorMsg", "操作失败:删除" + scheAlarm  + " 出错");
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
		}
		
		model.put("success", true);
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 查询任务
	 * @param model
	 * @param appName
	 * @param jobName
	 * @param jobGroup
	 * @param status
	 * @param type
	 * @param page
	 * @return
	 */
	@RequestMapping(value = { "/query" })
	public View queryTask(ModelMap model, String appName, String jobName,
			String jobGroup, String status, Paginator page) {
		 
		final Map<String, Object> maps = new HashMap<String, Object>(4);
		if (StringUtils.isNotBlank(appName) && !StringUtils.equalsIgnoreCase(NULLVALUE, appName)) {
			maps.put("appName", appName.trim());
		}
		if (StringUtils.isNotBlank(jobName)) {
			maps.put("jobName", jobName.trim());
		}
		if (StringUtils.isNotBlank(jobGroup)) {
			maps.put("jobGroup",  jobGroup.trim());
		}
		if (StringUtils.isNotBlank(status) && !StringUtils.equalsIgnoreCase(NULLVALUE, status)) {
			maps.put("status", status.trim());
		}
		
		// 计算总数
	    int size = scheAlarmService.queryScheAlarmSize(maps);
		page.setItems(size);
		
		maps.put("skip", page.getOffset());
		maps.put("pageSize", page.getItemsPerPage());
		// 查询
		List<ScheAlarmMore> allAlarms = scheAlarmService.queryScheAlarm(maps);
		model.put("allAlarms", allAlarms);
		model.put("pg", page);
		model.put("appName", appName);
		model.put("jobName", jobName);
		model.put("jobGroup", jobGroup);
		model.put("status", status);
		
		model.put("topics", allAlarms);
		model.put("total", size);
		return new MappingJacksonJsonView();
	}

	/**
	 * 获取指定报警
	 * @param model
	 * @param jobId
	 * @return
	 */
	@RequestMapping(value = { "/retrive" })
	public View retriveTask(ModelMap model, String scheAlarmId) {
		if (StringUtils.isBlank(scheAlarmId)) {
			throw new IllegalArgumentException("scheAlarmId is not null");
		}
		
		try { 
			ScheAlarm scheAlarm = scheAlarmService.retrieveScheAlarm(Integer
					.valueOf(scheAlarmId));
			
			if (scheAlarm == null){
				 model.put("errorMsg", "操作失败:任务报警" + scheAlarm + " 不存在");
				 return new MappingJacksonJsonView();
			}
			model.put("scheAlarm", scheAlarm);
		} catch (Exception e) {
			logger.error(e);
			model.put("errorMsg", "操作失败:查询失败");
		}
		
		return new MappingJacksonJsonView();
	}
	

	
	/**
	 * 构造基础模型
	 * @param request
	 * @param map
	 */
	@ModelAttribute
	@RequestMapping(value = { "/prepareData" }, method = RequestMethod.GET)
	public View prepareData(HttpServletRequest request,ModelMap map){
		List<String> appNames = scheBaseService.scheAppNames();
		
		List<KeyValue> list = new ArrayList<KeyValue>();
		for (String appName : appNames) {
			list.add(new KeyValue(appName,appName));
		}
		list.add(0,new KeyValue("请选择",""));
		map.put("scheAppNames", list);
		
		return new MappingJacksonJsonView();
		
	}
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"), true));
	}

	public static class KeyValue{
		private String value;
		private String key;
		
		public KeyValue(String key,String value) {
		  this.value = value;
		  this.key = key;
		}
		public String getKey() {
			return key;
		}
		public void setKey(String key) {
			this.key = key;
		}
		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
	}
	

	
}
