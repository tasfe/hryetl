
------------------ 2月份基金投资
select
'基金' AS 业务线,
sum(t0.trans_amt)/100 金额
from funduser.T_FUND_SHARE_ORDER@fdb t0
where t0.trans_type='I' AND t0.status=5
AND t0.create_time >= to_date('2017-02-01','yyyy-mm-dd') AND t0.create_time < to_date('2017-03-01','yyyy-mm-dd')
UNION ALL
------------------2月份P2P 业务线投资金额
select
T.b_category 业务线,
sum(T.amt) 金额
from (
select 
t0.f03 hryid,
t1.CATEGORY_DISPLAY_NAME b_category,
t0.f05 amt,
t0.f06 invest_time
from  bidata.S_S62_T6250 t0
left join bidata.V_BID_CATEGORY t1
on t0.f02=t1.bid
where t0.F07='F'
) T
where T.invest_time >= to_date('2017-02-01','yyyy-mm-dd') AND T.invest_time < to_date('2017-03-01','yyyy-mm-dd') 
group by T.b_category
;

----------- 月度交易用户
select
count(distinct(t0.KJTID))
from bidata.bi_user_exchange t0
where t0.rptdt between '20170201' and '20170228'
;

------------ 活跃用户
select
count(*) 活跃用户数
from (
select
T.kjtid,
count(*)
from (
select
--t0.f01 订单id,
t1.kjtid kjtid
from bidata.s_s62_t6250 t0
left join bidata.s_s61_t6110 t1
on t0.f03=t1.f01
where t0.F07='F' and t0.f06 >= to_date('20161201','yyyymmdd') and t0.f06<to_date('20170301','yyyymmdd')

UNION ALL

select
--t0.order_id 订单id,
--t0.trans_amt,
t0.kjt_cust_id kjtid
--to_char(t0.create_time,'yyyymmdd hh24:mi:ss') invest_time
from funduser.T_FUND_SHARE_ORDER@fdb t0
left join bidata.s_s61_t6110 t1
on t0.kjt_cust_id=t1.kjtid
where t0.trans_type='I' AND t0.status=5
AND t0.create_time >= to_date('20161201','yyyymmdd') AND t0.create_time < to_date('20170301','yyyymmdd')

UNION ALL

select
t1.member_id kjtid
from dpm.t_dpm_outer_account_sub_detail@kjtdb t0
left join member.tr_member_account@kjtdb t1
on t0.account_no=t1.account_id
where t0.fund_type=1 and t0.balance_type=1 
AND t0.create_time >= to_date('20161201','yyyymmdd') AND t0.create_time < to_date('20170301','yyyymmdd')
) T
group by T.kjtid
HAVING count(*)>1
order by count(*) asc
) TT
;



select
*
from member.tr_member_account@kjtdb
;

------------ 集团内交易流水
select
sum(T.p2p)/10000 p2p_amt,
sum(T.fund)/10000 fund_amd
from (
select
tt0.hryid,
tt1.amt p2p,
tt2.amt fund
from bidata.v_hry_staff tt0
LEFT join (
 select
t0.f03 hryid,
sum(t0.f05) amt
from bidata.s_s62_t6250 t0
where t0.F07='F' and t0.f06 >= to_date('20170201','yyyymmdd') and t0.f06<to_date('20170301','yyyymmdd')
group by t0.f03
) tt1
on tt0.HRYID=tt1.hryid
left join (
select
t0.kjt_cust_id kjtid,
sum(t0.trans_amt)/100 amt
from funduser.T_FUND_SHARE_ORDER@fdb t0
where t0.trans_type='I' AND t0.status=5
AND t0.create_time >= to_date('2017-02-01','yyyy-mm-dd') AND t0.create_time < to_date('2017-03-01','yyyy-mm-dd')
group by t0.kjt_cust_id
) tt2
on tt0.kjtid=tt2.kjtid
) T
;



-----
select
count(*)
from (
select
T.kjtid,
count(*)
from (
select
t1.kjtid
from bidata.s_s62_t6250 t0
left join bidata.s_s61_t6110 t1
on t0.f03=t1.f01
where t0.F07='F' and t0.f06 >= to_date('20161201','yyyymmdd') and t0.f06<to_date('20170301','yyyymmdd')
) T
group BY T.kjtid
having count(*)>1
)
;
