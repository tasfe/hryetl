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
import com.banggo.scheduler.dao.dataobject.ScheJob;
import com.banggo.scheduler.dao.ro.ScheJobRO;
import com.banggo.scheduler.job.builder.ScheJobBuilder;
import com.banggo.scheduler.job.builder.ScheJobBuilderFactory;
import com.banggo.scheduler.manager.exception.SchedulerException;
import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.scheduler.service.ScheJobService;

/**
 * 调度任务管理（增加，查询）
 * 
 */
@Controller
@RequestMapping(value = "/job")
public class ScheJobController {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ScheJobController.class);

	@Resource
	private ScheBaseService scheBaseService;

	@Resource
	private ScheJobService scheJobService;
	
	@Resource
	private ScheJobBuilderFactory builderFactory;

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
			@ModelAttribute("scheJob") ScheJob scheJob) {
		 
		return new OperateScheJobTemplate(){

			@Override
			void doIntemplage(ScheJobBuilder jobBuilder, ScheJob scheJob)
					throws SchedulerException {
				jobBuilder.beforeCreate(scheJob);
				jobBuilder.create(scheJob);
			}
			
		}.metadataOperate(scheJob, model);
	}
	
	/**
	 * 更新任务
	 * @param model
	 * @param scheJob
	 * @return
	 */
	@RequestMapping(value = { "/update" }, method = RequestMethod.POST)
	public View updateTask(ModelMap model,
			@ModelAttribute("scheJob") ScheJob scheJob) {
		
		return new OperateScheJobTemplate(){

			@Override
			void doIntemplage(ScheJobBuilder jobBuilder, ScheJob scheJob)
					throws SchedulerException {
				jobBuilder.beforeUpdate(scheJob);
				jobBuilder.update(scheJob);
			}
			
		}.metadataOperate(scheJob, model);
	}
	
	/**
	 * 删除任务
	 * @param jobId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/delete" }, method = RequestMethod.GET)
	public View deleteJob(String jobId, ModelMap model) {
		String[] jobIds = jobId.split(",");
		
		for (String scheJobId : jobIds) {
			
			// 检查是否存在
			ScheJob oldScheJob = scheJobService.retrieveScheJob(Integer.valueOf(scheJobId));
			if (oldScheJob == null) {
				model.put("errorMsg", "操作失败:任务" + scheJobId + " 不存在");
				model.put("success", false);
				return new MappingJacksonJsonView();
			}else{
				ScheJobBuilder jobBuilder = builderFactory.getScheJobBuilder(oldScheJob.getType());
				if (jobBuilder == null){
					 model.put("errorMsg", "操作失败,原因：未定义的任务类型");
					 model.put("success", false);
					 return new MappingJacksonJsonView();
				}
				
				try {
					jobBuilder.beforeDelete(oldScheJob);
					jobBuilder.delete(oldScheJob);
				} catch (Exception e) {
					model.put("errorMsg", "删除任务失败,原因:" + e.getMessage());
					model.put("success", false);
					return new MappingJacksonJsonView();
				}
			}
		}
		
		model.put("success", true);
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 任务暂停
	 * 
	 * @param jobId  任务id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/pause" }, method = RequestMethod.GET)
	public View pauseJob(String jobId, ModelMap model) {
		
		return new OperateScheJobTemplate() {

			@Override
			void doIntemplage(ScheJobBuilder jobBuilder, ScheJob scheJob)
					throws SchedulerException {
				jobBuilder.pause(scheJob);
			}

		}.operate(jobId, model);
		
	}

	/**
	 * 恢复任务
	 * 
	 * @param jobId 任务id
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/resume" }, method = RequestMethod.GET)
	public View resumeJob(String jobId, ModelMap model) {
		return new OperateScheJobTemplate() {

			@Override
			void doIntemplage(ScheJobBuilder jobBuilder, ScheJob scheJob)
					throws SchedulerException {
				jobBuilder.resume(scheJob);
			}

		}.operate(jobId, model);

	}

	/**
	 * 立即执行任务一次
	 * 
	 * @param jobId
	 * @param ignoreConcurrent
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/runOnce" })
	public View runOnce(String jobId, final  boolean ignoreConcurrent, ModelMap model) {
		return new OperateScheJobTemplate(){

			@Override
			void doIntemplage(ScheJobBuilder jobBuilder, ScheJob scheJob)
					throws SchedulerException {
				jobBuilder.trigger(scheJob, ignoreConcurrent);
			}
			
		}.operate(jobId, model);
		
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
			String jobGroup, String status, String type,Paginator page) {
		 
		final Map<String, Object> maps = new HashMap<String, Object>(4);
		if (StringUtils.isNotBlank(appName) && !StringUtils.equalsIgnoreCase(NULLVALUE, appName)) {
			maps.put("appName", appName.trim());
		}
		if (StringUtils.isNotBlank(jobName)) {
			maps.put("jobName", "%" + jobName.trim() + "%");
		}
		if (StringUtils.isNotBlank(jobGroup)) {
			maps.put("jobGroup",  "%" + jobGroup.trim() + "%");
		}
		if (StringUtils.isNotBlank(status) && !StringUtils.equalsIgnoreCase(NULLVALUE, status)) {
			maps.put("status", status.trim());
		}
		if (StringUtils.isNotBlank(type)) {
			maps.put("type",  type);
		}
		
		// 计算总数
	    int size = scheJobService.queryScheJobSize(maps);
		page.setItems(size);
		
		maps.put("skip", page.getOffset());
		maps.put("pageSize", page.getItemsPerPage());
		// 查询
		List<ScheJobRO> alljobs = scheJobService.queryScheJob(maps);
		model.put("alljobs", alljobs);
		model.put("pg", page);
		model.put("appName", appName);
		model.put("jobName", jobName);
		model.put("jobGroup", jobGroup);
		model.put("status", status);
		
		model.put("topics", alljobs);
		model.put("total", size);
		return new MappingJacksonJsonView();
	}

	

	/**
	 * 获取指定任务
	 * @param model
	 * @param jobId
	 * @return
	 */
	@RequestMapping(value = { "/retrive" })
	public View retriveTask(ModelMap model, String jobId) {
		if (StringUtils.isBlank(jobId)) {
			throw new IllegalArgumentException("jobId is not null");
		}
		ScheJob scheJob = scheJobService.retrieveScheJob(Integer
				.valueOf(jobId));
		
		if (scheJob == null){
			 model.put("errorMsg", "操作失败:任务" + jobId + " 不存在");
			 return new MappingJacksonJsonView();
		}
		model.put("job", scheJob);
		
		return new MappingJacksonJsonView();
	}
	/**
	 * 返回参数对象
	 * @param model
	 * @param jobId
	 * @return
	 */
	@RequestMapping(value = { "/paramData" })
	public View paramData(ModelMap model, String jobId) {
		if (StringUtils.isBlank(jobId)) {
			throw new IllegalArgumentException("jobId is not null");
		}
		ScheJob scheJob = scheJobService.retrieveScheJob(Integer
				.valueOf(jobId));
		
		if (scheJob == null){
			model.put("errorMsg", "操作失败:任务" + jobId + " 不存在");
			return new MappingJacksonJsonView();
		}
		model.put("paramData", scheJob.getScheJobParamsList());
		
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
	
	private abstract class OperateScheJobTemplate{
		abstract void doIntemplage(ScheJobBuilder jobBuilder,ScheJob scheJob) throws SchedulerException;
		
		/**
		 * 任务触发、暂停、恢复模板
		 * @param jobId
		 * @param model
		 * @return
		 */
		MappingJacksonJsonView operate(String jobId, ModelMap model){
			if (StringUtils.isBlank(jobId)) {
				model.put("success", false);
				model.put("errorMsg", "操作失败:任务ID不能为空");
				return new MappingJacksonJsonView();
			}
			
			ScheJob scheJob = scheJobService.retrieveScheJob(Integer.valueOf(jobId));
			
			if (scheJob == null){
				 model.put("errorMsg", "操作失败:任务" + jobId + " 不存在");
				 return new MappingJacksonJsonView();
			}
			
			ScheJobBuilder jobBuilder = builderFactory.getScheJobBuilder(scheJob.getType());
			if (jobBuilder == null){
				 model.put("errorMsg", "操作失败,原因：未定义的任务类型");
				 model.put("success", false);
				 return new MappingJacksonJsonView();
			}
			
			try {
				doIntemplage(jobBuilder,scheJob);
			} catch (SchedulerException e) {
				 model.put("errorMsg", "操作失败,原因:" + e.getMessage());
				 model.put("success", false);
				 return new MappingJacksonJsonView();
			}
			
			
			model.put("success", "true");
			return new MappingJacksonJsonView();
		}
		
		/**
		 * 任务新增、修改模板
		 * @param scheJob
		 * @param model
		 * @return
		 */
		MappingJacksonJsonView metadataOperate(ScheJob scheJob, ModelMap model){
			if (scheJob == null ){
				model.put("errorMsg", "操作失败:任务对象不能为空");
				model.put("success", false);
				 return new MappingJacksonJsonView();
			}
			
			ScheJobBuilder jobBuilder = builderFactory.getScheJobBuilder(scheJob.getType());
			if (jobBuilder == null){
				 model.put("errorMsg", "操作失败,原因：未定义的任务类型");
				 model.put("success", false);
				 return new MappingJacksonJsonView();
			}
			
			String errorMsg = jobBuilder.validateScheJob(scheJob) == null ? jobBuilder.validateScheJobParams(scheJob) : null;
			if (errorMsg != null){
				model.put("errorMsg", "操作失败:" + errorMsg );
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
			
			// 更新
			try {
				doIntemplage(jobBuilder,scheJob);
			} catch (SchedulerException e) {
				logger.error("操作:" + scheJob.getId() + "失败原因:" + e);
				model.put("errorMsg", "操作失败:" + e.getMessage());
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
			
			model.put("success", true);
			return new MappingJacksonJsonView();
		}
	}
	
}
