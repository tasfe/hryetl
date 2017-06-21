select 
count(*),
count(distinct(t0.f03)),
sum(t0.F05) amt
from s_s62_t6250 t0
where t0.f07='F' and t0.F06<to_date('20160101','yyyymmdd')
;

select 
count(*),
count(distinct(t0.f03)),
sum(t0.F05) amt
from s_s62_t6250 t0
where t0.f07='F' and t0.F06<to_date('20170101','yyyymmdd')
;


SELECT 
T.amt/T.invest_orders 截止20161231日客单价订单, 
T.amt/T.invest_users 截止20161231日客单价客户 
FROM
(
select 
count(*) invest_orders,
count(distinct(t0.f03)) invest_users,
sum(t0.F05) amt
from s_s62_t6250 t0
where t0.f07='F' and t0.F06<to_date('20170101','yyyymmdd')
) T
;

SELECT 
T.amt/T.invest_orders 截止20151231日客单价订单, 
T.amt/T.invest_users 截止20151231日客单价客户 
FROM
(
select 
count(*) invest_orders,
count(distinct(t0.f03)) invest_users,
sum(t0.F05) amt
from s_s62_t6250 t0
where t0.f07='F' and t0.F06<to_date('20160101','yyyymmdd')
) T
;


SELECT 
T.amt/T.invest_orders 截止20170228日客单价订单, 
T.amt/T.invest_users 截止20170228日客单价客户 
FROM
(
select 
count(*) invest_orders,
count(distinct(t0.f03)) invest_users,
sum(t0.F05) amt
from s_s62_t6250 t0
where t0.f07='F' and t0.F06<to_date('20170201','yyyymmdd')
) T
;


