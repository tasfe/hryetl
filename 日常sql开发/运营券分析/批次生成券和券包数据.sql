--------
select
(t0.COUPON_VALUE/100) 券面额
,count(*) 总张数
,count(t0.ACTIVATE_TIME) 已激活
,count(t0.USAGE_TIME) 已使用
from bidata.s_promo_coupon t0
where t0.batch_no in ('201702280001','201702280002','201702280003','201702280004','201702280005','201702280006')
group by (t0.COUPON_VALUE/100)
;
-------
select
t0.BATCH_NO 批次
,t0.COMMENTS 券包说明
,(t1.COUPON_VALUE/100) 券面额
,count(t1.ACTIVATE_TIME) 激活券数量
,count(t1.USAGE_TIME) 使用券数量
from S_PROMO_COUPON_GROUP_ITEM t0
inner join s_promo_coupon t1
on t0.ID=t1.COUPON_GROUP_ITEM_ID
where t0.BATCH_NO in ('201702280001','201702280002','201702280006')
group by t0.BATCH_NO,t0.COMMENTS,(t1.COUPON_VALUE/100)
;

-----