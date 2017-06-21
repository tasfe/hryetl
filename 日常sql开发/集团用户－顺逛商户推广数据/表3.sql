WITH TMP_staff_USER AS (
select
t1.HRYID hryid
from bidim.obj_hair_group_staff_phone_m5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
)


select
t1.HRYID 海融易ID
,t0.phone 工作手机号
,t1.ctime 注册时间
,t1.AUTHENT_STATUS_NAME 认证状态
,decode(t2.hryid,NULL,'非海尔员工','海尔员工')
from bidim.OBJ_SHUNGUANG_HRY_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
left join TMP_staff_USER t2
on t1.hryid=t2.hryid
where t1.CTIME < to_date('20170601','yyyymmdd')