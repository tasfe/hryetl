select
to_char(t1.CREATED_TIME,'yyyy-MM-dd hh24:mm:ss') 领取时间,
to_char(t2.action_time,'yyyy-MM-dd hh24:mm:ss') 使用时间,
t1.USER_ID 海融易id,
t0.COUPON_VALUE/100 "面额(元)",
t2.total_value 投资总金额,
decode(t0.state,1,'未激活',2,'激活',3,'已使用',4,'已过期') 券状态
--- t0.id 券id,
--- to_char(t0.CREATED_TIME,'yyyy-MM-dd hh24:mm:ss') 创建时间
from s_promo_coupon t0
left join s_promo_grab_coupon_record t1
on t0.id=t1.REWARDS_VALUE
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
on t0.id=t2.COUPON_ID
where t0.COMMENTS like '%领券中心'
and t0.CREATED_TIME BETWEEN to_date('2016-12-31','yyyy-MM-dd') and to_date('2017-01-13','yyyy-MM-dd')
ORDER BY t1.CREATED_TIME asc;
