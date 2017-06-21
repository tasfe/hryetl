-------------------- 转账 收单类交易
select 
t1.DES 业务产品,
decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭') 交易状态,
count(t0.trade_voucher_no) 交易笔数,
sum(t0.TRADE_AMOUNT) 交易金额
from tss.t_trade_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
where to_char(t0.gmt_submit ,'yyyymm')=to_char(sysdate,'yyyymm')
group by  t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
order by t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
;


-------------------- 收单 交易
select 
t1.DES 业务产品,
decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭') 交易状态,
count(t0.trade_voucher_no) 交易笔数,
sum(t0.TRADE_AMOUNT) 交易金额
from tss.t_trade_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
where to_char(t0.gmt_submit ,'yyyymm')=to_char(sysdate,'yyyymm') and t1.product_code='20040001' ---- 收单交易产品码
group by  t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
order by t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
;

select 
t0.seller_id 收款会员id,
t2.B_NAME,
t2.MEMBER_TYPE,
t2.ECOLOGY_TYPE,
t2.group_type,
t1.DES 业务产品,
decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭') 交易状态,
count(t0.trade_voucher_no) 交易笔数,
sum(t0.TRADE_AMOUNT) 交易金额
from tss.t_trade_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
left join bidata.v_business_tag t2
on t0.seller_id=t2.MEMBER_ID
where to_char(t0.gmt_submit ,'yyyymm')=to_char(sysdate,'yyyymm') and t1.product_code='20040001' and t0.biz_product_code!='90111'---- 收单交易产品码
group by 
t0.seller_id,
t2.B_NAME,
t2.MEMBER_TYPE,
t2.ECOLOGY_TYPE,
t2.group_type,
t1.DES,
decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
order by t0.seller_id,t2.B_NAME,t1.DES,decode(t0.status,'100','申请成功','201','支付成功','301','结算发起成功','401','结算成功','900','退款初始','901','退款申请成功 例银行未返回结果','951','退款成功','952','退款失败','998','支付失败','999','支付关闭')
;

select
*
from tss.t_trade_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.biz_product_code=t1.business_product_code
left join bidata.v_business_tag t2
on t0.seller_id=t2.MEMBER_ID
where to_char(t0.ORDER_TIME ,'yyyymm')=to_char(sysdate,'yyyymm') and t1.product_code='20040001' and t0.seller_id='100001917895'
