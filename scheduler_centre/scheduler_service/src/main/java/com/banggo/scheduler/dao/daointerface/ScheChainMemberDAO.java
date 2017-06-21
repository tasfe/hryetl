package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;
import com.banggo.scheduler.dao.dataobject.ScheChainMember;

public interface ScheChainMemberDAO {

	
	int insert(ScheChainMember record) throws DataAccessException;

	
	int updateByPrimaryKey(ScheChainMember record) throws DataAccessException;

	
	int updateByPrimaryKeySelective(ScheChainMember record) throws DataAccessException;

	
	ScheChainMember selectByPrimaryKey(Integer id) throws DataAccessException;


	int deleteByPrimaryKey(Integer id) throws DataAccessException;


	ScheChainMember leftChild(ScheChainMember node);


	List<ScheChainMember> query(Map params);


	/**
	 * 查找正在执行中或未开始执行的member
	 * @param params
	 * @return
	 */
	List<ScheChainMember> selectUnExecuteFinishedMember(Map params);


	ScheChainMember selectMainMemberOfBarrier(Map params);
}