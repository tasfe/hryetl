package com.banggo.scheduler.dao.ibatis;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheApplicationDAO;
import com.banggo.scheduler.dao.dataobject.ScheApplication;

public class ScheApplicationDAOImpl implements ScheApplicationDAO {
   
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

   
    public void insert(ScheApplication record) throws DataAccessException {
        sqlMapClient.insert("SCHE_APPLICATION.insert", record);
    }

  
    public int updateByPrimaryKey(ScheApplication record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_APPLICATION.updateByPrimaryKey", record);
        return rows;
    }

   
    public int updateByPrimaryKeySelective(ScheApplication record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_APPLICATION.updateByPrimaryKeySelective", record);
        return rows;
    }

    public ScheApplication selectByPrimaryKey(Integer id) throws DataAccessException {
        ScheApplication key = new ScheApplication();
        key.setId(id);
        ScheApplication record = (ScheApplication) sqlMapClient.queryForObject("SCHE_APPLICATION.selectByPrimaryKey", key);
        return record;
    }

   
    public int deleteByPrimaryKey(Integer id) throws DataAccessException {
        ScheApplication key = new ScheApplication();
        key.setId(id);
        int rows = sqlMapClient.delete("SCHE_APPLICATION.deleteByPrimaryKey", key);
        return rows;
    }


	@Override
	public List<ScheApplication> query(Map params) throws DataAccessException {
		if (params == null)
			params = new HashMap();
		return sqlMapClient.queryForList("SCHE_APPLICATION.query",params);
	}


	@Override
	public Date now() {
		return (Date)sqlMapClient.queryForObject("SCHE_APPLICATION.now");
	}
}