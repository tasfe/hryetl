---- 截止2017-01-31 P2P历史累计投资用户
select 
count(distinct(t0.F03))
from s_s62_t6250 t0
where t0.F06 < to_date('2017-02-01','yyyy-MM-dd')
;
select 
count(distinct(t0.F03))
from s_s62_t6250 t0
where t0.F06 < to_date('2017-01-01','yyyy-MM-dd')
;
---- 截止2017-01-31 基金历史累计投资用户
select 
count(distinct(t0.kjt_cust_id))
--t1.F01 hryid
from fund.T_FUND_SHARE_ORDER@fdb t0
left join S_S61_T6110 t1
on t0.kjt_cust_id=t1.KJTID
where t1.f01 is not null
and  t0.create_time < to_date('2017-02-01','yyyy-MM-dd')
ORDER BY t0.create_time desc
;
select 
count(distinct(t0.kjt_cust_id))
--t1.F01 hryid
from fund.T_FUND_SHARE_ORDER@fdb t0
left join S_S61_T6110 t1
on t0.kjt_cust_id=t1.KJTID
where t1.f01 is not null
and  t0.create_time < to_date('2017-01-01','yyyy-MM-dd')
ORDER BY t0.create_time desc
;

---- 月内累计P2P交易用户 14907
select 
count(distinct(t0.F03))
from s_s62_t6250 t0
where t0.F06  BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-02-01','yyyy-MM-dd')
;

---- 累计基金交易用户 25662
select 
count(distinct(t0.kjt_cust_id))
--t1.F01 hryid
from fund.T_FUND_SHARE_ORDER@fdb t0
left join S_S61_T6110 t1
on t0.kjt_cust_id=t1.KJTID
where t0.create_time BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-02-01','yyyy-MM-dd')
and t1.f01 is not null
ORDER BY t0.create_time desc
;


---- 新增注册用户
select
count(*)
from S_S61_T6110 t0
where t0.CREATED_TIME BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-02-01','yyyy-MM-dd')
;
select 
count(*)
from member.tr_personal_member@kjtdb t0
where t0.CREATE_TIME BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-02-01','yyyy-MM-dd')
;

----
select 
count(1)
from (
select
t0.F03 hryid,
count(t0.F03)
from bidata.s_s62_t6250 t0
where t0.F06  BETWEEN to_date('2016-11-01','yyyy-MM-dd') and to_date('2017-02-01','yyyy-MM-dd') and t0.f07='F'
group by t0.F03
HAVING count(t0.F03)>1
) T
;


select 
count(1)
from (
select
t0.F03 hryid,
count(t0.F03)
from bidata.s_s62_t6250 t0
where t0.F06  >= to_date('2016-11-01','yyyy-MM-dd') and t0.F06 < to_date('2017-02-01','yyyy-MM-dd') and t0.f07='F'
group by t0.F03
HAVING count(t0.F03)>1
) T
;


