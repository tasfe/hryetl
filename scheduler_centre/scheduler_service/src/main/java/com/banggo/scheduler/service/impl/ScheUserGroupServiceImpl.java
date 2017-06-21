package com.banggo.scheduler.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.transaction.TransactionStatus;

import com.banggo.scheduler.dao.daointerface.ScheUserGroupDAO;
import com.banggo.scheduler.dao.daointerface.ScheUserGroupMemberDAO;
import com.banggo.scheduler.dao.dataobject.ScheUserGroup;
import com.banggo.scheduler.dao.dataobject.ScheUserGroupMember;
import com.banggo.scheduler.service.ScheUserGroupService;
import com.banggo.scheduler.service.transaction.TransactionService;

public class ScheUserGroupServiceImpl implements ScheUserGroupService {

	private Logger logger = Logger.getLogger(ScheUserGroupServiceImpl.class);
	
	@Resource
	private ScheUserGroupDAO scheUserGroupDAO;
	
	@Resource
	private ScheUserGroupMemberDAO scheUserGroupMemberDAO;
	
	@Resource
	private TransactionService transactionService;
	
	public long SaveScheUserGroup(ScheUserGroup groupModel, String userId) {
		
		int pk = -1;
		if (groupModel == null || userId == null) {
			return pk;
		}
		
		TransactionStatus ts = transactionService.begin(); // 启动事务
		
		try {
			pk = scheUserGroupDAO.insert(groupModel);
			
			if (pk == -1) {
				logger.warn("保存用户组出错 " + groupModel);
				return -1;
			}
			
			String[] userIds = userId.split(",");
			
			for (String user : userIds) {
				ScheUserGroupMember member = new ScheUserGroupMember();
				member.setScheUserGroupId(pk);
				member.setScheUserId(Integer.valueOf(user));
				scheUserGroupMemberDAO.insert(member);
			}
			
			transactionService.commit(ts);
		} catch (Throwable t) {
			transactionService.rollback(ts);
		}
		
		return pk;
	}
	
	public int updateScheUserGroup(ScheUserGroup groupModel, String userId) {
		TransactionStatus ts = transactionService.begin(); // 启动事务
		
		int result = -1;
		
		if (groupModel == null || userId == null) {
			return result;
		}
		try {
			// 更新用户组
			result = scheUserGroupDAO.updateByPrimaryKeySelective(groupModel);
			
			/*ScheUserGroup model = scheUserGroupDAO.selectByPrimaryKey(groupModel.getId());
			List<ScheUserGroupMember> memberList = model.getScheUserGroupMemberList();
			
			// 删除其他用户
			for (ScheUserGroupMember groupMember : memberList) {
				scheUserGroupMemberDAO.deleteByPrimaryKey(groupMember.getId());
			}*/
			
			if (result > 0) {
				// 删除所属用户
				scheUserGroupMemberDAO.deleteByGroupId(groupModel.getId());
				
				// 保存新的所属用户
				String[] userIds = userId.split(",");
				for (String user : userIds) {
					ScheUserGroupMember member = new ScheUserGroupMember();
					member.setScheUserGroupId(groupModel.getId());
					member.setScheUserId(Integer.valueOf(user));
					scheUserGroupMemberDAO.insert(member);
				}
				
				transactionService.commit(ts);
			} else {
				result = -1;
				transactionService.rollback(ts);
			}
		} catch (Throwable t) {
			logger.error(t);
			result = -1;
			transactionService.rollback(ts);
		}
		
		return result;
	}
	
	public int deleteScheUserGroup(long id) {
		TransactionStatus ts = transactionService.begin(); // 启动事务
		
		int result = -1;
		
		try {
			
			int gid = Long.valueOf(id).intValue();
			/*ScheUserGroup model = scheUserGroupDAO.selectByPrimaryKey(gid);
			List<ScheUserGroupMember> memberList = model.getScheUserGroupMemberList();
			// 删除其他用户
			for (ScheUserGroupMember groupMember : memberList) {
				scheUserGroupMemberDAO.deleteByPrimaryKey(groupMember.getId());
			}*/
			
			// 删除用户组
			result = scheUserGroupDAO.deleteByPrimaryKey(gid);
			// 根据用户组id删除所属用户
			scheUserGroupMemberDAO.deleteByGroupId(gid);
			transactionService.commit(ts);
		} catch (Throwable t) {
			logger.error(t);
			result = -1;
			transactionService.rollback(ts);
		}
		
		return result;
	}
	
	public ScheUserGroup retrieveScheUserGroup(long id) {
		return scheUserGroupDAO.selectByPrimaryKey(Long.valueOf(id).intValue());
	}
	
	public List<ScheUserGroup> queryScheUserGroup(Map params) {
		return scheUserGroupDAO.select(params);
	}

	public int queryScheUserGroupSize(Map params) {
		return scheUserGroupDAO.count(params);
	}
}
