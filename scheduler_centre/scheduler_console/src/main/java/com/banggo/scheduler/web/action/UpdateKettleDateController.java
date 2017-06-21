package com.banggo.scheduler.web.action;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.dao.dataobject.UpdateKettleDate;
import com.banggo.scheduler.manager.exception.SchedulerException;
import com.banggo.scheduler.service.UpdateKettleDateService;



@Controller
@RequestMapping(value = "/date")
public class UpdateKettleDateController {
	
	@Resource
	private UpdateKettleDateService updateKettleDateService;
	
	@RequestMapping(value = { "/query.htm" })
	public View query(ModelMap map, String appId, String lastTime,
			String summary, String modifyTime, Paginator page) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		List<UpdateKettleDate> resultList = updateKettleDateService.query(params);
		
		map.put("topics", resultList);
		
		return new MappingJacksonJsonView();
	}
	
	
	@RequestMapping(value = { "/update.htm" })
	public View update(ModelMap map, String appId, String lastTime, String summary, String modifyTime) {//@ModelAttribute("updateKettleDate")UpdateKettleDate updateKettleDate
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		UpdateKettleDate updateKettleDate = null;
		try {
			updateKettleDate = new UpdateKettleDate(Integer.parseInt(appId), df.parse(lastTime), summary ,df.parse(modifyTime));
		} catch (NumberFormatException e) {
			map.put("errorMsg", "操作出错:" + e.getMessage());
			map.put("success", false);
			return new MappingJacksonJsonView();
		} catch (ParseException e) {
			map.put("errorMsg", "操作出错:" + e.getMessage());
			map.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		int result = 0;
		try {
			result = updateKettleDateService.update(updateKettleDate);
		} catch (Exception e) {
			map.put("errorMsg", "操作出错:" + e.getMessage());
			map.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		if(result == 1){
			map.put("success", true);
		}else{
			map.put("errorMsg", "更新失败");
			map.put("success", false);
		}
		return new MappingJacksonJsonView();
	}
}