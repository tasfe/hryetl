select 
T.b_category,
count(distinct(T.hryid)) invest_user_count,
sum(T.amt)/10000 total_invest_amt
from (
select 
t0.f03 hryid,
t1.CATEGORY_DISPLAY_NAME b_category,
t0.f05 amt,
t0.f06 invest_time
from  bidata.S_S62_T6250 t0
left join V_BID_CATEGORY_VC t1
on t0.f02=t1.bid
where t0.F07='F' --- 未取消
) T
where T.invest_time < to_date(20170401,'yyyymmdd')
group by T.b_category
;

--------- 基金到截止时间 的 累计投资用户和 金额
select 
count(distinct(T.kjt_cust_id)) invest_user_count,
sum(T.amt)/10000 total_invest_amt
from (
select 
t0.trans_amt/100 amt,
t0.kjt_cust_id,
t0.update_time invest_time
from funduser.t_fund_share_order@FDB t0
where t0.trans_type='I' and t0.status=5
) T
where T.invest_time < to_date(20170401,'yyyymmdd')
;


---- 线下理财
select 
sum(t0.trade_amount)/10000 总金额,
'线下理财' as 业务线
from BIDATA.S_S70_HRY_OFFLINE_TRADE_STATS t0
where t0.effective_time < to_date(20170401,'yyyymmdd')
;

------ 海宝
select
max(t0.TOTAL_DEAL)/10000
from s_s71_HB_INFOMATION t0
order by  t0.UPDATE_TIME desc
;