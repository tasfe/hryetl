ALTER TABLE K_TRADE.DWD_TRADE_DETAIL_D TRUNCATE SUBPARTITION P201705_TSS



SELECT * FROM K_TRADE.DWD_TRADE_DETAIL_D subpartition(P201705_TSS ) 
 
TRUNCATE TABLE K_TRADE.DWD_TRADE_DETAIL_D 

DESC K_TRADE.DWD_TRADE_DETAIL_D

INSERT INTO "K_TRADE"."DWD_TRADE_DETAIL_D" 
SELECT  
     TRADE_VOUCHER_NO      
    ,PAYMENT_VOUCHER_NO    
    ,PAYMENT_SEQ_NO        
    ,'TSS' TRADE_SOURCE          
    ,TRADE_TYPE      
    ,DECODE(TRADE_TYPE, 
        '01', '普通转账交易', 
        '11', '即时到账收单交易', 
        '12', '担保收单交易', 
        '13', '下订收单交易', 
        '14', '收单退款交易', 
        '15', '合并支付', 
        '16', '话费充值', 
        '17', '银行卡代扣交易', 
        '18', '基金份额交易', TRADE_TYPE) AS TRADE_TYPE_DESC
    ,tss_payment.PAYMENT_TYPE TRADE_PAYMENT_TYPE    
    ,BIZ_PRODUCT_CODE      
    ,BIZ_PRODUCT_CODE_DESC 
    ,PRODUCT_CODE          
    ,AMOUNT                
    ,TRADE_FEE             
    ,ACCESS_CHANNEL        
    ,BUYER_ID MEMBER_ID             
    ,NULL ACCOUNT_NO            
    ,BANK_CODE BANK_CODE              
    ,TRADE_STATUS  ORI_TRADE_STATUS        
    ,TRADE_PAYMENT_STATUS ORI_TRADE_PAYMENT_STATUS  
    ,TRADE_STATUS TRADE_STATUS          
    ,TRADE_PAYMENT_STATUS TRADE_PAYMENT_STATUS    
    ,PAY_MODE              
    ,PAY_MODE_DESC         
    ,PAY_CHANNEL           
    ,payment_order.PAYMENT_TYPE          
    ,PAYMENT_CODE          
    ,SELLER_ID PAYEE_MEMBER_ID       
    ,SELLER_MEMBER_TYPE PAYEE_MEMBER_TYPE     
    ,NULL PAYEE_ACCOUNT_NO      
    ,NULL PAYEE_ACCOUNT_TYPE    
    ,NULL PAYEE_BANK_CODE       
    ,NULL PAYEE_BANK_ACCOUNT_NO 
    ,NULL PAYEE_FEE             
    ,BUYER_ID PAYER_MEMBER_ID       
    ,BUYER_MEMBER_TYPE PAYER_MEMBER_TYPE     
    ,NULL PAYER_ACCOUNT_NO      
    ,NULL PAYER_ACCOUNT_TYPE    
    ,BANK_CODE PAYER_BANK_CODE       
    ,NULL PAYER_BANK_ACCOUNT_NO 
    ,TRADE_FEE PAYER_FEE  
  
  
    ,channel.CMF_SEQ_NO
    ,channel.CMF_ORDER_STATUS  
    ,channel.INST_ORDER_NO 
    ,channel.INST_ORDER_STATUS
    ,channel.FUND_CHANNEL_CODE
    ,channel.FUND_CHANNEL_NAME
    ,channel.CHANNEL_ORDER_TYPE
    ,channel.REAL_PAY_MODE    
    
    ,CASE 
          WHEN TRADE_TYPE = '14' THEN '退款'
          WHEN TRADE_TYPE = '01' THEN
            CASE
              WHEN BUYER_MEMBER_TYPE <> 1 THEN '绩效付款'
              WHEN SELLER_MEMBER_TYPE <> 1 THEN '绩效收款'
              ELSE '会员交易'
            END
          ELSE 
            CASE 
              WHEN SELLER_MEMBER_TYPE <> 1 THEN '绩效收款'
              ELSE '会员交易'
            END
        END Accounting_TYPE
        
        
    ,CASE 
          WHEN TRADE_TYPE = '14' THEN  SELLER_ID
          WHEN TRADE_TYPE = '01' THEN
            CASE
              WHEN BUYER_MEMBER_TYPE <> 1 THEN BUYER_ID
              WHEN SELLER_MEMBER_TYPE <> 1 THEN SELLER_ID
            END
          ELSE 
            CASE 
              WHEN SELLER_MEMBER_TYPE <> 1 THEN SELLER_ID
            END
        END Accounting_OWNER_ID 
        
    ,TRADE_GMT_CREATE      
    ,TRADE_PAYMENT_GMT_CREATE
    ,PAYMENT_GMT_CREATE    
    ,CMF_GMT_CREATE  


    
    ,sysdate DW_CREATE_TIME        
    ,sysdate DW_MODIFIED_TIME    
