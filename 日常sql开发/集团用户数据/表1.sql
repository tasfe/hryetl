----- 注册认证用户
WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME
from bidim.obj_hair_group_staff_phone_m5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
)

SELECT
S0.AUTHENT_STATUS_NAME
,COUNT(*) USER_COUNT
FROM TMP_USER S0
GROUP BY S0.AUTHENT_STATUS_NAME
;


---- 有投资的用户
WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME
,t1.kjtid
from bidim.obj_hair_group_staff_phone_m5 t0

inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
)

SELECT
'P2P投资' as flag
,COUNT(*) USER_COUNT
FROM TMP_USER S0
inner join bidata.dm_user_order_p2p_first s1
on s0.hryid=s1.hryid
where s1.date_key<20170601
group by 'P2P投资'
UNION all
SELECT
'P2P投资和天天聚' as flag
,COUNT(DISTINCT s0.kjtid) user_count
FROM TMP_USER S0
INNER JOIN BIDATA.BI_USER_EXCHANGE S1
ON S0.kjtid=S1.KJTID
where s1.rptdt<20170601 and S1.RESYSTEMID != 'KJT'
group by 'P2P投资和天天聚'
;
