package com.banggo.scheduler.dao.daointerface;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheApplication;

public interface ScheApplicationDAO {
   
    void insert(ScheApplication record) throws DataAccessException;

   
    int updateByPrimaryKey(ScheApplication record) throws DataAccessException;

  
    int updateByPrimaryKeySelective(ScheApplication record) throws DataAccessException;

    ScheApplication selectByPrimaryKey(Integer id) throws DataAccessException;

  
    int deleteByPrimaryKey(Integer id) throws DataAccessException;
    
    List<ScheApplication> query(Map params) throws DataAccessException;


	Date now();
}