FROM   
 (SELECT 
           d.TRADE_VOUCHER_NO  TRADE_VOUCHER_NO
          ,d.BIZ_PRODUCT_CODE  BIZ_PRODUCT_CODE
          ,d.BUYER_ID
          ,buyer.MEMBER_TYPE BUYER_MEMBER_TYPE
          ,d.SELLER_ID
          ,seller.MEMBER_TYPE SELLER_MEMBER_TYPE
          ,d.SELLER_ACCOUNT_NO
          ,d.TRADE_TYPE
          ,c.PRODUCT_CODE PRODUCT_CODE
          ,c.MEMO BIZ_PRODUCT_CODE_DESC
          ,d.TRADE_AMOUNT  AMOUNT
          ,d.ACCESS_CHANNEL ACCESS_CHANNEL
          ,d.STATUS  TRADE_STATUS
          ,d.GMT_SUBMIT TRADE_GMT_CREATE
          --,regexp_replace( regexp_substr(upper(d.EXTENSION),'"BANK_CODE":"[[:alnum:]]+',1,1),'"BANK_CODE":"') BANK_CODE
       FROM K_TRADE.DWD_TSS_TRADE_ORDER_D d 
        LEFT OUTER JOIN K_LKP.BUSINESS_PRODUCT_CODE c
          ON d.BIZ_PRODUCT_CODE = c.BIZ_PRODUCT_CODE
        LEFT OUTER JOIN K_USER.DIM_USER SELLER
         on d.SELLER_ID = SELLER.member_id
        LEFT OUTER JOIN K_USER.DIM_USER BUYER
         on d.BUYER_ID = BUYER.member_id 
       WHERE 1=1
         AND d.GMT_CREATE >= to_date('20170101','YYYYMMDD'）  
        --AND trade_voucher_no = '101149585862169832278'
        --and d.BIZ_PRODUCT_CODE = '20402'        
        --SELECT * FROM K_TRADE.DWD_TSS_TRADE_ORDER_D d WHERE  BIZ_PRODUCT_CODE = '20201'
    ) tss_order
LEFT OUTER JOIN 
      (
        SELECT 
                   d.PAYMENT_VOUCHER_NO  
                  ,d.TRADE_VOUCHER_NO TRADE_VOUCHER_NO_P
                  ,d.PAYMENT_TYPE
                  --,d.PRODUCT_CODE  
                  --,d.MEMBER_ID   
                  --,d.ACCOUNT_NO   
                  --,d.AMOUNT  
                  ,NULL  TRADE_FEE
                  --,d.BANK_CODE  
                  --,d.CARD_NO
                  --,d.PAY_CHANNEL  
                  --,d.PAYMENT_STATUS  TRADE_PAYMENT_STATUS
                  --,m.pay_mode  tss_pay_mode
                  --,regexp_replace( regexp_substr(upper(m.props),'"BANKCODE":"[[:alnum:]]+',1,1),'"BANKCODE":"') BANK_CODE
                  --,BANK_CODE
                  ,d.STATUS  TRADE_PAYMENT_STATUS
                  ,d.GMT_CREATE TRADE_PAYMENT_GMT_CREATE
               FROM K_TRADE.DWD_TSS_PAYMENT_ORDER_D d 
                WHERE d.GMT_CREATE >= to_date('20170101','YYYYMMDD'）  
                  
        
      --select * from K_TRADE.DWD_TSS_PAYMENT_ORDER_D where trade_voucher_no = '103148419327469730231'
      ) tss_payment
    ON tss_order.TRADE_VOUCHER_NO = tss_payment.TRADE_VOUCHER_NO_P
LEFT OUTER JOIN 
      (SELECT   
            d.PAYMENT_SEQ_NO
           ,d.PAYMENT_TYPE
           ,d.PAYMENT_CODE
           ,d.PAYMENT_ORDER_NO
           ,d.PAY_MODE
           ,c.REMARK PAY_MODE_DESC
           ,d.PAY_CHANNEL 
           ,d.GMT_CREATE PAYMENT_GMT_CREATE
           ,m.BANK_CODE
        FROM K_TRADE.DWD_PAYMENT_ORDER_D  d
          LEFT OUTER JOIN k_lkp.pay_mode c
            ON d.PAY_MODE = c.PAY_MODE
          LEFT OUTER JOIN 
            (SELECT 
               PAYMENT_VOUCHER_NO
              ,PAY_MODE
              ,regexp_replace( regexp_substr(upper( props),'"BANKCODE":"[[:alnum:]]+',1,1),'"BANKCODE":"' ) BANK_CODE
             FROM K_TRADE.DWD_TSS_PAY_METHOD_D 
              WHERE  GMT_CREATE >= to_date('20170101','YYYYMMDD')
             ) m
            on d.PAYMENT_ORDER_NO = m.PAYMENT_VOUCHER_NO
             and d.PAY_MODE = m.PAY_MODE
        --WHERE d.GMT_CREATE >= to_date('20170501','YYYYMMDD') 
      )payment_order
    ON tss_payment.PAYMENT_VOUCHER_NO = payment_order.PAYMENT_ORDER_NO        
 

LEFT OUTER JOIN 
 (
  SELECT 
     PAYMENT_SEQ_NO CHANNEL_PAYMENT_SEQ_NO
    ,CMF_SEQ_NO
    , CMF_ORDER_STATUS  
    , INST_ORDER_NO 
    , INST_ORDER_STATUS
    , FUND_CHANNEL_CODE
    , FUND_CHANNEL_NAME
    , ORDER_TYPE CHANNEL_ORDER_TYPE
    , REAL_PAY_MODE REAL_PAY_MODE  
    ,GMT_CREATE CMF_GMT_CREATE
  FROM K_CHANNEL.DWD_FUND_CHANNEL_ORDER_D 
  WHERE  GMT_CREATE >= to_date('20170101','YYYYMMDD')
 ) channel
on payment_order.PAYMENT_SEQ_NO = channel.CHANNEL_PAYMENT_SEQ_NO;

COMMIT;




 
INSERT INTO "K_TRADE"."DWD_TRADE_DETAIL_D" 
SELECT  
     TRADE_VOUCHER_NO      
    ,PAYMENT_VOUCHER_NO    
    ,PAYMENT_SEQ_NO        
    ,'FOS' TRADE_SOURCE          
    ,'提现' TRADE_TYPE 
    ,NULL TRADE_TYPE_DESC
    ,NULL TRADE_PAYMENT_TYPE    
    ,BIZ_PRODUCT_CODE      
    ,BIZ_PRODUCT_CODE_DESC 
    ,PRODUCT_CODE          
    ,AMOUNT                
    ,TRADE_FEE             
    ,ACCESS_CHANNEL        
    ,MEMBER_ID             
    ,ACCOUNT_NO            
    ,BANK_CODE        
    ,TRADE_STATUS ORI_TRADE_STATUS          
    ,TRADE_PAYMENT_STATUS ORI_TRADE_PAYMENT_STATUS      
    ,CASE 
      WHEN TRADE_STATUS = 'bankSuccess'  then 'S'    
      --WHEN TRADE_STATUS = 'bankSuccess'  then 'S' 
      ELSE 'F' 
     END TRADE_STATUS          
    ,CASE 
      WHEN TRADE_PAYMENT_STATUS = 'bankSuccess'  then 'S'    
      --WHEN TRADE_STATUS = 'bankSuccess'  then 'S' 
      ELSE 'F' 
     END TRADE_PAYMENT_STATUS  
    ,PAY_MODE              
    ,PAY_MODE_DESC         
    ,PAY_CHANNEL           
    ,PAYMENT_TYPE          
    ,PAYMENT_CODE          
    ,NULL PAYEE_MEMBER_ID       
    ,NULL PAYEE_MEMBER_TYPE     
    ,NULL PAYEE_ACCOUNT_NO      
    ,NULL PAYEE_ACCOUNT_TYPE    
    ,BANK_CODE PAYEE_BANK_CODE       
    ,CARD_NO PAYEE_BANK_ACCOUNT_NO 
    ,NULL PAYEE_FEE             
    ,MEMBER_ID PAYER_MEMBER_ID       
    ,MEMBER_TYPE PAYER_MEMBER_TYPE     
    ,ACCOUNT_NO PAYER_ACCOUNT_NO      
    ,NULL PAYER_ACCOUNT_TYPE    
    ,NULL PAYER_BANK_CODE       
    ,NULL PAYER_BANK_ACCOUNT_NO 
    ,TRADE_FEE PAYER_FEE     
    
    ,channel.CMF_SEQ_NO
    ,channel.CMF_ORDER_STATUS  
    ,channel.INST_ORDER_NO 
    ,channel.INST_ORDER_STATUS
    ,channel.FUND_CHANNEL_CODE
    ,channel.FUND_CHANNEL_NAME
    ,channel.CHANNEL_ORDER_TYPE
    ,channel.REAL_PAY_MODE        
    
    ,'提现' Accounting_TYPE
    ,MEMBER_ID Accounting_OWNER_ID          
    ,TRADE_GMT_CREATE      
    ,TRADE_PAYMENT_GMT_CREATE
    ,PAYMENT_GMT_CREATE  
    ,CMF_GMT_CREATE  

    ,sysdate DW_CREATE_TIME        
    ,sysdate DW_MODIFIED_TIME       
FROM   
 (SELECT 
           d.FUNDOUT_ORDER_NO  TRADE_VOUCHER_NO
          ,d.PRODUCT_CODE  BIZ_PRODUCT_CODE
          ,c.PRODUCT_CODE PRODUCT_CODE
          ,c.MEMO BIZ_PRODUCT_CODE_DESC
          --,d.AMOUNT  AMOUNT
          --,d.ACCESS_CHANNEL ACCESS_CHANNEL
          ,NULL ACCESS_CHANNEL
          ,d.STATUS  TRADE_STATUS
          ,d.GMT_CREATE TRADE_GMT_CREATE
       FROM K_TRADE.DWD_FUNDOUT_ORDER_D d 
        LEFT OUTER JOIN K_LKP.BUSINESS_PRODUCT_CODE c
          ON d.PRODUCT_CODE = c.BIZ_PRODUCT_CODE
        WHERE d.GMT_CREATE >= to_date('20170501','YYYYMMDD'）
    ) fos_order
LEFT OUTER JOIN 
      (
      SELECT 
           d.PAYMENT_ORDER_NO  PAYMENT_VOUCHER_NO
          ,d.FUNDOUT_ORDER_NO TRADE_VOUCHER_NO_P
          --,d.PRODUCT_CODE  
          ,d.MEMBER_ID   
          ,u.MEMBER_TYPE
          ,d.ACCOUNT_NO   
          ,d.AMOUNT  
          ,d.FEE  TRADE_FEE
          ,d.BANK_CODE  
          ,d.CARD_NO
          --,d.PAY_CHANNEL  
          ,d.STATUS  TRADE_PAYMENT_STATUS
          ,d.GMT_CREATE TRADE_PAYMENT_GMT_CREATE
       FROM K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D d 
        LEFT OUTER JOIN K_USER.DIM_USER u
           on d.MEMBER_ID = u.member_id

        WHERE d.GMT_CREATE >= to_date('20170501','YYYYMMDD'）  
 
      ) fos_payment
    ON fos_order.TRADE_VOUCHER_NO = fos_payment.TRADE_VOUCHER_NO_P

LEFT OUTER JOIN 
      (SELECT   
            d.PAYMENT_SEQ_NO
           ,d.PAYMENT_TYPE
           ,d.PAYMENT_CODE
           ,d.PAYMENT_ORDER_NO
           ,d.PAY_MODE
           ,c.REMARK PAY_MODE_DESC
           ,d.PAY_CHANNEL 
           ,d.GMT_CREATE PAYMENT_GMT_CREATE
        FROM K_TRADE.DWD_PAYMENT_ORDER_D  d
          LEFT OUTER JOIN k_lkp.pay_mode c
            ON d.PAY_MODE = c.PAY_MODE
         WHERE d.GMT_CREATE >= to_date('20170501','YYYYMMDD') 
      )payment_order
    ON fos_payment.PAYMENT_VOUCHER_NO = payment_order.PAYMENT_ORDER_NO        
 
LEFT OUTER JOIN 
 (
  SELECT 
     PAYMENT_SEQ_NO CHANNEL_PAYMENT_SEQ_NO
    ,CMF_SEQ_NO
    , CMF_ORDER_STATUS  
    , INST_ORDER_NO 
    , INST_ORDER_STATUS
    , FUND_CHANNEL_CODE
    , FUND_CHANNEL_NAME
    , ORDER_TYPE CHANNEL_ORDER_TYPE
    , REAL_PAY_MODE REAL_PAY_MODE  
    ,GMT_CREATE CMF_GMT_CREATE
  FROM K_CHANNEL.DWD_FUND_CHANNEL_ORDER_D 
  WHERE  GMT_CREATE >= to_date('20170101','YYYYMMDD')
 ) channel
on payment_order.PAYMENT_SEQ_NO = channel.CHANNEL_PAYMENT_SEQ_NO;

COMMIT;



INSERT INTO "K_TRADE"."DWD_TRADE_DETAIL_D" 
SELECT  
     TRADE_VOUCHER_NO      
    ,PAYMENT_VOUCHER_NO    
    ,PAYMENT_SEQ_NO        
    ,'DEPOSIT' TRADE_SOURCE          
    ,'充值' TRADE_TYPE 
    ,NULL TRADE_TYPE_DESC
    ,NULL TRADE_PAYMENT_TYPE    
    ,BIZ_PRODUCT_CODE      
    ,BIZ_PRODUCT_CODE_DESC 
    ,PRODUCT_CODE          
    ,AMOUNT                
    ,TRADE_FEE             
    ,ACCESS_CHANNEL        
    ,MEMBER_ID             
    ,ACCOUNT_NO            
    ,CASE WHEN UPPER(PAY_MODE) in ('ONLINE_BANK','QPAY') THEN BANK_CODE ELSE null END  BANK_CODE  
    ,TRADE_STATUS ORI_TRADE_STATUS          
    ,TRADE_PAYMENT_STATUS ORI_TRADE_PAYMENT_STATUS      
    ,TRADE_STATUS TRADE_STATUS          
    ,TRADE_PAYMENT_STATUS TRADE_PAYMENT_STATUS  
    ,PAY_MODE              
    ,PAY_MODE_DESC         
    ,PAY_CHANNEL           
    ,PAYMENT_TYPE          
    ,PAYMENT_CODE          
    ,MEMBER_ID PAYEE_MEMBER_ID       
    ,MEMBER_TYPE PAYEE_MEMBER_TYPE     
    ,ACCOUNT_NO PAYEE_ACCOUNT_NO      
    ,NULL PAYEE_ACCOUNT_TYPE    
    ,NULL PAYEE_BANK_CODE       
    ,NULL PAYEE_BANK_ACCOUNT_NO 
    ,TRADE_FEE PAYEE_FEE             
    ,NULL PAYER_MEMBER_ID       
    ,NULL PAYER_MEMBER_TYPE     
    ,NULL PAYER_ACCOUNT_NO      
    ,NULL PAYER_ACCOUNT_TYPE    
    ,CASE WHEN UPPER(PAY_MODE) in ('ONLINE_BANK','QPAY') THEN BANK_CODE ELSE null END PAYER_BANK_CODE       
    ,NULL PAYER_BANK_ACCOUNT_NO 
    ,NULL PAYER_FEE         
    
    ,channel.CMF_SEQ_NO
    ,channel.CMF_ORDER_STATUS  
    ,channel.INST_ORDER_NO 
    ,channel.INST_ORDER_STATUS
    ,channel.FUND_CHANNEL_CODE
    ,channel.FUND_CHANNEL_NAME
    ,channel.CHANNEL_ORDER_TYPE
    ,channel.REAL_PAY_MODE        
    
    ,'充值' Accounting_TYPE
    ,MEMBER_ID Accounting_OWNER_ID    
    
    ,TRADE_GMT_CREATE      
    ,TRADE_PAYMENT_GMT_CREATE
    ,PAYMENT_GMT_CREATE    
    ,CMF_GMT_CREATE
    ,sysdate DW_CREATE_TIME        
    ,sysdate DW_MODIFIED_TIME   
 FROM
 (SELECT 
           d.TRADE_VOUCHER_NO  TRADE_VOUCHER_NO
          ,d.BIZ_PRODUCT_CODE  BIZ_PRODUCT_CODE
          ,c.PRODUCT_CODE PRODUCT_CODE
          ,c.MEMO BIZ_PRODUCT_CODE_DESC
          ,d.AMOUNT  AMOUNT
          ,d.ACCESS_CHANNEL ACCESS_CHANNEL
          ,d.TRADE_STATUS  TRADE_STATUS
          ,d.GMT_CREATE TRADE_GMT_CREATE
       FROM K_TRADE.DWD_DEPOSIT_ORDER_D d 
       LEFT OUTER JOIN K_LKP.BUSINESS_PRODUCT_CODE c
          ON d.BIZ_PRODUCT_CODE = c.BIZ_PRODUCT_CODE
        WHERE d.GMT_CREATE >= to_date('20170101','YYYYMMDD'）
    ) deposit_order

LEFT OUTER JOIN 
      (
      SELECT 
           d.PAYMENT_VOUCHER_NO  PAYMENT_VOUCHER_NO
          ,d.TRADE_VOUCHER_NO TRADE_VOUCHER_NO_P
          --,PRODUCT_CODE  
          ,d.MEMBER_ID   
          ,u.MEMBER_TYPE
          ,d.ACCOUNT_NO   
          --,AMOUNT  
          ,d.FEE  TRADE_FEE
          ,d.PAY_MODE  
          ,c.REMARK PAY_MODE_DESC
          ,d.PAY_CHANNEL  
          ,d.PAYMENT_STATUS  TRADE_PAYMENT_STATUS
          --,EXT
          ,regexp_replace( regexp_substr(d.EXT,'"BANK_CODE":"[[:alnum:]]+',1,1),'"BANK_CODE":"') BANK_CODE
          ,d.GMT_CREATE TRADE_PAYMENT_GMT_CREATE
          --,d.ACCESS_CHANNEL TRADE_PAYMENT_ACCESS_CHANNEL
       FROM K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D d 
       LEFT OUTER JOIN K_USER.DIM_USER u
         on d.MEMBER_ID = u.member_id
       LEFT OUTER JOIN k_lkp.pay_mode c
            ON d.PAY_MODE = c.PAY_MODE
        WHERE d.GMT_CREATE >= to_date('20170101','YYYYMMDD'）  
 
      ) deposit_payment
    ON deposit_order.TRADE_VOUCHER_NO = deposit_payment.TRADE_VOUCHER_NO_P

LEFT OUTER JOIN 
      (SELECT   
            PAYMENT_SEQ_NO
           ,PAYMENT_TYPE
           ,PAYMENT_CODE
           ,PAYMENT_ORDER_NO
           --,PAY_MODE
           --,PAY_CHANNEL 
           ,GMT_CREATE PAYMENT_GMT_CREATE
        FROM K_TRADE.DWD_PAYMENT_ORDER_D  
         WHERE GMT_CREATE >= to_date('20170101','YYYYMMDD') 
      )payment_order
    ON deposit_payment.PAYMENT_VOUCHER_NO = payment_order.PAYMENT_ORDER_NO    


LEFT OUTER JOIN 
 (
  SELECT 
     PAYMENT_SEQ_NO CHANNEL_PAYMENT_SEQ_NO
    ,CMF_SEQ_NO
    , CMF_ORDER_STATUS  
    , INST_ORDER_NO 
    , INST_ORDER_STATUS
    , FUND_CHANNEL_CODE
    , FUND_CHANNEL_NAME
    , ORDER_TYPE CHANNEL_ORDER_TYPE
    , REAL_PAY_MODE REAL_PAY_MODE  
    ,GMT_CREATE CMF_GMT_CREATE
  FROM K_CHANNEL.DWD_FUND_CHANNEL_ORDER_D 
  WHERE  GMT_CREATE >= to_date('20170101','YYYYMMDD')
 ) channel
on payment_order.PAYMENT_SEQ_NO = channel.CHANNEL_PAYMENT_SEQ_NO;

COMMIT;

 


  







