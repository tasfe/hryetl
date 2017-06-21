select * from s_s62_t6250 
-- 投资金额区间

select to_char(f06), count(1) from (
  select to_char(f06,'yyyymmdd') f06,f03,sum(f04) amt from s_s62_t6250
  where 
  f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
  AND F07 = 'F'
  group by to_char(f06,'yyyymmdd'),f03
  order by to_char(f06)
)where 
--amt <5000 
--amt between 5000 and 20001
amt between 50000 and 100001
--amt > 100000
group by to_char(f06)
order by to_char(f06)



-- 投资金额区间
select * from (
select f06 dates,amt, count(1) user_tot from (
  select to_char(f06,'yyyymmdd') f06,f03,decode(greatest(sum(f04),4999.9999),4999.9999,'小于5k',decode(greatest(sum(f04),19999.99),19999.99,'5k-20k',
         decode(greatest(sum(f04),49999.99),49999.99,'20k-50k',decode(greatest(sum(f04),99999.99),99999.99,'50k-100k','大于100k')))) amt
  from s_s62_t6250
  where f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
  and f07 = 'F'
  group by to_char(f06,'yyyymmdd'),f03
  order by to_char(f06)
)
group by f06,amt
order by f06
)
pivot (sum(user_tot) for amt in ('小于5k','5k-20k','20k-50k','50k-100k','大于100k'))
order by dates






-- 投资期限区间
select * from (
select f06 time,days,
  count(distinct(usr_id)) user_tot --用户数
  --sum(f05) amt_tot -- 金额
  
  from (
  select to_char(a.f06,'yyyymmdd') f06,f03 usr_id,f05,
         decode(greatest(b.days,30),30,'1-30天',decode(greatest(b.days,90),90,'30-90天',
         decode(greatest(b.days,180),180,'90-180天',decode(greatest(b.days,365),365,'180-365天','大于365天')))) days,
         days dayss
         --decode(day_borrow_duration,0,monty_borrow_duration * 30, day_borrow_duration) days
  from s_s62_t6250 a inner join
    (SELECT a.f01 pid,
    --decode(a.f09,0,0,a.f09) AS monty_borrow_duration,
    decode(a.f09,0,c.f22,a.f09*30) AS days
    FROM S_S62_T6230 a
    LEFT JOIN S_S62_T6231 c
    ON a.f01 = c.f01
    ) b 
  on a.f02 = b.pid
  and f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
)
group by f06,days
order by f06
)
pivot (sum(user_tot) for days in ('1-30天','30-90天','90-180天','180-365天','大于365天'))  --用户数
--pivot (sum(amt_tot) for days in ('1-30天','30-90天','90-180天','180-365天','大于365天')) --金额
order by time;

-- 总投资额
select to_char(f06,'yyyymmdd') , sum(f04) 
from s_s62_t6250 where f07 = 'F' and f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
group by to_char(f06,'yyyymmdd')
order by to_char(f06,'yyyymmdd')

-- 年化总投资额
select to_char(f06,'yyyymmdd'),sum(money) from (
  select a.f06,round(decode(b.f09,0,a.f04/365*b.f08,a.f04/12*b.f09) ,2) money,b.f08,b.f09 
  from s_s62_t6250 a left join s_s62_t6230 b on a.f02 = b.f01
  where a.f07 = 'F'
  and a.f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
)
group by to_char(f06,'yyyymmdd')


-- 理财金发放总额
select to_char(given_time),sum(rewards)/100 from s_promo_rewards
where 
given_time between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
group by to_char(given_time)
order by to_char(given_time)

-- 每天理财金使用金额
select to_char(b.f04,'yyyymmdd') 时间,sum(a.f07) 理财金使用金额 from S_S65_T6504 a left join S_S65_T6501 b on a.f01 = b.f01
where PAYMENTSTATUS = 'ZFCG'
AND b.F04 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
group by to_char(b.f04,'yyyymmdd')
order by to_char(b.f04,'yyyymmdd')


-- 投资券使用总金额   将usage_time换成activate_time就是投资卷发放金额
select to_char(usage_time,'yyyymmdd'),sum(coupon_value) / 100 from (
SELECT a.id,
  a.activate_time,
  a.COUPON_CATEGORY_ID,
  b.coupon_name,
  b.min_payment,
  b.min_product_maturity,
  b.winning_rate,
  a.coupon_no,
  a.coupon_value,
  a.user_id hry_id,
  a.usage_time
FROM s_promo_coupon a
LEFT JOIN s_promo_coupon_category b
ON a.coupon_category_id = b.id
LEFT JOIN S_PROMO_PROMOTION_ACTIVITY c
ON a.promotion_activity_id = c.id
LEFT JOIN S_PROMO_PROMOTION_ACTIVITY_RUL d
ON a.PROMOTION_ACTIVITY_RULE_ID = d.id
LEFT JOIN S_PROMO_COUPON_FUND_TRANSFER e
ON a.id = e.COUPON_ID)
where
usage_time between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
group by to_char(usage_time,'yyyymmdd')
order by to_char(usage_time,'yyyymmdd')


-- 各标的产品购买总额度以及进度
select to_char(a.f06,'yyyymmdd') 日期,b.f01 标id,b.f03 标名字,sum(a.f04) 当日投资额,b.f05 项目金额,sum(a.f04)/b.f05
from S_S62_T6250 a left join S_S62_T6230 b on a.f02 = b.f01
where b.f01 in (select b.f01
  from S_S62_T6250 a left join S_S62_T6230 b on a.f02 = b.f01
  where a.f06 BETWEEN to_date('20161201','yyyymmdd') and to_date('20161227','yyyymmdd'))
group by to_char(a.f06,'yyyymmdd'),b.f01,b.f03,b.f05
order by to_char(a.f06,'yyyymmdd')
