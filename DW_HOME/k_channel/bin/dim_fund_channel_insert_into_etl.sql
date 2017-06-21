--- 173*** 渠道属性相关
---  渠道列表 入ODS
delete from bipay.bi_daily_tasks_etl where id  = 173001;
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173001
,'ODS--渠道列表 入ODS'
,'${email_ok}'
,null
,'TRUNCATE TABLE K_CHANNEL_ODS.fund_channel_inc; INSERT /*+ append nologging */ INTO K_CHANNEL_ODS.fund_channel_inc SELECT * FROM cmf.tm_fund_channel@kjtdb;'
,null
,null
,null
,'ODS'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL
;
commit;

---  渠道列表 入DW
delete from bipay.bi_daily_tasks_etl where id  = 173002;
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173002
,'DW--渠道列表入 DW'
,'${email_ok}'
,null
,'MERGE /*+ append nologging */ INTO K_CHANNEL.DIM_FUND_CHANNEL_D s1 USING K_CHANNEL_ODS.FUND_CHANNEL_INC s0 ON (s0.fund_channel_code=s1.fund_channel_code) WHEN MATCHED THEN UPDATE SET  s1.NAME=s0.NAME,s1.DESCRIPTION=s0.DESCRIPTION,s1.INST_CODE=s0.INST_CODE,s1.BIZ_TYPE=s0.BIZ_TYPE,s1.PAY_MODE=s0.PAY_MODE,s1.SIGNED_CROP=s0.SIGNED_CROP,s1.STATUS=s0.STATUS,s1.VALID_FROM=s0.VALID_FROM,s1.VALID_TO=s0.VALID_TO,s1.MAX_AMOUNT=s0.MAX_AMOUNT,s1.MIN_AMOUNT=s0.MIN_AMOUNT,s1.EXPECT_ARRIVE_TIME=s0.EXPECT_ARRIVE_TIME,s1.GMT_CREATE=s0.GMT_CREATE,s1.GMT_MODIFIED=s0.GMT_MODIFIED,s1.MEMO=s0.MEMO,s1.CHANNEL_MODE=s0.CHANNEL_MODE,s1.PRIORITY=s0.PRIORITY,s1.dw_modified_time=sysdate WHEN NOT MATCHED THEN INSERT (FUND_CHANNEL_CODE,NAME,DESCRIPTION,INST_CODE,BIZ_TYPE,PAY_MODE,SIGNED_CROP,STATUS,VALID_FROM,VALID_TO,MAX_AMOUNT,MIN_AMOUNT,EXPECT_ARRIVE_TIME,GMT_CREATE,GMT_MODIFIED,MEMO,CHANNEL_MODE,PRIORITY,dw_create_time,dw_modified_time) VALUES (s0.fund_channel_code,s0.NAME,s0.DESCRIPTION,s0.INST_CODE,s0.BIZ_TYPE,s0.PAY_MODE,s0.SIGNED_CROP,s0.STATUS,s0.VALID_FROM,s0.VALID_TO,s0.MAX_AMOUNT,s0.MIN_AMOUNT,s0.EXPECT_ARRIVE_TIME,s0.GMT_CREATE,s0.GMT_MODIFIED,s0.MEMO,s0.CHANNEL_MODE,s0.PRIORITY,sysdate,sysdate);'
,null
,null
,null
,'DW'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL;

commit;

--- 目前有问题，存在大字段，不能走dblink
--- 渠道目标机构 入 ODS
delete from bipay.bi_daily_tasks_etl where id  = 173003;
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173003
,'ODS--渠道目标机构 入ODS'
,'${email_ok}'
,null
,'TRUNCATE TABLE K_CHANNEL_ODS.fund_channel_target_inst_inc; INSERT /*+ append nologging */ INTO K_CHANNEL_ODS.fund_channel_target_inst_inc SELECT TARGET_INST_CODE,SHORT_NAME,TARGET_INST_NAME,TARGET_INST_DESC,ICON_URL,NULL,GMT_CREATE,GMT_MODIFIED FROM CMF.TM_FUND_CHANNEL_TARGET_INST@KJTDB;'
,null
,null
,null
,'ODS'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL
;
commit;

