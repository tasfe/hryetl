package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheChain;

public interface ScheChainDAO {

	
	int insert(ScheChain record) throws DataAccessException;

	int updateByPrimaryKey(ScheChain record) throws DataAccessException;

	int updateByPrimaryKeySelective(ScheChain record) throws DataAccessException;

	
	ScheChain selectByPrimaryKey(Integer id) throws DataAccessException;

	
	int deleteByPrimaryKey(Integer id) throws DataAccessException;

	ScheChain selectActivityByJobId(int scheJobId);

	List<ScheChain> query(Map params);

	int count(Map params);

	ScheChain selectByChainName(String chainName);
}