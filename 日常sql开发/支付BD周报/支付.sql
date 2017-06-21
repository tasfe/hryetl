----------------------  转账 和 收单
select
decode(t1.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 支付方式,
decode(t0.status,'S','支付成功','P','处理中','F','支付失败','其他状态')支付状态,
count(t0.payment_voucher_no) 订单数,
sum(t0.amount) 交易金额
from tss.t_payment_order@kjtdb t0
inner join tss.t_pay_method@kjtdb t1
on t0.payment_voucher_no=t1.payment_voucher_no
where to_char(t0.gmt_submit,'yyyymm')=to_char(sysdate,'yyyymm')
group  by decode(t1.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),decode(t0.status,'S','支付成功','P','处理中','F','支付失败','其他状态')
;

---------------------- 出款
select
decode(t0.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 支付方式,
decode(t0.PAYMENT_STATUS,'P','处理中','S','支付成功','F','支付失败','其它状态') 支付状态,
count(*) 交易笔数,
sum(t0.amount) 交易金额
from fos.tt_fundout_order@kjtdb t0
where to_char(t0.GMT_PAY_SUBMIT ,'yyyymm')=to_char(sysdate,'yyyymm')
group by decode(t0.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),decode(t0.PAYMENT_STATUS,'P','处理中','S','支付成功','F','支付失败','其它状态')
;






---------------------- 充值
select
decode(t0.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 支付方式,
decode(t0.PAYMENT_STATUS,'P','处理中','S','支付成功','F','支付失败','其它状态') 支付状态,
count(*) 交易笔数,
sum(t0.amount) 交易金额
from deposit.t_payment_order@kjtdb t0
where to_char(t0.GMT_PAY_SUBMIT ,'yyyymm')=to_char(sysdate,'yyyymm')
group by decode(t0.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),decode(t0.PAYMENT_STATUS,'P','处理中','S','支付成功','F','支付失败','其它状态')
;