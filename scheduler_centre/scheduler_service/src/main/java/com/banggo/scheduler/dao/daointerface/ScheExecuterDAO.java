package com.banggo.scheduler.dao.daointerface;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheExecuter;
import com.banggo.scheduler.dao.ro.ScheExecRecordRO;

public interface ScheExecuterDAO {
    
    int insert(ScheExecuter record) throws DataAccessException;

   
    int updateByPrimaryKey(ScheExecuter record) throws DataAccessException;

   
    int updateByPrimaryKeySelective(ScheExecuter record) throws DataAccessException;

    
    ScheExecuter selectByPrimaryKey(Integer id) throws DataAccessException;

    int deleteByPrimaryKey(Integer id) throws DataAccessException;
    
    List<ScheExecuter> queryRunnig(Map params)  throws DataAccessException;
    
    ScheExecuter select(Map params) throws DataAccessException;
    
    List<ScheExecRecordRO> query(Map params)  throws DataAccessException;
    
    int count (Map params)  throws DataAccessException;


	int updateStatus(Integer id, String status);
}