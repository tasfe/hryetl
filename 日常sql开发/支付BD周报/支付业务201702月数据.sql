/**
 非余额支付-收单类交易
**/
select t.biz_product_code 业务产品编码,
(select t1.memo from payment.tb_biz_product_map@kjtdb t1 where t1.biz_product_code=t.biz_product_code) 业务产品名称,
decode(t6.pay_mode,'FUNDSHARE_PAY','基金支付','ONLINE_BANK','网银支付','QPAY','快捷支付','BALANCE','余额支付','TRUST_COLLECT','代扣支付','QRCODE','二维码支付',  t6.pay_mode) 支付方式,
decode(t4.order_type,'I','入款','B','退款','O','代发退款',t4.order_type) 支付类型,
decode(t.trade_type, '01', '普通转账交易', '11', '即时到账收单交易', '12', '担保收单交易', '13', '下订收单交易', '14', '收单退款交易', '15', '合并支付', '16', '话费充值', '17', '银行卡代扣交易', '18', '基金份额交易', TRADE_TYPE) as 交易类型,
count(1) 订单数,
sum(t.trade_amount) 订单金额,
sum(decode(t2.status,'S',1,0)) 交易数,
sum(decode(t2.status,'S',t.trade_amount,0)) 交易金额
from tss.t_trade_order@kjtdb t
join  tss.t_payment_order@kjtdb t2 on t.trade_voucher_no = t2.trade_voucher_no
join payment.tb_payment_order@kjtdb t3 on t2.payment_voucher_no = t3.payment_order_no
join cmf.tt_cmf_order@kjtdb t4 on t3.payment_seq_no = t4.payment_seq_no
join cmf.tt_inst_order@kjtdb t5 on t4.inst_order_id = t5.inst_order_id
join cmf.tm_fund_channel@kjtdb t6 on t5.fund_channel_code = t6.fund_channel_code
 where  t.gmt_submit >= to_date('2017-02-01','yyyy-mm-dd') and t.gmt_submit < to_date('2017-03-01','yyyy-mm-dd')
group by t.biz_product_code,t6.pay_mode,t4.order_type,t.trade_type
;



/**
 余额支付-收单交易
**/
select t.biz_product_code 业务产品编码,
(select t1.memo from payment.tb_biz_product_map@kjtdb t1 where t1.biz_product_code=t.biz_product_code) 业务产品名称,
'余额支付' 支付方式,
'收单入款' 支付类型,
decode(t.trade_type, '01', '普通转账交易', '11', '即时到账收单交易', '12', '担保收单交易', '13', '下订收单交易', '14', '收单退款交易', '15', '合并支付', '16', '话费充值', '17', '银行卡代扣交易', '18', '基金份额交易', TRADE_TYPE) as 交易类型,
count(1) 订单数,
sum(t.trade_amount) 订单金额,
sum(decode(t2.status,'S',1,0)) 交易数,
sum(decode(t2.status,'S',t.trade_amount,0)) 交易金额
from tss.t_trade_order@kjtdb t,  tss.t_payment_order@kjtdb t2 , payment.tb_biz_payment_order@kjtdb t3
 where  t.gmt_submit >= to_date('2017-02-01','yyyy-mm-dd') and t.gmt_submit < to_date('2017-03-01','yyyy-mm-dd')
          and t.trade_type!='01'
         and t.trade_voucher_no = t2.trade_voucher_no and t2.payment_type in ('01','04')
         and t2.payment_voucher_no = t3.payment_order_no and t3.biz_payment_type='BL'
group by t.biz_product_code,t.trade_type
;


/**
 普通转账交易
**/
select 
t.biz_product_code 业务产品编码,
(select t1.memo from payment.tb_biz_product_map@kjtdb t1 where t1.biz_product_code=t.biz_product_code) 业务产品名称,
'余额支付' 支付方式,
'转账出款' 支付类型,
'普通转账交易' 交易类型,
count(1) 订单数,
sum(t.trade_amount) 订单金额,
sum(decode(t.status,'401',1,'951',1,0)) 交易数,
sum(decode(t.status,'401',t.trade_amount,'951',t.trade_amount,0)) 交易金额
from tss.t_trade_order@kjtdb t
 where  t.gmt_submit >= to_date('2017-02-01','yyyy-mm-dd') and t.gmt_submit < to_date('2017-03-01','yyyy-mm-dd')
         and t.trade_type = '01'
group by t.biz_product_code
;

/**
 出款类交易
**/
select 
t.product_code 业务产品编码,
(select t1.memo from payment.tb_biz_product_map@kjtdb t1 where t1.biz_product_code=t.product_code) 业务产品名称,
'余额支付' 支付方式,
'出款' 支付类型,
'出款' 交易类型,
count(1) 订单数,
sum(t.amount) 订单金额,
sum(decode(t.status,'bankSuccess',1,0)) 交易数,
sum(decode(t.status,'bankSuccess',t.amount,0)) 交易金额
from fos.tt_fundout_order@kjtdb t
where  t.gmt_create >= to_date('2017-02-01','yyyy-mm-dd') and t.gmt_create < to_date('2017-03-01','yyyy-mm-dd')
group by t.product_code
;