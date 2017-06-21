delete from bipay.bi_daily_tasks_etl where id  = 160001;

INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160001,
	'充值交易订单',
	'${email_ok}',
	null,
	'
	TRUNCATE TABLE K_TRADE_ODS.DEPOSIT_ORDER_INC;
	INSERT /*+ append nologging */ INTO K_TRADE_ODS.DEPOSIT_ORDER_INC
	SELECT *
	FROM DEPOSIT.t_deposit_order@kjtdb  
	WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;


	--DELETE /*+   nologging */ FROM  K_TRADE.DWD_DEPOSIT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_DEPOSIT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 
   
	INSERT /*+   nologging */ INTO K_TRADE.DWD_DEPOSIT_ORDER_D
	SELECT 
		  t.*
		  ,sysdate DW_CREATE_TIME
		  ,sysdate DW_MODIFIED_TIME
	FROM K_TRADE_ODS.DEPOSIT_ORDER_INC t;
	',
    null,
    null,
    null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'充值交易订单',
	null,
	sysdate
FROM DUAL;



delete from bipay.bi_daily_tasks_etl where id  = 160002;

INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160002,
	'充值支付订单',
	'${email_ok}',
	null,
	'
	TRUNCATE TABLE K_TRADE_ODS.DEPOSIT_PAYMENT_ORDER_INC;

	INSERT /*+ append nologging */ INTO K_TRADE_ODS.DEPOSIT_PAYMENT_ORDER_INC
	SELECT *
	FROM DEPOSIT.T_PAYMENT_ORDER@kjtdb  
	WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;


	--DELETE /*+   nologging */ FROM  K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_DEPOSIT_PAYMENT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 
   
	INSERT /*+   nologging */ INTO K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D
	SELECT 
		  t.*
		  ,sysdate DW_CREATE_TIME
		  ,sysdate DW_MODIFIED_TIME
	FROM K_TRADE_ODS.DEPOSIT_PAYMENT_ORDER_INC t;
	',
    null,
    null,
    null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'充值支付订单',
	null,
	sysdate
FROM DUAL;

COMMIT;




delete from bipay.bi_daily_tasks_etl where id  = 160003;

INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160003,
	'出款订单',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.FUNDOUT_ORDER_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.FUNDOUT_ORDER_INC
  SELECT *
  FROM fos.tt_fundout_order@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  COMMIT;
  
  
  
  --DELETE /*+   nologging */ FROM  K_TRADE.DWD_FUNDOUT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;

  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_FUNDOUT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 

  INSERT /*+   nologging */ INTO K_TRADE.DWD_FUNDOUT_ORDER_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.FUNDOUT_ORDER_INC t;
	',
    null,
    null,
    null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'出款订单',
	null,
	sysdate
FROM DUAL;

COMMIT;








delete from bipay.bi_daily_tasks_etl where id  = 160004;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160004,
	'出款支付订单',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.FUNDOUT_PAYMENT_ORDER_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.FUNDOUT_PAYMENT_ORDER_INC
  SELECT *
  FROM fos.tt_payment_order@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  
  --DELETE /*+   nologging */ FROM  K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;

  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_FUNDOUT_PAYMENT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 

   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.FUNDOUT_PAYMENT_ORDER_INC t;
	',
    null,
    null,
    null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'出款支付订单',
	null,
	sysdate
FROM DUAL;

COMMIT;









delete from bipay.bi_daily_tasks_etl where id  = 160005;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160005,
	'支付订单',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.PAYMENT_ORDER_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.PAYMENT_ORDER_INC
  SELECT *
  FROM payment.tb_payment_order@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  
  --DELETE /*+   nologging */ FROM  K_TRADE.DWD_PAYMENT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_PAYMENT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 


   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_PAYMENT_ORDER_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.PAYMENT_ORDER_INC t;

	',
    null,
    null,
    null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'支付订单',
	null,
	sysdate
FROM DUAL;

COMMIT;








delete from bipay.bi_daily_tasks_etl where id  = 160006;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160006,
	'支付订单成员',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.PAYMENT_PARTY_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.PAYMENT_PARTY_INC
  SELECT *
  FROM payment.tb_party_payment@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  COMMIT;
  
  --DELETE  /*+   nologging */ FROM  K_TRADE.DWD_PAYMENT_PARTY_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
   
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_PAYMENT_PARTY_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 
   
   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_PAYMENT_PARTY_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.PAYMENT_PARTY_INC t;

	',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'支付订单成员',
	null,
	sysdate
