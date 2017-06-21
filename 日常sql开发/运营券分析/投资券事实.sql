with TMP_COUPON_GRANT_FACT AS (
select
t0.ID coupon_id,
(case when t0.DISTRIBUTION_SERIAL_NO is not null then '线上人工' when (t0.COMMENTS like '%BBS%' or t0.COMMENTS like '%海贝%' or t0.COMMENTS like '%海尔商城%') then '线下渠道'  else '线上活动' end) dis_channel_type
,t0.PROMOTION_ACTIVITY_ID ACTIVITY_ID
,t2.PROMOTION_ACTIVITY_NAME ACTIVITY_NAME,
nvl(t2.ACTIVITY_TYPE,(case when t0.COMMENTS like '%领券中心%' then 4 else NULL end)) ACTIVITY_TYPE_ID
,(case when t2.ACTIVITY_TYPE is not null then decode(t2.ACTIVITY_TYPE,1,'推广',2,'刮刮乐',3,'收益加速器',4,'领券中心',5,'唤醒用户',6,'回款奖励') when t0.COMMENTS like '%领券中心%' then '领券中心' else NULL end) ACTIVITY_TYPE_NAME
,t0.COUPON_CATEGORY_ID CATEGORY_ID
,t1.COUPON_NAME
--t1.COUPON_VALUE/100 营销券金额,
,t1.COUPON_TYPE COUPON_TYPE_ID
,decode(t1.COUPON_TYPE,1,'固定券',2,'动态券',3,'随机券') COUPON_TYPE_NAME
,t1.MIN_PAYMENT,
t1.PRODUCT_TYPES,
t1.MIN_PRODUCT_MATURITY,
t1.PLATFORM PLATFORM_ID,
decode(t1.PLATFORM,1,'全部',2,'海融易',3,'app',4,'海店通') PLATFORM_NAME,
t0.COUPON_NO,
t0.COUPON_VALUE/100 coupon_amt,
t0.STATE coupon_status_id,
decode(t0.STATE,1,'未激活',2,'激活',3,'已使用',4,'已过期') coupon_status_name,
t0.USER_ID OWNER_HRY_ID,
t0.COMMENTS,
t0.USAGE_COMMENTS,
t0.BATCH_NO,
t0.DISTRIBUTION_ID OP_DIS_SERIAL_BATCH_ID,
t0.DISTRIBUTION_SERIAL_NO OP_DIS_SERIAL_ID,
t0.STATUS RECORD_STATUS_ID,
decode(t0.STATUS,1,'有效',0,'失效') EFFECTIVE_STATUS_NAME,
t0.ACTIVATE_TIME,
t0.COUPON_GROUP_ITEM_ID,
t0.EFFECTIVE_DATE EFFECTIVE_TIME,
t0.EXPIRED_DATE EXPIRED_TIME,
t0.USAGE_TIME,
t0.CREATED_TIME,
t0.UPDATED_TIME
from bidata.s_promo_coupon t0
left join bidata.s_promo_coupon_category t1
on t0.COUPON_CATEGORY_ID=t1.ID
left join bidata.s_promo_promotion_activity t2
on t0.PROMOTION_ACTIVITY_ID=t2.ID
where t0.STATUS=1 --- 只看有效券
AND t0.ACTIVATE_TIME IS NOT NULL --- 只看有过激活
AND t0.USER_ID IS NOT NULL --- 只看绑定有用户
--AND (DISTRIBUTION_SERIAL_NO IS NULL AND t0.PROMOTION_ACTIVITY_ID IS NULL)
order by t0.ACTIVATE_TIME desc)



select
t0.dis_channel_type
,'发放激活' AS action_type
,t0.ACTIVITY_TYPE_NAME
,TO_CHAR(t0.ACTIVATE_TIME,'yyyymm') d_month,
sum(t0.coupon_amt) amt
from TMP_COUPON_GRANT_FACT t0
group by t0.dis_channel_type,'发放激活',t0.ACTIVITY_TYPE_NAME,TO_CHAR(t0.ACTIVATE_TIME,'yyyymm')
union all
select
t0.dis_channel_type
,'过期失效' AS action_type
,t0.ACTIVITY_TYPE_NAME
,TO_CHAR(t0.EXPIRED_TIME,'yyyymm') d_month,
sum(t0.coupon_amt) amt
from TMP_COUPON_GRANT_FACT t0
where t0.coupon_status_id=4 -- 过期
group by t0.dis_channel_type,'过期失效',t0.ACTIVITY_TYPE_NAME,TO_CHAR(t0.EXPIRED_TIME,'yyyymm')
union all
select
t0.dis_channel_type
,'已经使用' AS action_type
,t0.ACTIVITY_TYPE_NAME
,TO_CHAR(t0.USAGE_TIME,'yyyymm') d_month,
sum(t0.coupon_amt) amt
from TMP_COUPON_GRANT_FACT t0
where t0.coupon_status_id=3 -- 已经使用
group by t0.dis_channel_type,'已经使用',t0.ACTIVITY_TYPE_NAME,TO_CHAR(t0.USAGE_TIME,'yyyymm')
;
