----------------------------------------------推广体系
select
t0.PROMOTED_ID hryid,
t2.KJTID,
t0.PROMOTER_ID,
( case 
  when t1.id is null then '个人推荐'
  else '第三方推广'
  end) pro_type,
NVL(t1.channel_name,'个人推荐') pro_source,
decode(t0.PLATFORM_ID,1,'海融易网站',2,'海融易APP',3,'海融易H5','其它') use_plat,
decode(t0.PROMOTION_SOURCE,1,'微信',2,'微博',3,'QQ',4,'短信',5,'邮件',6,'链接',7,'推广码',8,'收益加速','其它') pro_show_type,
decode(t0.ACTION_TYPE,1,'注册',2,'实名认证',3,'绑定银行卡',4,'购买') action_type,
t0.ACTION_TIME
from S_PROMO_PROMOTION_RELATION t0
left join s_s61_t6110 t2
on t0.PROMOTED_ID=t2.F01
left join S_PROMO_CHANNEL_INFO t1
on t0.PROMOTER_ID=t1.ID
order by t0.ACTION_TIME desc
;


select
T.user_source,
count(*)
from (
select
t2.f01 hryid,
t0.USER_ID kjtid,
t0.DEVICE_ID,
t0.CHANNEL download_market,
NVL(t1.PRO_SOURCE,t3.ADVERTISE_CHANNEL_NAME) user_source,
t0.LOG_TIME
from bi_login_h5_app t0
left join s_s61_t6110 t2
on t0.USER_ID=t2.KJTID
left join V_USER_SOURCE_PROMOTION t1
on t0.USER_ID=t1.KJTID
left join V_USER_SOURCE_DEVICE_COMPARE t3
on t0.USER_ID=t3.KJTID
where t0.event_type='register' and t0.event_status='success' and t0.rn=1
order by t0.LOG_TIME
) T
group by T.user_source
--where T.kjtid='100002152969' --  T.download_market='youmi'
;

select
*
from (
select
t2.f01 hryid,
t0.USER_ID kjtid,
t0.DEVICE_ID,
t4.SYS_NAME,
t4.SYS_VER,
t4.APP_VER,
t0.CHANNEL download_market,
(CASE when t1.PROMOTER_ID is not null then '内部推广系统' when t3.channel_id is not null then '外部系统比对' else '其它' end) static_system,
NVL(t1.PROMOTER_ID,NVL(t3.channel_id,-1)) promoter_id,
NVL(t1.PRO_SOURCE,t3.ADVERTISE_CHANNEL_NAME) promoter_name,
t0.ip_add,
t0.PROVINCE,
t0.city,
t0.LOG_TIME
from bi_login_h5_app t0
left join s_s61_t6110 t2
on t0.USER_ID=t2.KJTID
left join V_USER_SOURCE_PROMOTION t1
on t0.USER_ID=t1.KJTID
left join V_USER_SOURCE_DEVICE_COMPARE t3
on t0.USER_ID=t3.KJTID
left JOIN BI_DATA_COM t4
on t0.DEVICE_ID=t4.IDFA
where t0.event_type='register' and t0.event_status='success' and t0.rn=1
order by t0.LOG_TIME desc
) T
where T.user_source is NULL
;

select
*
from bi_login_h5_app t0
where t0.event_type='register' and t0.event_status='success' and t0.rn=1
and t0.user_id='100002416554'
;

select
*
from V_USER_SOURCE_DEVICE_COMPARE

select
*
from v_user_source_promotion t0

----------------------------------------------IDFA 比对体系
select 
t2.f01 hryid,
t0.USER_ID kjtid,
t0.DEVICE_ID,
t0.CHANNEL download_market,
decode(t1.CHANNEL_NAME,'appStore','normal_channel',t1.CHANNEL_NAME) advertise_channel_name,
t0.LOG_TIME
from bi_login_h5_app t0
LEFT JOIN ODS_CHANNEL_DEVICE_MSG t1
on t0.DEVICE_ID=t1.IDFA
left join s_s61_t6110 t2
on t0.USER_ID=t2.KJTID
where t0.event_type='register' and t0.event_status='success' and t0.rn=1 and t0.DEVICE_ID='A100004C07513C'
group by t2.f01,t0.USER_ID,t0.DEVICE_ID,t0.CHANNEL,decode(t1.CHANNEL_NAME,'appStore','normal_channel',t1.CHANNEL_NAME),t0.LOG_TIME
;

----------------------------------------------安装包分发
select
*
from bi_login_h5_app t0
where t0.event_type='register' 
      and t0.event_status='success' 
      and t0.rn=1 
      and t0.CHANNEL='youmi'
order by logtime desc
;

-------------------------

SELECT * FROM 
ODS_CHANNEL_DEVICE_MSG t1
WHERE t1.idfa='863181032520847';

select count(1) from (
select user_id,amt,time from (
select a.f01 user_id, b.f05 amt, b.f06 time, rank() over (partition by a.f01 order by b.f06 asc) rn
from s_s61_t6110 a inner join s_s62_t6250 b on a.f01 = b.f03 
where to_char(b.f06,'yyyymmdd') between 20161222 and 20170120
and b.f05 > 19999.9999
and to_char(a.f09,'yyyymmdd') between 20161222 and 20170120 
--and b.f05 between 5000 and 20000
)where rn = 1