--- 目前有问题，存在大字段，不能走dblink
---  渠道目标机构 入DW
delete from bipay.bi_daily_tasks_etl where id  = 173004;
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173004
,'DW--渠道目标机构 DW'
,'${email_ok}'
,null
,'MERGE /*+ append nologging */ INTO K_CHANNEL.DIM_FUND_CHANNEL_target_inst_D s1 USING K_CHANNEL_ODS.fund_channel_target_inst_inc s0 ON (s0.TARGET_INST_CODE=s1.TARGET_INST_CODE) WHEN MATCHED THEN UPDATE SET s1.SHORT_NAME=s0.SHORT_NAME,s1.TARGET_INST_NAME=s0.TARGET_INST_NAME,s1.TARGET_INST_DESC=s0.TARGET_INST_DESC,s1.ICON_URL=s0.ICON_URL,s1.AMOUNT_LIMIT_DESC=s0.AMOUNT_LIMIT_DESC,s1.GMT_CREATE=s0.GMT_CREATE,s1.GMT_MODIFIED=s0.GMT_MODIFIED,s1.dw_modified_time=sysdate WHEN NOT MATCHED THEN INSERT (TARGET_INST_CODE,SHORT_NAME,TARGET_INST_NAME,TARGET_INST_DESC,ICON_URL,AMOUNT_LIMIT_DESC,GMT_CREATE,GMT_MODIFIED,DW_CREATE_TIME,DW_MODIFIED_TIME) VALUES (s0.TARGET_INST_CODE,s0.SHORT_NAME,s0.TARGET_INST_NAME,s0.TARGET_INST_DESC,s0.ICON_URL,s0.AMOUNT_LIMIT_DESC,s0.GMT_CREATE,s0.GMT_MODIFIED,sysdate,sysdate);'
,null
,null
,null
,'DW'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL;

commit;


----渠道和目标机构 关系表 入 ODS
delete from bipay.bi_daily_tasks_etl where id  = 173005
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173005
,'ODS--渠道和目标机构 关系表 入 ODS'
,'${email_ok}'
,null
,'TRUNCATE TABLE K_CHANNEL_ODS.dim_fc_target_inst_r_inc; INSERT /*+ append nologging */ INTO K_CHANNEL_ODS.dim_fc_target_inst_r_inc select s0.id,s0.fund_channel_code,s0.target_inst_code from cmf.tr_fc_target_inst_relation@kjtdb s0'
,null
,null
,null
,'ODS'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL
;
commit;

---  渠道和目标机构 关系表 入 DW
delete from bipay.bi_daily_tasks_etl where id  = 173006;
INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
173006
,'DW--渠道和目标机构 关系表 入 DW'
,'${email_ok}'
,null
,'MERGE /*+ append nologging */ INTO K_CHANNEL.DIM_FC_target_inst_relation_D s1 USING K_CHANNEL_ODS.dim_fc_target_inst_r_inc s0 ON (s0.id=s1.id) WHEN MATCHED THEN UPDATE SET s1.FUND_CHANNEL_CODE=s0.FUND_CHANNEL_CODE,s1.TARGET_INST_CODE=s0.TARGET_INST_CODE,s1.dw_modified_time=sysdate WHEN NOT MATCHED THEN INSERT (id,FUND_CHANNEL_CODE,TARGET_INST_CODE,DW_CREATE_TIME,DW_MODIFIED_TIME) VALUES (s0.id,s0.FUND_CHANNEL_CODE,s0.TARGET_INST_CODE,sysdate,sysdate);'
,null
,null
,null
,'DW'
,null
,null
,0
,null
,1
,'D'
,'张家欢'
,null
,sysdate
FROM DUAL;

commit;


