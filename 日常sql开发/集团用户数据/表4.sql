
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
)
select
T.hryid 海融易id,
--T.kjtid 绑定快捷通id,
--T.STAFF_PHONE 办公手机号码,
--T.VER_STATE 认证状态,
--to_char(T.created_time, 'yyyymmdd') 用户创建时间,
T1.p2p_order_count P2P投资次数,
T1.p2p_invest_amount P2P投资金额,
T2.fund_order_count 基金投资次数,
T2.fund_invest_amount 基金投资金额
,T3.P2P 持有P2P资产
,T3.TTJ 天天聚可用余额
,T3.PAY_BALANCE 支付账户可用余额
from TMP_USER T
left join (
select
t1.F03 hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount
from bidata.S_S62_T6250 t1
where t1.F07='F' and t1.f06 < to_date('20170601','yyyymmdd')
group by t1.F03 ) T1
on T.hryid=T1.hryid
left join (
select
t2.kjt_cust_id kjtid,
count(t2.order_id) fund_order_count,
sum(t2.trans_amt)/100 fund_invest_amount
from funduser.t_fund_share_order@fdb t2
where t2.trans_type='I' 
and t2.status=5 
and t2.create_time < to_date('20170601','yyyymmdd')
group by t2.kjt_cust_id) T2
on T.kjtid=T2.kjtid
LEFT JOIN (
  SELECT * FROM (
  SELECT
  S0.HRYID
  ,S0.TYPE_NAME
  ,S0.AFTER_AMT
  FROM DW_USER_ACCT_BAL S0
  WHERE S0.START_DATE<= TO_DATE('20170601','YYYYMMDD') AND S0.END_DATE>TO_DATE('20170601','YYYYMMDD')
  ) PIVOT (MAX(AFTER_AMT) FOR TYPE_NAME IN ('P2P' AS P2P,'BAL' PAY_BALANCE,'TTJ' AS TTJ))
) T3
ON T.hryid=T3.HRYID
where T.created_time < to_date('20170601','yyyymmdd')

;