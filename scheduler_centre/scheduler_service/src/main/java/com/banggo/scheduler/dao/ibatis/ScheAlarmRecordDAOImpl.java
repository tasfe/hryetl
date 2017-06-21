package com.banggo.scheduler.dao.ibatis;

import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.banggo.scheduler.dao.daointerface.ScheAlarmRecordDAO;
import com.banggo.scheduler.dao.dataobject.ScheAlarmRecord;

public class ScheAlarmRecordDAOImpl implements ScheAlarmRecordDAO {
	private SqlMapClientTemplate sqlMapClient;

	public void setSqlMapClient(SqlMapClientTemplate sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}


    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_ALARM_RECORD
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public void insert(ScheAlarmRecord record) throws DataAccessException {
        sqlMapClient.insert("SCHE_ALARM_RECORD.insert", record);
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_ALARM_RECORD
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int updateByPrimaryKey(ScheAlarmRecord record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_ALARM_RECORD.updateByPrimaryKey", record);
        return rows;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_ALARM_RECORD
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int updateByPrimaryKeySelective(ScheAlarmRecord record) throws DataAccessException {
        int rows = sqlMapClient.update("SCHE_ALARM_RECORD.updateByPrimaryKeySelective", record);
        return rows;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_ALARM_RECORD
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public ScheAlarmRecord selectByPrimaryKey(Integer id) throws DataAccessException {
        ScheAlarmRecord key = new ScheAlarmRecord();
        key.setId(id);
        ScheAlarmRecord record = (ScheAlarmRecord) sqlMapClient.queryForObject("SCHE_ALARM_RECORD.selectByPrimaryKey", key);
        return record;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method corresponds to the database table SCHE_ALARM_RECORD
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public int deleteByPrimaryKey(Integer id) throws DataAccessException {
        ScheAlarmRecord key = new ScheAlarmRecord();
        key.setId(id);
        int rows = sqlMapClient.delete("SCHE_ALARM_RECORD.deleteByPrimaryKey", key);
        return rows;
    }


	@Override
	public int countAlertedTimes(Map params) {
		Integer count = (Integer) sqlMapClient.queryForObject("SCHE_ALARM_RECORD.countAlertedTimes", params);
		return  count != null? count.intValue() : 0;
	}
}