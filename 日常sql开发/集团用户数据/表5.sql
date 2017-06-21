WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME VER_STATE
,t1.kjtid
,t1.CTIME created_time
from bidim.OBJ_HAIR_GROUP_STAFF_PHONE_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
),
TMP_P2P_INVEST AS (
select 
t0.F03 hryid,
count(t0.F01) p2p_order_count,
sum(t0.F05) p2p_invest_amt
from bidata.S_S62_T6250 t0
where t0.F06 < to_date('20170601','yyyymmdd') 
and t0.F07='F'
group by t0.F03
),
TMP_FUND_INVEST AS (
select
t0.f01 hryid,
t0.kjtid,
count(t1.order_id) fund_order_count,
sum(t1.trans_amt)/100 fund_invest_amount
from bidata.s_s61_t6110 t0
left join funduser.t_fund_share_order@fdb t1
on t0.kjtid=t1.kjt_cust_id
where t1.trans_type='I' and t1.status=5 
and t1.create_time < to_date('20170601','yyyymmdd')
group by t0.f01,t0.kjtid
),
TMP_BALANCE AS (
  SELECT * FROM (
  SELECT
  S0.HRYID
  ,S0.TYPE_NAME
  ,S0.AFTER_AMT
  FROM DW_USER_ACCT_BAL S0
  WHERE S0.START_DATE<= TO_DATE('20170601','YYYYMMDD') AND S0.END_DATE>TO_DATE('20170601','YYYYMMDD')
  ) PIVOT (MAX(AFTER_AMT) FOR TYPE_NAME IN ('P2P' AS P2P,'BAL' PAY_BALANCE,'TTJ' AS TTJ))
)

--select
--sum(T.""被推荐人P2P投资金额"") P2P投资金额,
--sum(T.""被推荐人基金投资金额"") 基金投资金额,
--sum(T.""被推荐人总投资金额"") 总投资金额
--from (
select 
T1.hryid 海融易id,
T1.sjhm 办公手机号码,
T1.PROMOTED_ID 被推荐人海融易id,
T4.MOBILE 被推荐人手机号,
T1.promoted_type 被推荐人类型,
to_char(T4.reg_time,'yyyymmdd hh24:mi:ss') 被推荐人注册时间,
decode(T4.AUTHENT_STATUS,'TG','Y','N') 认证状态,
T2.P2P_ORDER_COUNT 被推荐人P2P投资次数,
T2.P2P_INVEST_AMT 被推荐人P2P投资金额,
T3.fund_order_count 被推荐人基金投资次数,
T3.fund_invest_amount 被推荐人基金投资金额,
T3.fund_order_count+T2.P2P_ORDER_COUNT 被推荐人总投资次数,
T3.fund_invest_amount+T2.P2P_INVEST_AMT 被推荐人总投资金额
,T5.P2P 持有P2P资产
,T5.TTJ 天天聚可用余额
,T5.PAY_BALANCE 支付账户可用余额
from (
select 
t0.PROMOTED_ID 
,t0.PROMOTER_ID hryid
,t1.STAFF_PHONE SJHM
,(case when t2.hryid is not null then '集团员工' else '非集团员工'  end) promoted_type
from bidata.S_PROMO_PROMOTION_RELATION t0
inner join TMP_USER t1
on t0.PROMOTER_ID=t1.HRYID
LEFT JOIN TMP_USER t2
on t0.PROMOTED_ID=t2.hryid
where t0.created_time <to_date('20170601','yyyymmdd')
) T1
left join TMP_P2P_INVEST T2
on T1.PROMOTED_ID=T2.hryid
left join TMP_FUND_INVEST T3
on T1.PROMOTED_ID=T3.hryid
left join bidata.dim_user_hry_users T4
on T1.PROMOTED_ID=T4.hryid
LEFT JOIN TMP_BALANCE t5
ON t1.PROMOTED_ID=t5.HRYID
order by T1.hryid
--where T4.ctime<to_date('20170501','yyyymmdd') 
--and T4.CTIME>=to_date('20170401','yyyymmdd')
--) T
--where T.""被推荐人总投资次数"">0"