WITH TMP_LCJ_FACT_DW AS (
  select
  t0.record_id
  ,t0.dis_channel_type
  ,t0.ACTIVITY_ID
  ,t0.ACTIVITY_TYPE_ID
  ,t0.ACTIVITY_TYPE_NAME
  ,t0.REWARDS_AMT
  ,t0.GIVEN_TIME
  ,t0.OP_DIS_TIME
  ,t0.OP_DIS_SERIAL_ID
  ,t0.EFFECTIVE_TIME
  ,t0.EXPIRED_TIME
  ,t0.USE_TIME
  ,t0.USE_COMMENTS
  ,t0.REWARDS_STATUS_ID
  ,t0.REWARDS_STATUS_NAME
  ,t1.*
  from (
    select 
    s0.id record_id
    ,(case when s0.SERIAL_ID is not null then '线上人工' else '线上活动' end) dis_channel_type
    ,s0.PROMOTION_ACTIVITY_ID ACTIVITY_ID
    ,s1.PROMOTION_ACTIVITY_NAME ACTIVITY_NAME
    ,s1.ACTIVITY_TYPE ACTIVITY_TYPE_ID
    ,decode(s1.ACTIVITY_TYPE,1,'推广',2,'刮刮乐',3,'收益加速器',4,'领券中心',5,'唤醒用户',6,'回款奖励') ACTIVITY_TYPE_NAME
    ,s0.REWARDS/100 REWARDS_AMT
    ,s0.GIVEN_ID
    ,s0.GIVEN_TIME
    ,s0.REWARD_DIS_ID OP_DIS_TIME
    ,s0.SERIAL_ID OP_DIS_SERIAL_ID
    ,s0.EFFECTIVE_TIME
    ,s0.EXPIRED_TIME
    ,s0.USE_TIME
    ,s0.USE_COMMENTS
    ,s0.REWARDS_STATUS REWARDS_STATUS_ID
    ,decode(s0.REWARDS_STATUS,1,'正常',2,'已使用',3,'已过期') REWARDS_STATUS_NAME
    from BIDATA.S_PROMO_REWARDS s0
    left join BIDATA.S_PROMO_PROMOTION_ACTIVITY s1
    on s0.PROMOTION_ACTIVITY_ID=s1.ID
  ) t0
  left join (
    select
    t0.F01 reocrd_id
    ,t1.F02 owner_hry_id
    ,t0.F05 create_time
    ,t0.F06 trade_in_amt
    ,t0.F07 trade_out_amt
    ,t0.F08 balance
    ,t0.F09 comments
    ,t0.F10 statement_code
    ,decode(t0.F10,'WDZ','未对账','YDZ','已对账') statement_name
    ,t0.F11 statement_time
    ,t0.EXPIREDDATE expire_time
    ,t0.USAGECOMMENTS usage_comments
    ,t0.DISPLAYTAG reward_status_code
    ,decode(t0.DISPLAYTAG,'YSY','已使用','WSY','未使用','YGQ','已过期','LSSJCZ','历史数据冲正','LSSJGJ','历史数据归集','SYCZ','使用冲正','GQCZ','过期冲正','WXJL','无效奖励','WYY','无意义') reward_status_name
    ,t0.REMINDSMSFLAG notify_status_code
    ,decode(t0.REMINDSMSFLAG,'WFS','未发送','YFS','已发送') notify_status_name
    ,t0.UPDATEDTIME update_time
    from bidata.s_s61_t6102 t0
    inner join bidata.s_s61_t6101 t1
    on t0.F02=t1.F01
    left join bidata.s_s51_t5122 t2
    on t0.F03=t2.f01
  ) t1
  on t0.GIVEN_ID=t1.reocrd_id
  where t0.GIVEN_TIME>TO_DATE('20160101','yyyymmdd')
)

select
T.dis_channel_type
,T.activity_type_name
,'发放' AS action_type
,to_char(T.GIVEN_TIME,'yyyymm') d_month
,sum(T.rewards_amt) amt
from TMP_LCJ_FACT_DW T
group by T.dis_channel_type,'发放',T.activity_type_name,to_char(T.GIVEN_TIME,'yyyymm')
union all
select
T.dis_channel_type
,T.activity_type_name
,'过期' AS action_type
,to_char(T.EXPIRED_TIME,'yyyymm') d_month
,sum(T.rewards_amt) amt
from TMP_LCJ_FACT_DW T
where T.reward_status_code='YGQ'
group by T.dis_channel_type,'过期',T.activity_type_name,to_char(T.EXPIRED_TIME,'yyyymm')
union all
select
T.dis_channel_type
,T.activity_type_name
,'使用' AS action_type
,to_char(T.USE_TIME,'yyyymm') d_month
,sum(T.rewards_amt) amt
from TMP_LCJ_FACT_DW T
where T.reward_status_code='已使用'
group by T.dis_channel_type,'使用',T.activity_type_name,to_char(T.USE_TIME,'yyyymm')
;
