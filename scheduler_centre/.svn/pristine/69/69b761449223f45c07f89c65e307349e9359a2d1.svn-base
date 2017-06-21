package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuter;

public interface ScheChainExecuterDAO {

	
	int insert(ScheChainExecuter record) throws DataAccessException;

	
	int updateByPrimaryKey(ScheChainExecuter record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheChainExecuter record)
			throws DataAccessException;

	ScheChainExecuter selectByPrimaryKey(Integer id) throws DataAccessException;

	int deleteByPrimaryKey(Integer id) throws DataAccessException;


	int countScheChainExecuter(Map params);


	List<ScheChainExecuter> selectScheChainExecuter(Map params);


	List<Integer> queryScheExecuterIdByChainExecuter(int scheChainExecuteId);
}