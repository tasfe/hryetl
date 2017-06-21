--------------------- 充值类交易
select
t1.DES 业务产品,
decode(t0.trade_status,'P','处理中','S','交易成功','其它状态') 交易状态,
count(*) 交易笔数,
sum(t0.amount) 交易金额
from deposit.t_deposit_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
where to_char(t0.gmt_submit ,'yyyymm')=to_char(sysdate,'yyyymm')
group by t1.DES,decode(t0.trade_status,'P','处理中','S','交易成功','其它状态')
;

select
*
from deposit.t_deposit_order@kjtdb t0
;
select
distinct(t0.access_channel)
from deposit.t_deposit_order@kjtdb t0
;



