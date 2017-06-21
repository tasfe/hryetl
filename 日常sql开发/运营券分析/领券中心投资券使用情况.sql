----------------------
select
to_char(t0.created_time,'yyyymmdd') RPTDT,
t0.VALUE 投资券金额,
count(*) 发放张数,
sum(t0.value) 发放金额,
count(distinct(t0.USER_ID)) 去重领取人数,
count(t0.user_id) 领取张数,
count(t1.coupon_id) 使用张数,
sum(t1.invest_coupon_amount) 使用金额,
to_char(100*count(t1.coupon_id)/count(*),'99.99')||'%' AS 使用率,
sum(t1.INVEST_AMOUNT) 使用券投资金额
from BIDATA.V_COUPON_CENTER t0
left join BIDATA.V_COUPON_INVEST t1
on t0.id=t1.COUPON_ID
where to_char(t0.created_time,'yyyymmdd')  between '20170101' and '20170211'
group by to_char(t0.created_time,'yyyymmdd'),t0.VALUE
order by to_char(t0.created_time,'yyyymmdd'),t0.VALUE
;
