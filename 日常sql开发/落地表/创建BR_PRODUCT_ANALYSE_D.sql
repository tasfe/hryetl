insert into BR_PRODUCT_ANALYSE_D
select date_key ,-- 购买日期,
    a.bid ,--标号,
    b.bid_name ,-- 标名,
    bid_type_name ,--标小类,
    parent_bid_type_name ,-- 标大类,
    product_amt ,--项目规模 ,
    year_profit*100||'%' year_profit,-- 预期年化收益,
    day_borrow_duration ,-- 借款周期天,
    status_name ,-- 标状态,
    b.issue_time ,-- 发布时间,
    b.full_time ,--满标时间,
    count(distinct a.order_id) count_orders,--投资笔数,
    count(distinct a.hryid) count_hryids,--投资用户数,
    sum(a.order_amount) amt_order,--投资金额,
    sum(a.pay_amount) amt_pay,--实际支付金额,
    sum(a.lcj_amount) lcj_amt,--使用理财金金额,
    count(distinct case when lcj_amount>0 then hryid else null end) lcj_hryids,--使用理财金用户数,
    count(distinct case when lcj_amount>0 then order_id else null end) lcj_orders,-- 使用理财金笔数,
    sum(a.invest_coupon_amount) tzj_amt,--使用投资券金额,
    count(distinct case when invest_coupon_amount>0 then hryid else null end) tzj_hryids,--使用投资券用户数,
    count(distinct case when invest_coupon_amount>0 then order_id else null end) tzj_orders,-- 使用投资券笔数,
    sum(repay_lx_amount) AMT_PRE_INTEREST --预估收益
from dm_order_p2p_ok a inner join dim_prod_p2p_list b on a.bid=b.bid
group by date_key ,a.bid ,b.bid_name ,bid_type_name ,parent_bid_type_name ,product_amt  ,year_profit ,day_borrow_duration ,status_name,issue_time ,full_time
order by date_key desc;

commit;