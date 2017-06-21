package com.banggo.scheduler.web.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.json.MappingJacksonJsonView;

import com.banggo.scheduler.common.Paginator;
import com.banggo.scheduler.dao.dataobject.ScheUser;
import com.banggo.scheduler.dao.dataobject.ScheUserGroup;
import com.banggo.scheduler.service.ScheUserGroupService;
import com.banggo.scheduler.service.ScheUserService;
import com.banggo.united.client.dataobject.User;
import com.banggo.united.client.dataobject.UserDetail;
import com.banggo.united.client.facade.UserStore;
import com.banggo.united.client.filter.config.Config;

/**
 * 用户组管理
 * @author QuYachu
 *
 */
@Controller
@RequestMapping(value = "/scheUserGroup")
public class ScheUserGroupController {

	private static final Logger logger = Logger.getLogger(ScheUserGroupController.class);
	
	@Resource
	private ScheUserGroupService scheUserGroupService;
	
	@Resource
	private ScheUserService scheUserService;
	
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
	 * 创建用户组
	 * @param model
	 * @param scheUserGroup
	 * @return
	 */
	@RequestMapping(value = { "/create" },method=RequestMethod.POST)
	public View addTask(ModelMap model, String userIds,
			@ModelAttribute("scheUserGroup") ScheUserGroup scheUserGroup,
			HttpServletRequest request) {
		if (scheUserGroup == null || StringUtils.isBlank(userIds)){
			model.put("errorMsg", "操作失败:参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		// 如果并发高的情况，这种判断不严格
		// 判断是否数据中存在同任务组
		final Map<String, Object> params = new HashMap<String, Object>(4);
		params.put("groupName", scheUserGroup.getName());
		
		try {
			int count = scheUserGroupService.queryScheUserGroupSize(params);
			if (count > 0) {
				model.put("errorMsg", "存在同样的用户组，请重新输入");
				model.put("success", false);
			} else {
				scheUserGroup.setCreateDate(new Date());
				User user = UserStore.get(request);
				if (user != null) {
					scheUserGroup.setCreateBy(user.getUserName());
				}
				long pk = scheUserGroupService.SaveScheUserGroup(scheUserGroup, userIds);
				
				if (pk == -1) {
					model.put("errorMsg", "新增失败");
					model.put("success", false);
					return new MappingJacksonJsonView();
				}
				model.put("success", true);
			}
		} catch (Exception e) {
			model.put("errorMsg", "新增错误");
			model.put("success", false);
		}
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 更新用户组
	 * @param model
	 * @param scheUserGroup
	 * @return
	 */
	@RequestMapping(value = { "/update" }, method = RequestMethod.POST)
	public View updateTask(ModelMap model,
			@ModelAttribute("scheUserGroup") ScheUserGroup scheUserGroup, String userIds,
			HttpServletRequest request) {
		
		if (scheUserGroup == null || StringUtils.isBlank(userIds)){
			model.put("errorMsg", "操作失败:参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		// 如果并发高的情况，这种判断不严格
		// 判断是否数据中存在同任务组
		final Map<String, Object> params = new HashMap<String, Object>(4);
		params.put("groupName", scheUserGroup.getName());
		
		try {
			List<ScheUserGroup> list = scheUserGroupService.queryScheUserGroup(params);
			
			if (list != null && list.size() > 0) {
				String msg = null;
				if (list.size() > 1) {
					msg = "存在相同的用户组名，请重新输入!";
				} else {
					ScheUserGroup groupModel = list.get(0);
					
					if (!groupModel.getId().equals(scheUserGroup.getId())) {
						msg = "存在相同的用户组名，请重新输入!";
					}
				}
				
				if (msg != null) {
					model.put("errorMsg", msg);
					model.put("success", false);
					return new MappingJacksonJsonView();
				}
			}
			scheUserGroup.setUpdateDate(new Date());
			User user = UserStore.get(request);
			if (user != null) {
				scheUserGroup.setUpdateBy(user.getUserName());
			}
			int result = scheUserGroupService.updateScheUserGroup(scheUserGroup, userIds);
			
			if (result == -1) {
				model.put("errorMsg", "修改失败");
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
			model.put("success", true);
		} catch (Exception e) {
			model.put("errorMsg", "修改错误");
			model.put("success", false);
		}
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 删除用户组
	 * @param jobId
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/delete" }, method = RequestMethod.GET)
	public View deleteJob(String scheUserGroupId, ModelMap model) {
		String[] scheUserGroupIds = scheUserGroupId.split(",");
		
		int result = -1;
		
		for (String scheUserGroup : scheUserGroupIds) {
			try {
				result = scheUserGroupService.deleteScheUserGroup(Long.valueOf(scheUserGroup));
				System.out.println("result= " + result);
				
				if (result == -1) {
					break;
				}
			} catch (NumberFormatException e) {
				model.put("errorMsg", "操作失败:删除" + scheUserGroup  + " 出错");
				model.put("success", false);
				return new MappingJacksonJsonView();
			}
		}
		
		if (result == -1) {
			model.put("errorMsg", "操作失败:删除失败");
			model.put("success", false);
		} else {
			model.put("success", true);
		}
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 获取指定用户组
	 * @param model
	 * @param jobId
	 * @return
	 */
	@RequestMapping(value = { "/retrive" })
	public View retriveTask(ModelMap model, String scheUserGroupId) {
		if (StringUtils.isBlank(scheUserGroupId)) {
			throw new IllegalArgumentException("scheUserGroupId is not null");
		}
		
		try {
			ScheUserGroup scheUserGroup = scheUserGroupService.retrieveScheUserGroup(Long.valueOf(scheUserGroupId));
			
			if (scheUserGroup == null){
				 model.put("errorMsg", "操作失败:用户组" + scheUserGroupId + " 不存在");
				 return new MappingJacksonJsonView();
			}
			model.put("scheUserGroup", scheUserGroup);
		} catch (Exception e) {
			 model.put("errorMsg", "操作失败:查询错误");
		}
		
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
	public View queryTask(ModelMap model, String userGroupName, Paginator page) {
		 
		final Map<String, Object> maps = new HashMap<String, Object>(4);
		
		if (StringUtils.isNotBlank(userGroupName)) {
			//maps.put("name", "%" + userGroupName.trim() + "%");
			maps.put("name", userGroupName.trim());
		}
		
		// 计算总数
	    int size = scheUserGroupService.queryScheUserGroupSize(maps);
		page.setItems(size);
		
		maps.put("skip", page.getOffset());
		maps.put("pageSize", page.getItemsPerPage());
		// 查询
		List<ScheUserGroup> allUserGroup = scheUserGroupService.queryScheUserGroup(maps);
		model.put("allAlarms", allUserGroup);
		model.put("pg", page);
		
		model.put("topics", allUserGroup);
		model.put("total", size);
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 创建用户
	 * @param model
	 * @param scheUserGroup
	 * @return
	 */
	@RequestMapping(value = { "/createUser" },method=RequestMethod.POST)
	public View addUser(ModelMap model,
			@ModelAttribute("scheUser") ScheUser scheUser,
			HttpServletRequest request) {
		if (scheUser == null){
			model.put("errorMsg", "操作失败:参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		// 如果并发高的情况，这种判断不严格
		// 判断是否数据中存在同用户名
		final Map<String, Object> params = new HashMap<String, Object>(4);
		params.put("userName", scheUser.getUserName());
		
		try {
			List<ScheUser> list = scheUserService.queryAllScheUser(params);
			if (list != null && list.size() > 0) {
				model.put("errorMsg", "存在相同的用户名，请重新输入");
				model.put("success", false);
			} else {
				scheUser.setCreateDate(new Date());
				User user = UserStore.get(request);
				if (user != null) {
					scheUser.setCreateBy(user.getUserName());
				}
				scheUserService.saveScheUser(scheUser);
				model.put("success", true);
			}
		} catch (Exception e) {
			model.put("errorMsg", "保存用户错误");
			model.put("success", false);
		}
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 修改用户
	 * @param model
	 * @param scheUserGroup
	 * @return
	 */
	@RequestMapping(value = { "/updateUser" },method=RequestMethod.POST)
	public View updateUser(ModelMap model,
			@ModelAttribute("scheUser") ScheUser scheUser,
			HttpServletRequest request) {
		if (scheUser == null){
			model.put("errorMsg", "操作失败:参数不合法");
			model.put("success", false);
			return new MappingJacksonJsonView();
		}
		
		try {
			scheUser.setUpdateDate(new Date());
			User user = UserStore.get(request);
			if (user != null) {
				scheUser.setUpdateBy(user.getUserName());
			}
			scheUserService.updateScheUser(scheUser);
			model.put("success", true);
		} catch (Exception e) {
			model.put("errorMsg", "保存用户错误");
			model.put("success", false);
		}
		
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 查询所有任务用户
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/queryAllUser" })
	public View queryAllUser(ModelMap model) {
		final Map<String, Object> maps = new HashMap<String, Object>(1);
		
		List<ScheUser> allUser = scheUserService.queryAllScheUser(maps);
		
		model.put("topics", allUser);
		return new MappingJacksonJsonView();
	}
	
	/**
	 * 查询所有用户组
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "/queryAllUserGroup" })
	public View queryAllUserGroup(ModelMap model) {
		final Map<String, Object> maps = new HashMap<String, Object>(1);
		
		List<ScheUserGroup> allUser = scheUserGroupService.queryScheUserGroup(maps);
		
		model.put("topics", allUser);
		return new MappingJacksonJsonView();
	}
	
	@RequestMapping(value = { "/queryUserFromAuthCenter" })
	public View queryUserFromAuthCenter(ModelMap model,String queryStr) {
		List<UserDetail> list = Config.getAuthCenterFacade().queryUser(queryStr);
		if (list != null || list.size() > 0 ){
			model.put("topics", list);
		}
		return new MappingJacksonJsonView();
	}
}
