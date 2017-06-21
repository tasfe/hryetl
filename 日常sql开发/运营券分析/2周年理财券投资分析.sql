select 
T.id 券ID,
T.COUPON_VALUE/100 "面额(元)",
T.USER_ID 券所有者海融易id,
T.COMMENTS 券备注,
T.USAGE_COMMENTS 使用备注,
t2.coupon_status 券状态,
t2.ACTION_TIME 使用时间,
t2.t_type 操作类型,
t2.bid 投资标的id,
t2.total_value 总投资额,
t2.pay_value 现金支付金额,
t2.tzq_value 投资券金额,
t2.lcj_value 理财金金额
from 
s_promo_coupon T 
left join (
  select
  t0.coupon_id,
  decode(t0.status,1,'有效',0,'失效') coupon_status,
  t0.ACTION_TIME,
  decode(t0.transaction_type,1,'消费',2,'退款') t_type,
  t1.f02 hry_id,
  t1.f03 bid,
  t1.f04 total_value,
  t1.f06 pay_value,
  t1.INVEST_COUPON_AMOUNT tzq_value,
  t1.f07 lcj_value
  from 
  s_promo_coupon_consumption t0
  left join s_s65_t6504 t1
  on t0.transaction_id=t1.f01
) t2
on T.ID=t2.COUPON_ID
where T.COMMENTS ='海融易2周年庆'
order by T.COUPON_VALUE desc,t2.ACTION_TIME ASC;
-----

select 
T.COUPON_VALUE/100 "面额(元)",
decode(t2.t_type,1,'消费',2,'退款','未使用') 操作类型,
count(*) 笔数,
to_char(sum(t2.pay_value),'FM999,999,999,999,999.90') 促发现金流水
-- sum(t2.pay_value) 促发现金流水
from 
s_promo_coupon T 
left join (
  select
  t0.coupon_id,
  decode(t0.status,1,'有效',0,'失效') coupon_status,
  t0.ACTION_TIME,
  t0.transaction_type t_type,
  t1.f02 hry_id,
  t1.f03 bid,
  t1.f04 total_value,
  t1.f06 pay_value,
  t1.INVEST_COUPON_AMOUNT tzq_value,
  t1.f07 lcj_value
  from 
  s_promo_coupon_consumption t0
  left join s_s65_t6504 t1
  on t0.transaction_id=t1.f01
) t2
on T.ID=t2.COUPON_ID
where T.COMMENTS ='海融易2周年庆'
group by T.COUPON_VALUE/100,t2.t_type
order by T.COUPON_VALUE/100 desc;