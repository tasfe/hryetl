insert into BR_ORDER_ANALYSE_D
select date_key as date_key, --购买日期,
    count(distinct bid) count_p, --购标数,
    count(distinct hryid)  count_hryids,--投资用户数,
    count(1) count_orders,--投资笔数 ,
    sum(order_amount) amt_order,--投资金额,
    sum(pay_amount) amt_pay,--实际支付金额,
    sum(lcj_amount) lcj_amt,--使用理财金金额,
    count(distinct case when lcj_amount>0 then hryid else null end) lcj_hryids,--使用理财金用户数, 
    count(distinct case when lcj_amount>0 then order_id else null end) lcj_orders,--使用理财金笔数,
    sum(invest_coupon_amount) tzj_amt,--使用投资券金额,
    count(distinct case when invest_coupon_amount>0 then hryid else null end) TZJ_HRYIDS,-- 使用投资券用户数,
    count(distinct case when invest_coupon_amount>0 then order_id else null end) TZJ_ORDERS,-- 使用投资券笔数,
    sum(repay_lx_amount) AMT_PRE_INTEREST -- 预估收益
from dm_order_p2p_ok -- where date_key is not null
group by date_key
order by date_key desc;