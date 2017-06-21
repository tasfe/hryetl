package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;

public interface ScheChainExecuterDetailDAO {
    void insert(ScheChainExecuterDetail record) throws DataAccessException;

   
    int updateByPrimaryKey(ScheChainExecuterDetail record) throws DataAccessException;

   
    int updateByPrimaryKeySelective(ScheChainExecuterDetail record) throws DataAccessException;

  
    ScheChainExecuterDetail selectByPrimaryKey(Integer id) throws DataAccessException;

  
    int deleteByPrimaryKey(Integer id) throws DataAccessException;


	List<ScheChainExecuterDetail> queryActivity(Map params);
	
}