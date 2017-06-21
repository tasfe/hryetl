TRUNCATE TABLE K_TRADE.DWD_DEPOSIT_ORDER_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_DEPOSIT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM DEPOSIT.t_deposit_order@kjtdb t;
COMMIT;


--select max(gmt_create) from   K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D

TRUNCATE TABLE K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM DEPOSIT.T_PAYMENT_ORDER@kjtdb t;
COMMIT;



TRUNCATE TABLE K_TRADE.DWD_FUNDOUT_ORDER_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_FUNDOUT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM fos.tt_fundout_order@kjtdb t;
COMMIT;



TRUNCATE TABLE K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM fos.tt_payment_order@kjtdb t;
COMMIT;



TRUNCATE TABLE K_TRADE.DWD_PAYMENT_ORDER_D;

INSERT /*+ append nologging */ INTO K_TRADE.DWD_PAYMENT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM payment.tb_payment_order@kjtdb t;
COMMIT;


TRUNCATE TABLE K_TRADE.DWD_PAYMENT_PARTY_D;

INSERT /*+ append nologging */ INTO K_TRADE.DWD_PAYMENT_PARTY_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM payment.tb_party_payment@kjtdb t;
COMMIT;




TRUNCATE TABLE K_TRADE.DWD_TSS_PAY_METHOD_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_TSS_PAY_METHOD_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM tss.t_pay_method@kjtdb t;
COMMIT;



TRUNCATE TABLE K_TRADE.DWD_TSS_PAYMENT_ORDER_D;
INSERT INTO K_TRADE.DWD_TSS_PAYMENT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM tss.T_PAYMENT_ORDER@kjtdb t;
COMMIT;


TRUNCATE TABLE K_TRADE.DWD_TSS_TRADE_FEE_D;
INSERT INTO K_TRADE.DWD_TSS_TRADE_FEE_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM tss.T_TRADE_FEE@kjtdb t;
COMMIT;


TRUNCATE TABLE K_TRADE.DWD_TSS_TRADE_ORDER_D;
INSERT /*+ append nologging */ INTO K_TRADE.DWD_TSS_TRADE_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM tss.t_trade_order@kjtdb t;
COMMIT;



