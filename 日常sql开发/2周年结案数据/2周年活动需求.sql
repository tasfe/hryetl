
---------------------------新增注册用户---------------
--双十一数据
select * from s_s61_t6110 where kjtid is not null

select count(1) from s_s61_t6110 where kjtid is not null

select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20161111 and 20161130

--2周年数据
select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20161222 and 20170120

--非活动期数据
select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20170121 and 20170210


-------------------------------------2万＞新用户首次投资≥5000的用户数//>=2万	-----------------
--双十一数据
select count(1) from (
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161130
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161130
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1
)

--2周年数据
select count(1) from (
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170120
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170120
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1
)

--非活动期间
select count(1) from (
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 
where to_char(b.f06,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f09,'yyyymmdd') between 20170121 and 20170210
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1
)

-----------------------------新用户投资30天以上的购买数-------------------
--双十一数据
--825
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on b.f02 = c.pid
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161130
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161130
and c.day_borrow_duration > 29
) where rn = 1

--2周年数据
--1066
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on b.f02 = c.pid
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170120
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170120
and c.day_borrow_duration > 29
) where rn = 1

--非活动期
--736
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on b.f02 = c.pid
where to_char(b.f06,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f09,'yyyymmdd') between 20170121 and 20170210
and c.day_borrow_duration > 29
) where rn = 1

------------------------------新用户交易总金额	---------------------
--双十一数据
select sum(amt) from ( 
select a.f01 user_id, b.f05 amt, b.f06 time
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161130
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161130
) 

--2周年数据
select sum(amt) from (
select a.f01 user_id, b.f05 amt, b.f06 time
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170120
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170120
)

--非活动期
select sum(amt) from ( 
select a.f01 user_id, b.f05 amt, b.f06 time
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f09,'yyyymmdd') between 20170121 and 20170210
) 

--每日总投金额
select to_char(f06,'yyyymmdd'),sum(f04) from s_s62_t6250 where f07 = 'F'
and f06 between to_date('20161222','yyyymmdd') and to_date('20170121','yyyymmdd')
group by to_char(f06,'yyyymmdd')
order by to_char(f06,'yyyymmdd')


--每日年化总额

select times,sum(amt) from (
select to_char(a.f06,'yyyymmdd') times,
       a.f02 p_id, 
       decode(c.f21,'S',a.f04*c.f22/365,a.f04 * b.f09/12) amt,
       c.f21 is_day,
       c.f22 days,
       b.f09 months 
from s_s62_t6250 a left join s_s62_t6230 b on a.f02 = b.f01 left join s_s62_t6231 c on a.f02 = c.f01
where a.f07 = 'F'
and to_char(a.f06,'yyyymmdd') between 20161222 and 20170120
)
group by times
order by times

select to_char(f06,'yyyymmdd') time,count(1) from s_s62_t6250 
where to_char(f06,'yyyymmdd') between 20161222 and 20170120
group by to_char(f06,'yyyymmdd')
order by to_char(f06,'yyyymmdd')


