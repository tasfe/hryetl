package com.banggo.scheduler.dao.ibatis;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheUserDAO;
import com.banggo.scheduler.dao.dataobject.ScheUser;

public class ScheUserDAOImpl implements ScheUserDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_USER
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public void insert(ScheUser record) throws DataAccessException {
        sqlMapClient.insert("SCHE_USER.insert", record);
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_USER
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int updateByPrimaryKey(ScheUser record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_USER.updateByPrimaryKey", record);
        return rows;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_USER
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int updateByPrimaryKeySelective(ScheUser record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_USER.updateByPrimaryKeySelective", record);
        return rows;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_USER
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public ScheUser selectByPrimaryKey(Integer id) throws DataAccessException {
        ScheUser key = new ScheUser();
        key.setId(id);
        ScheUser record = (ScheUser) sqlMapClient.queryForObject("SCHE_USER.selectByPrimaryKey", key);
        return record;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_USER
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int deleteByPrimaryKey(Integer id) throws DataAccessException {
        ScheUser key = new ScheUser();
        key.setId(id);
        int rows = sqlMapClient.delete("SCHE_USER.deleteByPrimaryKey", key);
        return rows;
    }
    
    public List<ScheUser> selectByList(Map params) {
    	return sqlMapClient.queryForList("SCHE_USER.selectList", params);
    }

	@Override
	public List<ScheUser> queryUserByUserGroup(Integer scheUserGroupId) {
		return sqlMapClient.queryForList("SCHE_USER.queryUserByUserGroup",scheUserGroupId);
	}
}