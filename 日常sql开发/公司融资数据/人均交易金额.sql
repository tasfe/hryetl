select 
T.BUSINESS_FLAG 业务线,
T.year 年度,
T.user_count 投资用户,
T.total_amt 总投资金额,
T.total_amt/T.user_count 人均投资金额
from (
select
v0.BUSINESS_FLAG,
to_char(v0.invest_time,'yyyy') year,
count(DISTINCT(v0.kjtid)) user_count,
sum(v0.AMT) total_amt
from v_user_invest v0
group by v0.BUSINESS_FLAG,to_char(v0.invest_time,'yyyy')
order by v0.BUSINESS_FLAG,to_char(v0.invest_time,'yyyy')
) T
;
-----------
select 
T.BUSINESS_FLAG 业务线,
T.user_flag 用户标签,
T.year 年度,
T.user_count 投资用户,
T.total_amt 总投资金额,
T.total_amt/T.user_count 人均投资金额,
T.total_amt/T.order_count 每单平均投资额
from (
select
v0.BUSINESS_FLAG,
v0.user_flag,
to_char(v0.invest_time,'yyyy') year,
count(DISTINCT(v0.kjtid)) user_count,
count(*) order_count,
sum(v0.AMT) total_amt
from v_user_invest_flag v0
group by v0.BUSINESS_FLAG,to_char(v0.invest_time,'yyyy'),v0.USER_FLAG
order by v0.BUSINESS_FLAG,to_char(v0.invest_time,'yyyy')
) T
;

select 
USER_FLAG,
sum(amt),
count(distinct(kjtid))
from V_USER_INVEST_FLAG
where BUSINESS_FLAG='P2P'
group by USER_FLAG
;


-------------- 截止 2015/2016年年底 客单价
select 
T.BUSINESS_FLAG 业务线,
---T.user_flag 用户标签,
T.user_count 投资用户,
T.total_amt 总投资金额,
T.total_amt/T.user_count 人均投资金额,
T.total_amt/T.order_count 每单平均投资额
from (
select
v0.BUSINESS_FLAG,
---v0.user_flag,
count(DISTINCT(v0.kjtid)) user_count,
count(*) order_count,
sum(v0.AMT) total_amt
from v_user_invest_flag v0
where v0.invest_time < to_date('20170101','yyyymmdd')
group by v0.BUSINESS_FLAG---,to_char(v0.invest_time,'yyyy'),v0.USER_FLAG
---order by v0.BUSINESS_FLAG,to_char(v0.invest_time,'yyyy')
) T
;


-----



