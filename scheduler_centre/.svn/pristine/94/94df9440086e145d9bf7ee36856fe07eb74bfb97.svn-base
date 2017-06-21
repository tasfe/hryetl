package com.banggo.scheduler.dao.daointerface;

import org.springframework.dao.DataAccessException;

import com.banggo.scheduler.dao.dataobject.ScheJobParams;

public interface ScheJobParamsDAO {
   
    void insert(ScheJobParams record) throws DataAccessException;

    
    int updateByPrimaryKey(ScheJobParams record) throws DataAccessException;

    int updateByPrimaryKeySelective(ScheJobParams record) throws DataAccessException;

   
    ScheJobParams selectByPrimaryKey(Integer id) throws DataAccessException;

   
    int deleteByPrimaryKey(Integer id) throws DataAccessException;
    
    /**
     * 根据scheJobId物理删除记录
     * @param scheJobId
     * @return
     * @throws DataAccessException
     */
    int deleteByScheJobId(int scheJobId) throws DataAccessException;
}