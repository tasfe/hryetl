select
t0.sid,
t0.network,
t0.network_manager,
t0.log_time,
t0.channel,
t0.user_id,
t0.sys_name,
t0.ip_add,
t0.app_version,
t0.event_type,
t0.event_status,
t0.event_desc,
t0.event_context,
t0.country,
t0.province,
t0.city,
t1.*
from BI_LOG t0
left join (
  select
  tt0.idfa cdevice_id,
  tt0.SYS_NAME,
  tt0.SYS_VER,
  tt0.APP_ID,
  tt0.APP_VER,
  tt0.DEVICE_NAME,
  tt0.CHANNEL_ID,
  tt1.ACTION,
  tt1.key,
  tt1.subkey,
  tt1.value
  from bi_data_com tt0
  left join bi_data_event tt1
  on tt0.id=tt1.com_id
  
) t1
on t0.device_id=t1.cdevice_id
where t0.DEVICE_ID is not null and t0.log_time > to_date('2016-12-01','yyyy-MM-dd')