
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
TMP_USER_P2P_INVEST AS (
select
t1.F03 hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount
from bidata.S_S62_T6250 t1
where t1.F07='F' 
and to_char(t1.f06,'yyyymm')='201705'
group by t1.F03 
),
TMP_USER_FUND_INVEST AS (
select
t2.kjt_cust_id kjtid,
count(t2.order_id) fund_order_count,
sum(t2.trans_amt)/100 fund_invest_amount
from funduser.t_fund_share_order@fdb t2
where t2.trans_type='I' 
and t2.status=5 
and to_char(t2.create_time,'yyyymm') ='201705'
group by t2.kjt_cust_id
)

select
sum(T.P2P投资金额) P2P投资金额
,sum(T.基金投资金额) 基金投资金额
from (
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
from TMP_USER T
left join TMP_USER_P2P_INVEST T1
on T.hryid=T1.hryid
left join TMP_USER_FUND_INVEST T2
on T.kjtid=T2.kjtid
where T.created_time < to_date('20170601','yyyymmdd')
) T
;