-----------------------投资金额占比------------------
--双十一
select name,tot, sum_tot,tot/ SUM_TOT from (
select PARENT_BID_TYPE_NAME name,sum(f05) tot,
  (select sum(f05) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20161111 and 20161130 and f07 = 'F') SUM_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid
where to_char(a.f06,'yyyymmdd') between 20161111 and 20161130
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

--2周年
select name,tot, sum_tot,tot/ SUM_TOT from (
select PARENT_BID_TYPE_NAME name,sum(f05) tot,
  (select sum(f05) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20161222 and 20170120 and f07 = 'F') SUM_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid 
where to_char(a.f06,'yyyymmdd')  between 20161222 and 20170120 
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

--非活动期间
select name,tot, sum_tot,tot/ SUM_TOT from (
select PARENT_BID_TYPE_NAME name,sum(f05) tot,
  (select sum(f05) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20170121 and 20170210 and f07 = 'F') SUM_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid
where to_char(a.f06,'yyyymmdd') between 20170121 and 20170210
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

------------------------------投资笔数占比分析	------------------------------

--双十一数据
select name,tot, order_tot,tot / order_tot from (
select PARENT_BID_TYPE_NAME name,count(1) tot,
  (select count(1) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20161111 and 20161130 and f07 = 'F') order_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid
where to_char(a.f06,'yyyymmdd') between 20161111 and 20161130
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

--2周年数据
select name,tot, order_tot,tot / order_tot from (
select PARENT_BID_TYPE_NAME name,count(1) tot,
  (select count(1) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20161222 and 20170120 and f07 = 'F') order_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid
where to_char(a.f06,'yyyymmdd') between 20161222 and 20170120
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

--非活动期间
select name,tot, order_tot,tot / order_tot from (
select PARENT_BID_TYPE_NAME name,count(1) tot,
  (select count(1) from s_s62_t6250 where to_char(f06,'yyyymmdd') between 20170121 and 20170210 and f07 = 'F') order_TOT
from s_s62_t6250 a inner join ods_prod_p2p_list b on a.f02 = b.pid
where to_char(a.f06,'yyyymmdd') between 20170121 and 20170210
and f07 = 'F'
group by PARENT_BID_TYPE_NAME
)

-------------------单笔平均投资额---------------
select sum(f04) / count(1) from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20161111 and 20161130

select sum(f04) / count(1) from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20161222 and 20170120

select sum(f04) / count(1) from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20170121 and 20170210

-----------------每日平均投资总额------------------
select sum(f04) / count(distinct(to_char(f06,'yyyymmdd'))) per_day
from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20161111 and 20161130

select sum(f04) / count(distinct(to_char(f06,'yyyymmdd'))) per_day
from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20161222 and 20170120

select sum(f04) / count(distinct(to_char(f06,'yyyymmdd'))) per_day
from s_s62_t6250 where f07 = 'F'
and to_char(f06,'yyyymmdd') between 20170121 and 20170210


---------------------金额区间的投资笔数对比	------------------------
--双11数据
select * from (
select amt, count(1) user_tot from (
  select to_char(f06,'yyyymmdd') f06,f03,decode(greatest(sum(f04),4999.9999),4999.9999,'小于5k',decode(greatest(sum(f04),19999.99),19999.99,'5k-20k',
         decode(greatest(sum(f04),99999.99),99999.99,'20k-100k','大于100k'))) amt
  from s_s62_t6250
  where to_char(f06,'yyyymmdd') between 20161111 and 20161130
  and f07 = 'F'
  group by to_char(f06,'yyyymmdd'),f03
  order by to_char(f06)
)
group by amt
)
pivot (sum(user_tot) for amt in ('小于5k','5k-20k','20k-100k','大于100k'))

--2周年数据
select * from (
select amt, count(1) user_tot from (
  select to_char(f06,'yyyymmdd') f06,f03,decode(greatest(sum(f04),4999.9999),4999.9999,'小于5k',decode(greatest(sum(f04),19999.99),19999.99,'5k-20k',
         decode(greatest(sum(f04),99999.99),99999.99,'20k-100k','大于100k'))) amt
  from s_s62_t6250
  where to_char(f06,'yyyymmdd') between 20161222 and 20170120
  and f07 = 'F'
  group by to_char(f06,'yyyymmdd'),f03
  order by to_char(f06)
)
group by amt
)
pivot (sum(user_tot) for amt in ('小于5k','5k-20k','20k-100k','大于100k'))

--非活动期间
select * from (
select amt, count(1) user_tot from (
  select to_char(f06,'yyyymmdd') f06,f03,decode(greatest(sum(f04),4999.9999),4999.9999,'小于5k',decode(greatest(sum(f04),19999.99),19999.99,'5k-20k',
         decode(greatest(sum(f04),99999.99),99999.99,'20k-100k','大于100k'))) amt
  from s_s62_t6250
  where to_char(f06,'yyyymmdd') between 20170121 and 20170210
  and f07 = 'F'
  group by to_char(f06,'yyyymmdd'),f03
  order by to_char(f06)
)
group by amt
)
pivot (sum(user_tot) for amt in ('小于5k','5k-20k','20k-100k','大于100k'))

-------------------------投资频率的用户数对比--------------------------------
--双十一
select counts,count(1) from (
select f03,decode(count(1),1,'一次',2,'2-3次',3,'2-3次','4次以上') counts from s_s62_t6250 
 where to_char(f06,'yyyymmdd') between 20161111 and 20161130
   and f07 = 'F'
 group by f03
)
group by counts 

--2周年
select counts,count(1) from (
select f03,decode(count(1),1,'一次',2,'2-3次',3,'2-3次','4次以上') counts from s_s62_t6250 
 where to_char(f06,'yyyymmdd') between 20161222 and 20170120
   and f07 = 'F'
 group by f03
)
group by counts 

--非活动期间
select counts,count(1) from (
select f03,decode(count(1),1,'一次',2,'2-3次',3,'2-3次','4次以上') counts from s_s62_t6250 
 where to_char(f06,'yyyymmdd') between 20170121 and 20170210
   and f07 = 'F'
 group by f03
)
group by counts 
 
--------WEB PV-UV数据对比-------APP PV-UV数据对比------------
--双十一
select tel_type, sum(uv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) uv_avg,
sum(pv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) pv_avg
from bi_web_tol_pv_uv 
where dt between 20161111 and 20161130
group by tel_type

--2周年
select tel_type, sum(uv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) uv_avg,
sum(pv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) pv_avg
from bi_web_tol_pv_uv 
where dt between 20161222 and 20170120
group by tel_type

--非活动期间
select tel_type, sum(uv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) uv_avg,
sum(pv) / (select count(1)/2 from bi_web_tol_pv_uv where dt between 20161111 and 20161130) pv_avg
from bi_web_tol_pv_uv 
where dt between 20170121 and 20170210
group by tel_type



--------------砸蛋情况----------------
select count(1) from S_PROMO_LOTTERY_RECORD
where to_char(created_time,'yyyymmdd') between 20161222 and 20170120

select * from S_PROMO_LOTTERY_RECORD where hry_id = '11766425'

select a.hry_id,b.sex, 2017 - to_char(b.birthday,'yyyy'),a.counts from (
select a.hry_id,count(1) counts from S_PROMO_LOTTERY_RECORD a
group by hry_id 
) a left join ods_user_hry_users b on a.hry_id = b.hryid
order by a.counts desc

----------------------投资券发放/使用分析--------------------
select type_name,sum(coupon_value / 100) from (
select coupon_value,
       decode(usage_time,null,0,1) is_used,
       case when promotion_activity_id = '128' then '2周年'
            when id in (select rewards_value 
                        from s_promo_grab_coupon_record where to_char(created_time,'yyyymmdd') > 20170120) then '领券中心'
            else '其他' end type_name
from s_promo_coupon
where to_char(created_time,'yyyymmdd') between 20170120 and 20170210
) group by type_name

select type_name,is_used,sum(coupon_value) from (
select coupon_value,
       decode(usage_time,null,0,1) is_used,
       case when promotion_activity_id = '128' then '2周年'
            when id in (select rewards_value
                        from s_promo_grab_coupon_record where to_char(created_time,'yyyymmdd') > 20170120) then '领券中心'
            else '其他' end type_name
from s_promo_coupon
where to_char(created_time,'yyyymmdd') between 20170121 and 20170210
) group by type_name,is_used

--投资券投资总额
select  type_name,sum(amt_tot) from (
select a.id,A.coupon_value /100 coupon_value,
       decode(A.usage_time,null,0,1) is_used,
       case when A.promotion_activity_id = '128' then '2周年'
            when id in (select rewards_value
                        from s_promo_grab_coupon_record where to_char(created_time,'yyyymmdd') > 20170120) then '领券中心'
            else '其他' end type_name,
      A.COUPON_NO,
      F.F01 ORDER_ID,
      f.F04 AMT_TOT 
from s_promo_coupon A inner join s_s65_t6504 f on A.coupon_no = f.INVEST_COUPON_NO 
inner join s_s65_t6501 b on b.f01 = f.f01
where to_char(a.created_time,'yyyymmdd') between 20161222 and 20170120
and to_char(b.f06,'yyyymmdd') between 20161222 and 20170210
and f.paymentstatus = 'ZFCG'
) group by type_name


------------------理财金发放/使用分析--------------------
--发放总额
select sum(rewards / 100) sum_tot from s_promo_rewards where  promotion_activity_id = '128' and 
to_char(given_time,'yyyymmdd') between 20161222 and 20170210
-- and user_id in (11162955,11689626,11224653,3030,4334,9464,11957161,4192,6788,10440) -- 前十



-- 使用总额
select type_name,sum(rewards) from (
select a.id,case when a.comments like ('%新新相约%') then '新新相约' --REWARD_DIS_ID in (1612,1614,1618,1619,1626,1644,1646) then '新新相约'
       when a.promotion_activity_id = '128' then '二周年'
       else '其他' end type_name,
       a.rewards / 100 rewards,
       to_char(a.given_time,'yyyymmdd') time,
       to_char(b.created_time,'yyyymmdd') use_time
from s_promo_rewards a inner join s_s65_currency_voucher_order b 
  on (to_char(b.used_currency_voucher_ids) like '%,'||a.given_id||',%' or to_char(b.used_currency_voucher_ids) like '%,'||a.given_id
      or to_char(b.used_currency_voucher_ids) like a.given_id||',%' or to_char(b.used_currency_voucher_ids) = a.given_id)
where (to_char(a.given_time,'yyyymmdd') between 20161111 and 20170210)
and rewards != 288000
and to_char(b.created_time,'yyyymmdd') between 20161222 and 20170120
and b.status = 3 and b.payment_status = 2
)
group by type_name

-- 前十名发放理财金总额
select type_name,sum(rewards) from (
select a.id,case when a.comments like ('%新新相约%') then '新新相约' --REWARD_DIS_ID in (1612,1614,1618,1619,1626,1644,1646) then '新新相约'
       when a.promotion_activity_id = '128' then '二周年'
       else '其他' end type_name,
       a.rewards / 100 rewards,
       to_char(a.created_time,'yyyymmdd') time,
       to_char(b.created_time,'yyyymmdd') use_time
from s_promo_rewards a inner join s_s65_currency_voucher_order b 
  on (to_char(b.used_currency_voucher_ids) like '%,'||a.given_id||',%' or to_char(b.used_currency_voucher_ids) like '%,'||a.given_id
      or to_char(b.used_currency_voucher_ids) like a.given_id||',%' or to_char(b.used_currency_voucher_ids) = a.given_id)
where (to_char(a.created_time,'yyyymmdd') between 20161222 and 20170120)
and rewards != 288000
and to_char(b.created_time,'yyyymmdd') between 20161222 and 20170120
and b.status = 3 and b.payment_status = 2
and a.user_id in (11162955,11689626,11224653,3030,4334,9464,11957161,4192,6788,10440)
)
group by type_name

--理财金投资总额
select type_name,sum(amt_tot) from (
select a.id,b.bidding_order_id order_id,c.f04 amt_tot,case when a.comments like ('%新新相约%') then '新新相约' --REWARD_DIS_ID in (1612,1614,1618,1619,1626,1644,1646) then '新新相约'
       when a.promotion_activity_id = '128' then '二周年'
       else '其他' end type_name,
       a.rewards / 100 rewards,
       to_char(a.created_time,'yyyymmdd') time,
       to_char(b.created_time,'yyyymmdd') use_time
from s_promo_rewards a inner join s_s65_currency_voucher_order b 
  on (to_char(b.used_currency_voucher_ids) like '%,'||a.given_id||',%' or to_char(b.used_currency_voucher_ids) like '%,'||a.given_id
      or to_char(b.used_currency_voucher_ids) like a.given_id||',%' or to_char(b.used_currency_voucher_ids) = a.given_id)
  inner join s_s65_t6504 c on b.bidding_order_id = c.f01
where (to_char(a.created_time,'yyyymmdd') between 20170120 and 20170210)
and to_char(b.created_time,'yyyymmdd') between 20170120 and 20170210
and rewards != 288000
and b.status = 3 and b.payment_status = 2
)group by type_name


--前十名使用理财金带来的投资总额
select type_name,sum(rewards) from (
select a.id,b.bidding_order_id order_id,c.f04 amt_tot,case when a.comments like ('%新新相约%') then '新新相约' --REWARD_DIS_ID in (1612,1614,1618,1619,1626,1644,1646) then '新新相约'
       when a.promotion_activity_id = '128' then '二周年'
       else '其他' end type_name,
       a.rewards / 100 rewards,
       to_char(a.created_time,'yyyymmdd') time,
       to_char(b.created_time,'yyyymmdd') use_time
from s_promo_rewards a inner join s_s65_currency_voucher_order b 
  on (to_char(b.used_currency_voucher_ids) like '%,'||a.given_id||',%' or to_char(b.used_currency_voucher_ids) like '%,'||a.given_id
      or to_char(b.used_currency_voucher_ids) like a.given_id||',%' or to_char(b.used_currency_voucher_ids) = a.given_id)
  inner join s_s65_t6504 c on b.bidding_order_id = c.f01
where (to_char(a.created_time,'yyyymmdd') between 20161222 and 20170120)
and to_char(b.created_time,'yyyymmdd') between 20161222 and 20170120
and rewards != 288000
and b.status = 3 and b.payment_status = 2
and a.user_id in (11162955,11689626,11224653,3030,4334,9464,11957161,4192,6788,10440)
)group by type_name




select type_name,sum(rewards) from (
select a.id,case when a.comments like ('%新新相约%') then '新新相约' --REWARD_DIS_ID in (1612,1614,1618,1619,1626,1644,1646) then '新新相约'
       when a.promotion_activity_id = '128' then '二周年'
       else '其他' end type_name,
       a.rewards / 100 rewards,
       to_char(a.created_time,'yyyymmdd') time,
       to_char(b.created_time,'yyyymmdd') use_time
from s_promo_rewards a inner join s_s65_currency_voucher_order b 
  on (to_char(b.used_currency_voucher_ids) like '%,'||a.given_id||',%' or to_char(b.used_currency_voucher_ids) like '%,'||a.given_id
      or to_char(b.used_currency_voucher_ids) like a.given_id||',%' or to_char(b.used_currency_voucher_ids) = a.given_id)
where (to_char(a.created_time,'yyyymmdd') between 20170121 and 20170210)
and rewards != 288000
and to_char(b.created_time,'yyyymmdd') between 20170121 and 20170210
and b.status = 3 and b.payment_status = 2
)
group by type_name

-------------------新增交易用户数---------------
--双十一
select count(distinct(b.hryid)) from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where to_char(b.reg_time,'yyyymmdd') between 20161111 and 20161131
and to_char(a.f06,'yyyymmdd') between 20161111 and 20161131
and a.f07 = 'F'
--两周年
select count(distinct(b.hryid)) from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where to_char(b.reg_time,'yyyymmdd') between 20161222 and 20170120
and to_char(a.f06,'yyyymmdd') between 20161222 and 20170120
and a.f07 = 'F'

-- 非活动期间
select count(distinct(b.hryid)) from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where to_char(b.reg_time,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f06,'yyyymmdd') between 20170121 and 20170210
and a.f07 = 'F'

--双十一
select count(distinct(hryid)) time from (
select rank() over(partition by a.f03 order by a.f06 asc) rn, b.hryid,a.f06,b.reg_time 
from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where a.f07 = 'F'
)where rn = 1
and to_char(f06,'yyyymmdd') between  20161111 and 20161131

--两周年
select count(distinct(hryid)) time from (
select rank() over(partition by a.f03 order by a.f06 asc) rn, b.hryid,a.f06,b.reg_time 
from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where a.f07 = 'F'
)where rn = 1
and to_char(f06,'yyyymmdd') between  20161222 and 20170120

--非活动期间
select count(distinct(hryid)) time from (
select rank() over(partition by a.f03 order by a.f06 asc) rn, b.hryid,a.f06,b.reg_time 
from s_s62_t6250 a inner join dim_user_hry_users b on a.f03 = b.hryid
where a.f07 = 'F'
)where rn = 1
and to_char(f06,'yyyymmdd') between 20170121 and 20170210



