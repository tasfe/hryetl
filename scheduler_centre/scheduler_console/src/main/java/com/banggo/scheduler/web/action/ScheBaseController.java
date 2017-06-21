package com.banggo.scheduler.web.action;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.service.ScheBaseService;
import com.banggo.united.client.constants.Constants;
import com.banggo.united.client.dataobject.User;
import com.banggo.united.client.facade.UserStore;
import com.banggo.united.client.filter.config.Config;

/**
 * 调度任务管理（增加，查询）
 * 
 */
@Controller
@RequestMapping(value = "/sche")
public class ScheBaseController {
	
	@Resource
	private ScheBaseService scheBaseService;
	
	@RequestMapping(value = { "/dbtime.htm" })
	public View createTask(ModelMap model) {
		model.put("currentTime", scheBaseService.currentTimeFromDB());
		 return new MappingJacksonJsonView();
	}
	@RequestMapping(value = { "/getUserInfo.htm" }, method = RequestMethod.GET)
	public View getUserInfo(ModelMap model,HttpServletRequest request) {
		String authOutRealPath = Config.getAuthCenterUrl() + Constants.AUTH_CENTER_LOGOUT_PAGE;
		String authRealPath = Config.getAuthCenterUrl() + Constants.AUTH_CENTER_LOGIN_PAGE;
		String realPath1 = "http://"
				+ request.getServerName()
				+ ":"
				+ request.getServerPort()
				+ request.getContextPath();	
		model.put("HttpRealPath", realPath1); 
		User user = UserStore.get(request);
		if (user != null) {
			model.put("UserInfo", user.getUserName());
		}
		
		model.put("AuthOutRealPath", authOutRealPath);
		model.put("AuthRealPath", authRealPath);
		 return new MappingJacksonJsonView();
	}
}
