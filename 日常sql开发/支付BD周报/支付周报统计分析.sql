----------- 收单和转账交易
select
decode(t.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 支付方式,
decode(p.status,'S','支付成功','P','处理中','F','支付失败','其他状态') 交易状态,
count(p.payment_voucher_no) 订单笔数,
sum(p.amount) 交易金额
from tss.t_payment_order@kjtdb p
LEFT join tss.t_pay_method@kjtdb t
ON p.payment_voucher_no = t.payment_voucher_no
where p.gmt_submit between to_date('20170220','yyyymmdd') and to_date('20170227','yyyymmdd')
group by decode(t.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),
decode(p.status,'S','支付成功','P','处理中','F','支付失败','其他状态')
;


select
decode(t1.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 支付方式,
decode(t0.status,'S','支付成功','P','处理中','F','支付失败','其他状态') 交易状态,
count(t0.payment_voucher_no) 订单数,
sum(t0.amount) 交易金额
from tss.t_payment_order@kjtdb t0
inner join tss.t_pay_method@kjtdb t1
on t0.payment_voucher_no=t1.payment_voucher_no
where to_char(t0.gmt_submit,'yyyymm') between '20170220' and '20170226' ---=to_char(sysdate,'yyyymm')
group  by decode(t1.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),decode(t0.status,'S','支付成功','P','处理中','F','支付失败','其他状态')
;

select 
t1.DES 业务产品,
decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭') 交易状态,
count(t0.trade_voucher_no) 订单笔数
from tss.t_trade_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
where to_char(t0.gmt_submit ,'yyyymm')='201701'--to_char(sysdate,'yyyymm')
group by  t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
order by t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
;



select
distinct t.pay_mode
FROM tss.t_pay_method@kjtdb t
LEFT JOIN tss.t_payment_order@kjtdb p
ON p.payment_voucher_no = t.payment_voucher_no
;



---- 充值交易
select
decode(t.trade_status,'S','支付成功','P','处理中','F','支付失败','其他状态') 交易状态,
count(t.trade_voucher_no) 订单笔数,
sum(t.amount) 交易金额
from deposit.t_deposit_order@kjtdb t
where t.gmt_submit between to_date('20170213','yyyymmdd') and to_date('20170220','yyyymmdd')
group by decode(t.trade_status,'S','支付成功','P','处理中','F','支付失败','其他状态')
;



------ 提现交易
select
decode(t0.status,'bankSuccess','提现成功','提现失败') 交易状态,
count(t0.fundout_order_no) 订单笔数,
sum(t0.amount) 交易金额
from FOS.TT_FUNDOUT_ORDER@kjtdb t0
where  t0.PRODUCT_CODE in (10210,10211) ---产品码含义:10210 提现T+N ,10211 提现实时
AND t0.order_time between to_date('20170220','yyyymmdd') and to_date('20170227','yyyymmdd')
group by decode(t0.status,'bankSuccess','提现成功','提现失败')
;


select
decode(t0.trade_status,'P','未支付','S','支付成功') 订单状态,
count(t0.trade_voucher_no) 订单笔数,
sum(t0.amount) 交易金额
from deposit.t_deposit_order@kjtdb t0
where t0.gmt_submit BETWEEN to_date('20170220','yyyymmdd') and to_date('20170227','yyyymmdd')
group by decode(t0.trade_status,'P','未支付','S','支付成功')
;

--- 转账到账户
select
decode(t1.member_type,1,'个人','企业') 会员类型,---,3,'特约商户'
decode(t0.status,'401','已支付','未支付') 交易状态,---'100','申请成功','998','支付失败','999','支付关闭','其它状态') 交易状态,
count(*) 订单笔数,
sum(t0.trade_amount) 交易金额
FROM tss.t_trade_order@kjtdb t0
left join member.tm_member@kjtdb t1
on t0.buyer_id=t1.member_id
WHERE t0.biz_product_code IN ('10310', '10231') and to_char(t0.gmt_submit,'yyyymmdd') between '20170220' and '20170226'
group by decode(t1.member_type,1,'个人','企业'),decode(t0.status,'401','已支付','未支付')
;

---- 转账到卡
select
decode(t0.status,'bankSuccess','交易成功','交易失败') 交易状态,

--t0.status,---decode(t0.status,'401','已支付','未支付') 交易状态,---'100','申请成功','998','支付失败','999','支付关闭','其它状态') 交易状态,
count(*) 订单笔数,
sum(t0.amount) 交易金额
FROM fos.tt_fundout_order@kjtdb t0
WHERE t0.product_code IN ('10220', '10230') and to_char(t0.order_time,'yyyymmdd') between '20170220' and '20170226'
group by decode(t0.status,'bankSuccess','交易成功','交易失败')
;

--- 退款
select
decode(t.status,'951','退款成功','952','退款失败') 退款状态,
count(*) 订单笔数,
sum(trade_amount) 交易金额
FROM tss.t_trade_order@kjtdb t
WHERE t.status IN ('951', '952')
group by decode(t.status,'951','退款成功','952','退款失败')
;


select
*
from FOS.TT_FUNDOUT_ORDER@kjtdb t0
;

select
*
from tss.t_payment_order@kjtdb p
;



------ 转账到账户
select
decode(t0.member_type,1,'个人','2','企业','3','特约商户','其他类型') 付款用户类型,
decode(t.status,'401','转帐成功','100','申请成功','998','支付失败','999','支付关闭','其他状态') 交易状态,
count(t.trade_voucher_no) 订单笔数,
sum(t.trade_amount) 交易金额
FROM tss.t_trade_order@kjtdb t
left join member.tm_member@kjtdb t0
on t.buyer_id=t0.member_id
WHERE t.biz_product_code IN ('10310', '10231') ---- 产品码含义:10310 会员转账 ,10231 代发工资到账户
and t.gmt_submit between to_date('20170213','yyyymmdd') and to_date('20170220','yyyymmdd')
group by decode(t0.member_type,1,'个人','2','企业','3','特约商户','其他类型'),decode(t.status,'401','转帐成功','100','申请成功','998','支付失败','999','支付关闭','其他状态')
;


---基金
select
t0.status,
count(*),
sum(t0.trans_amt)
from fund.t_fund_share_order@FDB t0
where t0.trans_type='I' and t0.
group by t0.status
;

select
t0.status,
count(*),
sum(t0.trans_amt)
from fund.t_fund_share_order@FDB t0
where t0.trans_type='O'
group by t0.status
;
