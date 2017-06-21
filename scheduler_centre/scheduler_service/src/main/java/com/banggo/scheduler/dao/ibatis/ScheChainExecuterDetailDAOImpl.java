package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheChainExecuterDetailDAO;
import com.banggo.scheduler.dao.dataobject.ScheChainExecuterDetail;

public class ScheChainExecuterDetailDAOImpl implements ScheChainExecuterDetailDAO {
   
    private SqlMapClientTemplate sqlMapClient;

    public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

   
    public void insert(ScheChainExecuterDetail record) throws DataAccessException {
        sqlMapClient.insert("SCHE_CHAIN_EXECUTER_DETAIL.insert", record);
    }

   
    public int updateByPrimaryKey(ScheChainExecuterDetail record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_CHAIN_EXECUTER_DETAIL.updateByPrimaryKey", record);
        return rows;
    }

   
    public int updateByPrimaryKeySelective(ScheChainExecuterDetail record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_CHAIN_EXECUTER_DETAIL.updateByPrimaryKeySelective", record);
        return rows;
    }

   
    public ScheChainExecuterDetail selectByPrimaryKey(Integer id) throws DataAccessException {
        ScheChainExecuterDetail key = new ScheChainExecuterDetail();
        key.setId(id);
        ScheChainExecuterDetail record = (ScheChainExecuterDetail) sqlMapClient.queryForObject("SCHE_CHAIN_EXECUTER_DETAIL.selectByPrimaryKey", key);
        return record;
    }

   
    public int deleteByPrimaryKey(Integer id) throws DataAccessException {
        ScheChainExecuterDetail key = new ScheChainExecuterDetail();
        key.setId(id);
        int rows = sqlMapClient.delete("SCHE_CHAIN_EXECUTER_DETAIL.deleteByPrimaryKey", key);
        return rows;
    }


	@Override
	public List<ScheChainExecuterDetail> queryActivity(Map params) {
		return sqlMapClient.queryForList("SCHE_CHAIN_EXECUTER_DETAIL.queryActivity",params);
	}
}