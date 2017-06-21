select
decode(t0.trans_type,'I','转入','O','转出','C','消费','R','退款转入','P','收益转入','未枚举交易类型') 交易类型,
sum(t0.TRANS_AMT)/100 交易金额
from BI_FUND_EXCHANGE_LIST t0
--where to_char(t0.UPDATE_TIME,'yyyymmdd')='20170204'
--and t0.status=5 
group by t0.trans_type
;

----- 线下理财金额统计
select 
sum(t0.trade_amount) 线下理财总金额
from BIDATA.S_S70_HRY_OFFLINE_TRADE_STATS t0
;
----- P2P金额统计
select 
sum (t0.F05) P2P理财总金额
from bidata.s_s62_t6250 t0
where t0.f07='F'
;
---- 天天聚基金金额统计
select
decode(t0.trans_type,'I','转入','O','转出','C','消费','R','退款转入','P','收益转入','未枚举交易类型') 交易类型,
sum(t0.TRANS_AMT)/100 基金交易金额
from funduser.T_FUND_SHARE_ORDER@FDB t0
where t0.status=5 and 
group by t0.trans_type
;

---- 海宝(历史上)金额统计
select '1' as flag,
'hb' as prod,
'amt'as type,
to_number(max(TOTAL_DEAL)) as stats_value
from s_s71_HB_INFOMATION
;


--------- 金额统计
select 
sum (t0.F05) 总金额,
'P2P理财' as 业务线
from bidata.s_s62_t6250 t0
where t0.f07='F'
UNION all
select 
sum(t0.trade_amount) 总金额,
'线下理财' as 业务线
from BIDATA.S_S70_HRY_OFFLINE_TRADE_STATS t0
UNION all
select
sum(t0.TRANS_AMT)/100 总金额,
'天天聚基金交易'  as 业务线
from funduser.T_FUND_SHARE_ORDER@FDB t0
where t0.status=5  and t0.trans_type='I' and t0.UPDATE_TIME<to_date('20170101','yyyymmdd')
UNION all
select 
to_number(max(TOTAL_DEAL)) 总金额,
'海宝交易'  as 业务线
from s_s71_HB_INFOMATION
;

select * 
from s_s71_HB_INFOMATION t0
order by t0.UPDATE_TIME desc
;
select
*
from BIDATA.S_S70_HRY_OFFLINE_TRADE_STATS t0
;



select 
sum (t0.F05) 总金额,
count(distinct(t0.f0))
'P2P理财' as 业务线
from bidata.s_s62_t6250 t0
where t0.f07='F' and t0.


select 
sum(t0.trade_amount) 总金额,
'线下理财' as 业务线
from BIDATA.S_S70_HRY_OFFLINE_TRADE_STATS t0
where t0.effective_time < to_date(20170101,'yyyymmdd')
;

