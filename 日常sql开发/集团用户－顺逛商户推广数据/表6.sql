WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME VER_STATE
,t1.kjtid
,t1.CTIME created_time
,decode(t1.emp_type,'内部员工','海尔员工','非海尔员工') member_type
from bidim.OBJ_SHUNGUANG_HRY_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
)
,
TMP_USER_FIRST_TRADE AS (
SELECT
S0.KJTID
,MIN(S0.RPTDT) FRIST_TRADE_DATE
FROM BIDATA.BI_USER_EXCHANGE S0
WHERE S0.RESYSTEMID != 'KJT'
GROUP BY S0.KJTID
)
---注册用户数
SELECT
'注册用户数' as flag
,s0.member_type
,COUNT(*) 用户数
FROM TMP_USER S0
where TO_CHAR(S0.created_time,'YYYYMM')='201705'
group by '注册用户数'
,s0.member_type
---- 认证用户数
UNION all
SELECT
'认证用户数' as flag
,s0.member_type
,COUNT(*) 用户数
FROM TMP_USER S0
LEFT JOIN BIDATA.S_S61_T6141 S1
ON S0.HRYID=S1.F01
where TO_CHAR(S1.F10,'YYYYMM')='201705'
group by '认证用户数'
,s0.member_type
UNION all
---- 交易用户数
SELECT 
'交易用户数' as flag
,s0.member_type
,COUNT(S1.KJTID) USER_COUNT
FROM TMP_USER S0
INNER JOIN TMP_USER_FIRST_TRADE S1
ON S0.KJTID=S1.KJTID
LEFT JOIN BIDIM.DIM_DATE S2
ON S1.FRIST_TRADE_DATE=S2.DATE_KEY
where s2.the_month='201705'
GROUP BY '交易用户数'
,s0.member_type
;