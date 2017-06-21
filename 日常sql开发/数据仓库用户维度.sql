select
t0.f01 hryid,
nvl(t1.promoter_id,t2.channel_id) promoter_id,
nvl(t1.pro_source,t2.advertise_channel_name) promoter_name,
nvl(t1.pro_type,t2.CHANNEL_TYPE) promoter_type,
t3.DOWNLOAD_MARKET,
t3.SYS_TYPE,
t3.ip_add,
t3.province,
t3.city
from bidata.s_s61_t6110 t0
left join V_USER_SOURCE_PROMOTION t1
on t0.f01=t1.HRYID
left join V_USER_SOURCE_DEVICE_COMPARE t2
on t0.f01=t2.HRYID
left join V_USER_SOURCE_REG_LOG t3
on t0.f01=t3.hryid
order by t0.created_time desc
;
