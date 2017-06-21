create table dm_prod_p2p_d as
select to_char(issue_time,'yyyymmdd') as date_key, --发布时间
count(1) count_bid ,-- 发标数,
count(distinct case when to_char(issue_time,'yyyymmdd')=to_char(full_time,'yyyymmdd') then bid else null end) curday_full_bids, -- 当天满标数,
sum(product_amt) project_amt, -- 募集项目规模,
round( sum(product_amt*year_profit*b.day_borrow_duration/365),2) amt_pre_interest --  预估收益 
from dim_prod_p2p_list b where status_name_id>=3
group by to_char(issue_time,'yyyymmdd')
order by date_key desc;