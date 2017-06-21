package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheChainBarrierDAO;
import com.banggo.scheduler.dao.dataobject.ScheChainBarrier;

public class ScheChainBarrierDAOImpl implements ScheChainBarrierDAO {
   
    private SqlMapClientTemplate sqlMapClient;
    
    public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

   
    public void insert(ScheChainBarrier record) throws DataAccessException {
        sqlMapClient.insert("SCHE_CHAIN_BARRIER.insert", record);
    }

   
    public int updateByPrimaryKey(ScheChainBarrier record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_CHAIN_BARRIER.updateByPrimaryKey", record);
        return rows;
    }

    
    public int updateByPrimaryKeySelective(ScheChainBarrier record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_CHAIN_BARRIER.updateByPrimaryKeySelective", record);
        return rows;
    }

   
    public ScheChainBarrier selectByPrimaryKey(Integer id) throws DataAccessException {
        ScheChainBarrier key = new ScheChainBarrier();
        key.setId(id);
        ScheChainBarrier record = (ScheChainBarrier) sqlMapClient.queryForObject("SCHE_CHAIN_BARRIER.selectByPrimaryKey", key);
        return record;
    }

   
    public int deleteByPrimaryKey(Integer id) throws DataAccessException {
        ScheChainBarrier key = new ScheChainBarrier();
        key.setId(id);
        int rows = sqlMapClient.delete("SCHE_CHAIN_BARRIER.deleteByPrimaryKey", key);
        return rows;
    }


	@Override
	public List<ScheChainBarrier> select(Map params) throws DataAccessException {
		
		return (List<ScheChainBarrier>)sqlMapClient.queryForList("SCHE_CHAIN_BARRIER.query",params);
	}


}