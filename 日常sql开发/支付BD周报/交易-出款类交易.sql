--------------------- 出款类交易
select
t1.DES 业务产品,
t0.status 交易状态,
count(*) 交易笔数,
sum(t0.amount) 交易金额
from FOS.TT_FUNDOUT_ORDER@kjtdb t0
left join bidim.obj_pay_product t1
on t0.product_code=t1.business_product_code
where to_char(t0.order_time ,'yyyymm')=to_char(sysdate,'yyyymm')
group by t1.DES,t0.status
;

select
distinct t0.product_code
from FOS.TT_FUNDOUT_ORDER@kjtdb t0

;

select
*
from member.tm_member@kjtdb t0
where t0.member_id='100001848296'


-- 提现交易
select
count(*) 交易笔数,
sum(t0.amount) 交易金额
from fos.tt_fundout_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.product_code=t1.business_product_code
where to_char(t0.GMT_PAY_SUBMIT ,'yyyymm')=to_char(sysdate,'yyyymm') and t1.product_code='10030001'
group by decode(t0.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式'),decode(t0.PAYMENT_STATUS,'P','处理中','S','支付成功','F','支付失败','其它状态')
;

-- 代发工资
select
t0.MEMBER_ID,
t2.B_NAME,
t2.MEMBER_TYPE,
t2.ECOLOGY_TYPE,
t2.group_type,
t1.des,
t0.status,
count(*) 交易笔数,
sum(t0.amount) 交易金额
from fos.tt_fundout_order@kjtdb t0
left join bidim.obj_pay_product t1
on t0.product_code=t1.business_product_code
left join bidata.v_business_tag t2
on t0.MEMBER_ID=t2.MEMBER_ID
where to_char(t0.order_time ,'yyyymm')=to_char(sysdate,'yyyymm') and t0.product_code in ('10230','10231')
group by t0.MEMBER_ID,t2.B_NAME,t2.MEMBER_TYPE,t2.ECOLOGY_TYPE,t2.group_type,t1.des,t0.status
;

select
distinct(t0.status)
from fos.tt_fundout_order@kjtdb t0
;

select
distinct t0.product_code
from fos.tt_fundout_order@kjtdb t0
;

select
*
from fos.tt_fundout_order@kjtdb t0
;

