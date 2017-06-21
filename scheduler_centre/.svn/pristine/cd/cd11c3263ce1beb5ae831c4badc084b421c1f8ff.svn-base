package com.banggo.scheduler.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.dao.ro.ScheJobRO;
import com.banggo.scheduler.service.ScheJobService;

/**
 * 任务预警功能
 * @author hq01ua0044
 *
 */
@Controller
@RequestMapping(value = "/workJob")
public class WorkJobController {

	private static final Logger logger = Logger.getLogger(WorkJobController.class);
	
	@Resource
	private ScheJobService scheJobService;
	
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
	public View queryTask(ModelMap model) {
		 
		final Map<String, Object> maps = new HashMap<String, Object>(4);
		
		// 查询
		List<ScheJobRO> alljobs = scheJobService.queryScheJob(maps);
		model.put("topics", alljobs);
		
		return new MappingJacksonJsonView();
	}
}
