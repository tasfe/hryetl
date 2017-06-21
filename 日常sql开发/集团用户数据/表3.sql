select
t1.HRYID 海融易ID
,t0.phone 工作手机号
,t1.ctime 注册时间
,t1.AUTHENT_STATUS_NAME 认证状态
from bidim.OBJ_HAIR_GROUP_STAFF_PHONE_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd');
