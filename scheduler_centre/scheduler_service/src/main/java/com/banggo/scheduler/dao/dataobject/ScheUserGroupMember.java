package com.banggo.scheduler.dao.dataobject;

public class ScheUserGroupMember {
    /**
     * This field was generated by Abator for iBATIS.
     * This field corresponds to the database column SCHE_USER_GROUP_MEMBER.ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    private Integer id;

    /**
     * This field was generated by Abator for iBATIS.
     * This field corresponds to the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_GROUP_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    private Integer scheUserGroupId;

    /**
     * This field was generated by Abator for iBATIS.
     * This field corresponds to the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    private Integer scheUserId;
    
    /**
     * 关联任务用户表中的用户姓名
     */
    private String scheUserName;
    
    /**
     * 关联任务用户表中的用户名
     */
    private String userName;

    /**
     * This method was generated by Abator for iBATIS.
     * This method returns the value of the database column SCHE_USER_GROUP_MEMBER.ID
     *
     * @return the value of SCHE_USER_GROUP_MEMBER.ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public Integer getId() {
        return id;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method sets the value of the database column SCHE_USER_GROUP_MEMBER.ID
     *
     * @param id the value for SCHE_USER_GROUP_MEMBER.ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method returns the value of the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_GROUP_ID
     *
     * @return the value of SCHE_USER_GROUP_MEMBER.SCHE_USER_GROUP_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public Integer getScheUserGroupId() {
        return scheUserGroupId;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method sets the value of the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_GROUP_ID
     *
     * @param scheUserGroupId the value for SCHE_USER_GROUP_MEMBER.SCHE_USER_GROUP_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public void setScheUserGroupId(Integer scheUserGroupId) {
        this.scheUserGroupId = scheUserGroupId;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method returns the value of the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_ID
     *
     * @return the value of SCHE_USER_GROUP_MEMBER.SCHE_USER_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public Integer getScheUserId() {
        return scheUserId;
    }

    /**
     * This method was generated by Abator for iBATIS.
     * This method sets the value of the database column SCHE_USER_GROUP_MEMBER.SCHE_USER_ID
     *
     * @param scheUserId the value for SCHE_USER_GROUP_MEMBER.SCHE_USER_ID
     *
     * @abatorgenerated Thu Nov 15 14:34:17 CST 2012
     */
    public void setScheUserId(Integer scheUserId) {
        this.scheUserId = scheUserId;
    }

	public String getScheUserName() {
		return scheUserName;
	}

	public void setScheUserName(String scheUserName) {
		this.scheUserName = scheUserName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}