FROM DUAL;

COMMIT;









delete from bipay.bi_daily_tasks_etl where id  = 160007;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160007,
	'交易支付订单支付方式',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.TSS_PAY_METHOD_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.TSS_PAY_METHOD_INC
  SELECT *
  FROM tss.t_pay_method@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  COMMIT;
  
  --DELETE FROM  K_TRADE.DWD_TSS_PAY_METHOD_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
   
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_TSS_PAY_METHOD_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 
   
   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_TSS_PAY_METHOD_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.TSS_PAY_METHOD_INC t;
	',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'DWD_TSS_PAY_METHOD_D',
	null,
	sysdate
FROM DUAL;

COMMIT;













delete from bipay.bi_daily_tasks_etl where id  = 160008;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160008,
	'交易支付订单',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.TSS_PAYMENT_ORDER_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.TSS_PAYMENT_ORDER_INC
  SELECT *
  FROM tss.T_PAYMENT_ORDER@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  COMMIT;
  
  DELETE /*+   nologging */ FROM  K_TRADE.DWD_TSS_PAYMENT_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
   
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_TSS_PAYMENT_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 
   
   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_TSS_PAYMENT_ORDER_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.TSS_PAYMENT_ORDER_INC t;
	',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'DWD_TSS_PAYMENT_ORDER_D',
	null,
	sysdate
FROM DUAL;

COMMIT;














delete from bipay.bi_daily_tasks_etl where id  = 160009;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160009,
	'交易支付费用',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.TSS_TRADE_FEE_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.TSS_TRADE_FEE_INC
  SELECT *
  FROM tss.T_TRADE_FEE@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  
  COMMIT;
  
  --DELETE FROM  K_TRADE.DWD_TSS_TRADE_FEE_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_TSS_TRADE_FEE_D'',last_day(add_months(trunc(sysdate),-2)) +1 ); 	 


   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_TSS_TRADE_FEE_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.TSS_TRADE_FEE_INC t;
	',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'DWD_TSS_TRADE_FEE_D',
	null,
	sysdate
FROM DUAL;

COMMIT;





 

delete from bipay.bi_daily_tasks_etl where id  = 160010;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	160010,
	'交易订单',
	'${email_ok}',
	null,
	'
  TRUNCATE TABLE K_TRADE_ODS.TSS_TRADE_ORDER_INC;
  INSERT /*+ append nologging */ INTO K_TRADE_ODS.TSS_TRADE_ORDER_INC
  SELECT *
  FROM tss.t_trade_order@kjtdb  
  WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  
  COMMIT;
  
  --DELETE FROM  K_TRADE.DWD_TSS_TRADE_ORDER_D WHERE GMT_CREATE >= last_day(add_months(trunc(sysdate),-2)) +1;
  CALL TRUNCATE_PARTITIONS(''K_TRADE'',''DWD_TSS_TRADE_ORDER_D'',last_day(add_months(trunc(sysdate),-2)) +1 );
   
  INSERT /*+   nologging */ INTO K_TRADE.DWD_TSS_TRADE_ORDER_D
  SELECT 
      t.*
      ,sysdate DW_CREATE_TIME
      ,sysdate DW_MODIFIED_TIME
  FROM K_TRADE_ODS.TSS_TRADE_ORDER_INC t;
	',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'DWD_TSS_TRADE_ORDER_D',
	null,
	sysdate
FROM DUAL;

COMMIT;
















delete from bipay.bi_daily_tasks_etl where id  = 161011;


INSERT INTO bipay.bi_daily_tasks_etl
SELECT 
	161011,
	'交易订单',
	'${email_ok}',
	null,
	'CALL TRUNCATE_PARTITIONS(''K_TRADE'',''TEST'',last_day(add_months(trunc(sysdate),-2)) +1 )',
  null,
  null,
  null,
	'DW',
	null,
	null,
	0,
	null,
	1,
	'D',
	'DWD_TSS_TRADE_ORDER_D',
	null,
	sysdate
FROM DUAL;


COMMIT;

