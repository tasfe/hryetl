----- 新增交易
select 
count(*) 周内新增交易用户数
from (
select 
t0.KJTID,
MIN(t0.RPTDT) first_invest
from BI_USER_EXCHANGE t0
group by t0.KJTID) T
where T.first_invest BETWEEN 20170130 and 20170206
;

------ 周内累计交易
select
count(distinct(t0.kjtid)) 周内累计交易用户数
from BI_USER_EXCHANGE t0
where t0.RPTDT BETWEEN 20170130 and 20170206
;

----- 20170205 活跃用户
select 
count(distinct(T.KJTID)) 活跃用户数
from (
select 
t0.KJTID,
count(*) invest_count
from bidata.BI_USER_EXCHANGE t0
where t0.RPTDT > 20170105
group BY t0.kjtid

UNION all

select 
t0.KJTID,
count(*) invest_count
from bidata.BI_USER_EXCHANGE t0
where t0.RPTDT > 20161105
group BY t0.kjtid
HAVING count(*)>1 ) T
;


