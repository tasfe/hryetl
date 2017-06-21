WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME VER_STATE
,t1.kjtid
,t1.CTIME created_time
from bidim.OBJ_SHUNGUANG_HRY_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
),
TMP_staff_USER AS (
select
t1.HRYID hryid
from bidim.obj_hair_group_staff_phone_m5 t0
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
where to_char(t0.F06,'yyyymm')='201705'
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
and to_char(t1.create_time,'yyyymm')='201705'
group by t0.f01,t0.kjtid
)

select
T.被推荐人类型
,count（T.PROMOTED_ID)
from (
select 
T1.hryid 海融易id,
T1.sjhm 办公手机号码,
T1.PROMOTED_ID ,
T4.MOBILE 被推荐人手机号,
T1.promoted_type 被推荐人类型,
T4.ctime 被推荐人注册时间,
decode(T4.AUTHENT_STATUS,'TG','Y','N') 认证状态,
t5.F10 被推荐人认证时间,
T2.P2P_ORDER_COUNT 被推荐人P2P投资次数,
T2.P2P_INVEST_AMT 被推荐人P2P投资金额,
T3.fund_order_count 被推荐人基金投资次数,
T3.fund_invest_amount 被推荐人基金投资金额,
T3.fund_order_count+T2.P2P_ORDER_COUNT 被推荐人总投资次数,
T3.fund_invest_amount+T2.P2P_INVEST_AMT 被推荐人总投资金额
from (
select 
t0.PROMOTED_ID 
,t0.PROMOTER_ID hryid
,t1.STAFF_PHONE SJHM
,(case when t2.hryid is not null then '集团员工' else '非集团员工'  end) promoted_type
from bidata.S_PROMO_PROMOTION_RELATION t0
inner join TMP_USER t1
on t0.PROMOTER_ID=t1.HRYID
LEFT JOIN TMP_staff_USER t2
on t0.PROMOTED_ID=t2.hryid
where t0.created_time <to_date('20170601','yyyymmdd')
) T1
left join TMP_P2P_INVEST T2
on T1.PROMOTED_ID=T2.hryid
left join TMP_FUND_INVEST T3
on T1.PROMOTED_ID=T3.hryid
left join bidata.dim_user_hry_users T4
on T1.PROMOTED_ID=T4.hryid
left join bidata.s_s61_t6141 t5
on T1.PROMOTED_ID=t5.f01
order by T1.hryid
) T
--where to_char(T.被推荐人注册时间,'yyyymm')='201705'
where to_char(T.被推荐人认证时间,'yyyymm')='201705'
group by T.被推荐人类型
;