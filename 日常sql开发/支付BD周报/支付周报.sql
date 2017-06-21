select
t0.*,
decode(t1.member_type,1,'个人','企业')
from tss.t_trade_order@kjtdb t0
left JOIN member.tm_member@kjtdb t1
on t0.seller_id=t1.member_id
where t0.trade_voucher_no ='102148620162224165049'
;

select
T.payer_type,
T.status,
count(*),
sum(T.trade_amount) 交易金额
from (
select 
t0.*,
t1.payer_type
from tmp_pay_trans_to_account t0
left join (
select
t0.trade_voucher_no,
decode(t1.member_type,1,'个人','企业') payer_type
from tss.t_trade_order@kjtdb t0
left JOIN member.tm_member@kjtdb t1
on t0.buyer_id=t1.member_id
) t1
on t0.trade_voucher_no=t1.trade_voucher_no
) T
GROUP BY T.payer_type,T.status
;

-----
 select 
 t0.pay_mode,
 decode(t0.STATUS,'支付成功','支付成功','未支付') status,
 count(*),
 sum(t0.TRADE_AMOUNT)
 from tmp_PAY_trade t0
 group by t0.pay_mode,decode(t0.STATUS,'支付成功','支付成功','未支付')
 ORDER BY t0.pay_mode,decode(t0.STATUS,'支付成功','支付成功','未支付')
 ;
