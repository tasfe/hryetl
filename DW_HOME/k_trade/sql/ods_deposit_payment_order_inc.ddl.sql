
drop table k_trade_ods.ods_deposit_payment_order_inc;

CREATE TABLE k_trade_ods.ods_deposit_payment_order_inc 
(
  PAYMENT_VOUCHER_NO VARCHAR2(32 BYTE) NOT NULL  
, TRADE_VOUCHER_NO VARCHAR2(32 BYTE) 
, PRODUCT_CODE VARCHAR2(16 BYTE) NOT NULL 
, MEMBER_ID VARCHAR2(32 BYTE) NOT NULL 
, ACCOUNT_NO VARCHAR2(32 BYTE) 
, AMOUNT NUMBER(15, 2) NOT NULL 
, FEE NUMBER(15, 2) 
, PAY_MODE VARCHAR2(32 BYTE) 
, PAY_CHANNEL VARCHAR2(32 BYTE) 
, REMARK VARCHAR2(128 BYTE) 
, GMT_PAY_SUBMIT TIMESTAMP(6) 
, PAYMENT_STATUS VARCHAR2(16 BYTE) 
, EXT VARCHAR2(4000 BYTE) 
, BIZ_PAYMENT_SEQ_NO VARCHAR2(32 BYTE) 
, BIZ_PAYMENT_STATE VARCHAR2(16 BYTE) 
, BIZ_SUB_STATE VARCHAR2(16 BYTE) 
, INST_PAY_NO VARCHAR2(32 BYTE) 
, GMT_PAID TIMESTAMP(6) 
, ACCESS_CHANNEL VARCHAR2(16 BYTE) 
, GMT_CREATE TIMESTAMP(6) NOT NULL 
, GMT_MODIFIED TIMESTAMP(6) 
, MERCHANT_NOTIFY_STATUS VARCHAR2(16 BYTE) 
, USER_NOTIFY_STATUS VARCHAR2(16 BYTE) 
);





COMMENT ON TABLE k_trade_ods.ods_deposit_payment_order_inc IS '充值支付订单_ODS';

COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.PAYMENT_VOUCHER_NO IS '支付凭证号，主键，统一凭证';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.TRADE_VOUCHER_NO IS '订单凭证号';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.PRODUCT_CODE IS '支付产品编码';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.MEMBER_ID IS '客户ID';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.ACCOUNT_NO IS '用户账户';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.AMOUNT IS '金额';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.FEE IS '费用';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.PAY_MODE IS '支付模式';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.PAY_CHANNEL IS '支付渠道';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.REMARK IS '支付说明';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.GMT_PAY_SUBMIT IS '支付提交时间';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.PAYMENT_STATUS IS '支付状态';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.EXT IS '扩展参数';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.BIZ_PAYMENT_SEQ_NO IS '业务支付流水号';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.BIZ_PAYMENT_STATE IS '业务支付状态';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.BIZ_SUB_STATE IS '业务支付子状态';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.INST_PAY_NO IS '机构支付编码';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.GMT_PAID IS '支付完成时间';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.ACCESS_CHANNEL IS '终端类型';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.GMT_CREATE IS '创建时间';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.GMT_MODIFIED IS '修改时间';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.MERCHANT_NOTIFY_STATUS IS '商户通知状态';
COMMENT ON COLUMN k_trade_ods.ods_deposit_payment_order_inc.USER_NOTIFY_STATUS IS '用户通知状态';