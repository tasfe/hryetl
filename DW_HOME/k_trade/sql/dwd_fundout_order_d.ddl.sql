CREATE TABLE K_TRADE.DWD_FUNDOUT_ORDER_D  
(
  FUNDOUT_ORDER_NO VARCHAR2(32 BYTE) NOT NULL 
, PRODUCT_CODE VARCHAR2(32 BYTE) NOT NULL 
, MEMBER_ID VARCHAR2(32 BYTE) NOT NULL 
, ACCOUNT_NO VARCHAR2(32 BYTE) NOT NULL 
, AMOUNT NUMBER(18, 2) NOT NULL 
, FEE NUMBER(18, 2) NOT NULL 
, CARD_ID VARCHAR2(32 BYTE) 
, CARD_NO VARCHAR2(32 BYTE) 
, CARD_TYPE CHAR(2 BYTE) 
, NAME VARCHAR2(256 BYTE) 
, BANK_CODE VARCHAR2(32 BYTE) 
, BANK_NAME VARCHAR2(64 BYTE) 
, BRANCH_NAME VARCHAR2(256 BYTE) 
, BANK_LINE_NO CHAR(12 BYTE) 
, PROV VARCHAR2(64 BYTE) 
, CITY VARCHAR2(64 BYTE) 
, COMPANY_PERSONAL CHAR(1 BYTE) 
, PURPOSE VARCHAR2(256 BYTE) 
, FUNDOUT_GRADE CHAR(1 BYTE) 
, STATUS VARCHAR2(16 BYTE) 
, NOTIFY_STATUS CHAR(1 BYTE) 
, ORDER_TIME DATE 
, RESULT_TIME DATE 
, EXTENSION VARCHAR2(2000 BYTE) 
, GMT_CREATE DATE 
, GMT_MODIFY DATE 
, ACCOUNT_TYPE VARCHAR2(32 BYTE) 
, RESULT_DESC VARCHAR2(256 BYTE) 
, BATCH_ORDER_NO VARCHAR2(32 BYTE) 
, SUBMITTOR_ID VARCHAR2(32 BYTE) 
, REFUND_ORDER_NO VARCHAR2(32 BYTE) 
, REFUND_TIME DATE 
, OUT_ORDER_NO VARCHAR2(64 BYTE) 
, SOURCE_BATCH_NO VARCHAR2(32 BYTE) 
, DW_CREATE_TIME DATE DEFAULT sysdate
, DW_MODIFIED_TIME DATE
) 
PARTITION BY RANGE ("GMT_CREATE") INTERVAL (NUMTOYMINTERVAL(1,'MONTH')) (PARTITION "P_MONTH_1"  VALUES LESS THAN (TO_DATE('20150101','YYYYMMDD')));



COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.PRODUCT_CODE IS '产品编码';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.MEMBER_ID IS '该会员作为付款方参与交易';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.ACCOUNT_NO IS '储值账户';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.AMOUNT IS '出款金额';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.FEE IS '算费所得';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.CARD_ID IS '认证卡号ID，会员提现时使用';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.CARD_NO IS '银行卡卡号';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.CARD_TYPE IS '借记/贷记';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.NAME IS '银行卡户名';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.BANK_CODE IS '银行编码';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.BANK_NAME IS '银行名称';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.BRANCH_NAME IS '分支行信息';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.BANK_LINE_NO IS '联行号,如403874200010';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.PROV IS '省份信息';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.CITY IS '城市信息';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.RESULT_TIME IS '订单状态时间';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.ACCOUNT_TYPE IS '账户类型';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.RESULT_DESC IS '结果描述';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.BATCH_ORDER_NO IS '批次订单号';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.SUBMITTOR_ID IS '提交人ID';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.REFUND_ORDER_NO IS '退票订单号';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.REFUND_TIME IS '退票时间';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.OUT_ORDER_NO IS '外部订单号';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.DW_CREATE_TIME IS 'DW 创建时间';
COMMENT ON COLUMN K_TRADE.DWD_FUNDOUT_ORDER_D.DW_MODIFIED_TIME IS 'DW 修改时间';
