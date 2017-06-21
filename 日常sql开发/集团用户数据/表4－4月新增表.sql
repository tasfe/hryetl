
WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME VER_STATE
,t1.kjtid
,t1.CTIME created_time
from bidim.obj_hair_group_staff_phone t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170501','yyyymmdd')
)
select
T.hryid 海融易id,
--T.kjtid 绑定快捷通id,
T.STAFF_PHONE 办公手机号码,
to_char(T.created_time, 'yyyymmdd') 用户创建时间,
--T.VER_STATE 认证状态,
S0.DATE_KEY 首投日期,
T1.p2p_order_count P2P投资次数,
T1.p2p_invest_amount P2P投资金额,
T2.fund_order_count 基金投资次数,
T2.fund_invest_amount 基金投资金额
from TMP_USER T
LEFT JOIN BIDATA.DM_USER_ORDER_FIRST S0
ON T.HRYID=S0.HRYID
left join (
select
t1.F03 hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount
from bidata.S_S62_T6250 t1
where t1.F07='F' and t1.f06 < to_date('20170501','yyyymmdd')
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
and t2.create_time < to_date('20170501','yyyymmdd')
group by t2.kjt_cust_id) T2
on T.kjtid=T2.kjtid
where T.created_time < to_date('20170501','yyyymmdd')
order by T.created_time desc
;