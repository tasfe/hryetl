with TMP_20170303_NO_INVEST_CHECK AS (select
t1.f01 hryid
,t0.sjhm STAFF_PHONE
from wdh.ls_sjhm@kjtdb t0
inner join bidata.s_s61_t6110  t1
on t0.sjhm=t1.f02 or t0.sjhm=t1.f04
where t1.CREATED_TIME < to_date('20170401','yyyymmdd')
)

select
t0.HRYID 海融易id,
t0.STAFF_PHONE 办公手机号,
t2.order_count p2p_订单笔数,
t2.amt p2p_投资金额,
t3.order_count 基金笔数,
t3.amt 基金投资金额,
nvl(t2.order_count,0)+nvl(t3.order_count,0) 总投资笔数,
nvl(t2.amt,0)+nvl(t3.amt,0) 总投资金额
from TMP_20170303_NO_INVEST_CHECK t0
INNER join bidata.s_s61_t6110 t1
on t0.HRYID=t1.F01
left join (select
t0.f03 hryid,
count(*) order_count,
sum(t0.f05) amt
from bidata.s_s62_t6250 t0
group by t0.f03) t2
on t0.hryid=t2.hryid
left join (

select
b.kjt_cust_id kjtid,
count(*) order_count,
sum(b.trans_amt)/100 amt
from funduser.t_fund_share_order@fdb b
where b.trans_type='I' 
and b.status=5 
and b.create_time < to_date('20170401','yyyymmdd') 
--and b.create_time >= to_date('20170207','yyyymmdd')
group by b.kjt_cust_id
) t3
on t1.kjtid=t3.kjtid
;


--------
with TMP_20170505_NO_INVEST_CHECK AS (
select
t1.f01 hryid
,t0.phone STAFF_PHONE
from bidim.obj_staff_phone t0
inner join bidata.s_s61_t6110  t1
on t0.phone=t1.f02 or t0.phone=t1.f04
where t1.CREATED_TIME < to_date('20170501','yyyymmdd')
)

select
t0.HRYID 海融易id,
t0.STAFF_PHONE 办公手机号,
t2.order_count p2p_订单笔数,
t2.amt p2p_投资金额,
t3.order_count 基金笔数,
t3.amt 基金投资金额,
nvl(t2.order_count,0)+nvl(t3.order_count,0) 总投资笔数,
nvl(t2.amt,0)+nvl(t3.amt,0) 总投资金额
from TMP_20170505_NO_INVEST_CHECK t0
INNER join bidata.s_s61_t6110 t1
on t0.HRYID=t1.F01
left join (select
t0.f03 hryid,
count(*) order_count,
sum(t0.f05) amt
from bidata.s_s62_t6250 t0
group by t0.f03) t2
on t0.hryid=t2.hryid
left join (

select
b.kjt_cust_id kjtid,
count(*) order_count,
sum(b.trans_amt)/100 amt
from funduser.t_fund_share_order@fdb b
where b.trans_type='I' 
and b.status=5 
and b.create_time < to_date('20170501','yyyymmdd') 
--and b.create_time >= to_date('20170207','yyyymmdd')
group by b.kjt_cust_id
) t3
on t1.kjtid=t3.kjtid
;


