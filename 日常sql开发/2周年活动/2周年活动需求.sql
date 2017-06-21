
---------------------------新增注册用户---------------
--双十一数据
select * from s_s61_t6110 where kjtid is not null

select count(1) from s_s61_t6110 where kjtid is not null

select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20161111 and 20161201

--2周年数据
select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20161222 and 20170121

--非活动期数据
select count(1) from s_s61_t6110
where kjtid is not null
and to_char(f09,'yyyymmdd') between 20170121 and 20170211


-------------------------------------2万＞新用户首次投资≥5000的用户数//>=2万	-----------------
--双十一数据
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161201
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161201
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1

--2周年数据
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170121
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170121
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1

--非活动期间
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 
where to_char(b.f06,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f09,'yyyymmdd') between 20170121 and 20170210
--and b.f05 between 5000 and 20000
and b.f05 > 19999.9999
)where rn = 1

-----------------------------新用户投资30天以上的购买数-------------------
--双十一数据
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on a.f01 = c.pid
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161201
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161201
and c.day_borrow_duration > 29
) where rn = 1

--2周年数据
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on a.f01 = c.pid
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170121
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170121
and c.day_borrow_duration > 29
) where rn = 1

--非活动期
select count(1) from (
select a.f01 user_id, b.f05 amt, b.f06 time,c.day_borrow_duration, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 inner join ods_prod_p2p_list c on a.f01 = c.pid
where to_char(b.f06,'yyyymmdd') between 20170121 and 20170210
and to_char(a.f09,'yyyymmdd') between 20170121 and 20170210
and c.day_borrow_duration > 29
) where rn = 1

------------------------------新用户交易总金额	---------------------
--双十一数据
select sum(amt) from ( 
select a.f01 user_id, b.f05 amt, b.f06 time
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161111 and 20161201
and to_char(a.f09,'yyyymmdd') between 20161111 and 20161201
) 

--2周年数据
select sum(amt) from (
select a.f01 user_id, b.f05 amt, b.f06 time
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170121
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170121
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

select sum(amt) from (
select to_char(a.f06,'yyyymmdd') times,
       a.f02 p_id, 
       decode(c.f21,'S',a.f04*c.f22/365,a.f04 * b.f09/12) amt,
       c.f21 is_day,
       c.f22 days,
       b.f09 months 
from s_s62_t6250 a left join s_s62_t6230 b on a.f02 = b.f01 left join s_s62_t6231 c on a.f02 = c.f01
where a.f07 = 'F'
and to_char(a.f06,'yyyymmdd') between 20161222 and 20170121
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

