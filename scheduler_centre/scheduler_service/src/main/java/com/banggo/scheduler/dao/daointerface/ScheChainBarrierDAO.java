package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;

public interface ScheChainBarrierDAO {
  
    void insert(ScheChainBarrier record) throws DataAccessException;

   
    int updateByPrimaryKey(ScheChainBarrier record) throws DataAccessException;

   
    int updateByPrimaryKeySelective(ScheChainBarrier record) throws DataAccessException;

    
    ScheChainBarrier selectByPrimaryKey(Integer id) throws DataAccessException;
    
    List<ScheChainBarrier>  select(Map params) throws DataAccessException;
  
    int deleteByPrimaryKey(Integer id) throws DataAccessException;

	
}