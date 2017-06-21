---- 截止2016年年底交易用户
select 
count(distinct(t0.kjtid))
from bi_user_exchange t0
where t0.RPTDT < 20170101;
---- 截止2015年年底交易用户
select 
count(distinct(t0.kjtid))
from bi_user_exchange t0
where t0.RPTDT < 20160101;

---- 全年交易用户
select 
count(distinct(t0.kjtid))
from bi_user_exchange t0
where t0.RPTDT>20151231 and t0.RPTDT < 20170101;

---- 截止2015年年底登录用户
select 
count(distinct(t0.USER_ID))
from bi_log t0
where t0.LOG_TIME < to_date(20160101,'yyyyMMdd') and t0.USER_ID is not null;

---- 截止2016年年底登录用户
select 
count(distinct(t0.USER_ID))
from bi_log t0
where t0.LOG_TIME < to_date(20170101,'yyyyMMdd') and t0.USER_ID is not null;

