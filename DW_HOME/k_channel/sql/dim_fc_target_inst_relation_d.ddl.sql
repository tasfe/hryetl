CREATE TABLE K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D
(
	ID	NUMBER(11,0)
	,FUND_CHANNEL_CODE	VARCHAR2(32 BYTE)
	,TARGET_INST_CODE	VARCHAR2(16 BYTE)
	,DW_CREATE_TIME DATE DEFAULT SYSDATE
	,DW_MODIFIED_TIME DATE DEFAULT SYSDATE
)
;

COMMENT ON TABLE K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D IS '渠道和目标机构关系表';

COMMENT ON column K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D.ID IS '关系ID';
COMMENT ON column K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D.FUND_CHANNEL_CODE IS '渠道编码';
COMMENT ON column K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D.TARGET_INST_CODE IS '目标机构编码';

COMMENT ON column K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D.DW_CREATE_TIME IS 'DW 创建时间';
COMMENT ON column K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D.DW_MODIFIED_TIME IS 'DW 更新时间';