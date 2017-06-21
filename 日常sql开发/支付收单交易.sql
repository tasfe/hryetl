select 
t0.trade_voucher_no 交易凭证号,
t0.biz_product_code 产品码,
decode(t0.trade_type,01,'普通转账交易',11,'即时到账收单交易',12,'担保收单交易',13,'下订收单交易',14,'收单退款交易',15,'合并支付交易  由交易服务自动产生，网关不用关心',17,'代扣',18,'基金',19,'转账到卡') 交易类型,
t0.trade_amount 交易金额,
to_char(t0.gmt_submit,'yyyy-MM-dd hh24:mm:ss') 交易发起时间,
t0.buyer_id 付款方会员id,
t0.buyer_name 付款方名称,
decode(t2.member_type,1,'个人',2,'公司',3,'组织') 付款方会员类型,
t0.seller_id 收款方会员id,
t0.seller_name 收款方名称,
decode(t1.member_type,1,'个人',2,'公司',3,'组织') 收款方会员类型,
t0.partner_name 平台名称,
decode(t0.status,100,'申请成功',201,'支付成功',301,'结算发起成功',401,'结算成功',900,'退款初始',901,'退款申请成功 例银行未返回结果',951,'退款成功',952,'退款失败',998,'支付失败',999,'支付关闭') 交易状态,
t0.prod_desc 商品信息,
t3.pay_mode,
t3.pay_channel,
t3.memo
from tss.t_trade_order@kjtdb t0
left join member.tm_member@kjtdb  t1
on t0.seller_id = t1.member_id
left join member.tm_member@kjtdb  t2
on t0.buyer_id=t2.member_id
left join (
select 
p1.trade_voucher_no,
-- decode(p1.payment_type,01,'付款',02,'结算',03,'退结算',4,'退付款',5,'退结算回滚'),
p1.memo,
p2.pay_mode,
p2.pay_channel
from tss.t_payment_order@kjtdb p1
left join  tss.t_pay_method@kjtdb p2
on p1.payment_voucher_no=p2.payment_voucher_no
where p1.status='S' and p1.payment_type=02
) t3
on t0.trade_voucher_no=t3.trade_voucher_no
--- where t0.trade_type BETWEEN 10 and 14
where t0.trade_type = 11 
and t0.seller_id='200000601748'
and t0.status=401
and to_char(t0.gmt_submit,'yyyy-MM-dd')='2017-01-11'
order by t0.gmt_submit desc
;





select 
p1.trade_voucher_no,
-- decode(p1.payment_type,01,'付款',02,'结算',03,'退结算',4,'退付款',5,'退结算回滚'),
p1.memo,
p2.pay_mode,
p2.pay_channel
from tss.t_payment_order@kjtdb p1
left join  tss.t_pay_method@kjtdb p2
on p1.payment_voucher_no=p2.payment_voucher_no
where p1.status='S' and p1.payment_type=02;


select
* 
from tss.t_payment_order@kjtdb p1 
where p1.trade_voucher_no='101148421056985679668'


select 
distinct(t0.status)  
from tss.t_trade_order@kjtdb t0
order by t0.status asc
;

select 
distinct(t0.trade_type)  
from tss.t_trade_order@kjtdb t0
order by t0.trade_type asc
;