select
*
from bidata.bi_daily_tasks
where id=8
;


"SELECT f.kjt_cust_id KJTID,'FUND' RESYSTEMID, '${start_date}' rptdt FROM FUNDUSER.T_FUND_SHARE_ORDER@FDB F where f.req_date= '${start_date}' AND F.STATUS='05'

UNION ALL 

SELECT DISTINCT C.MEMBER_ID KJTID,'KJT' RESYSTEMID, '${start_date}' rptdt   FROM DPM.T_DPM_OUTER_ACCOUNT_DETAIL@KJTDB A
INNER JOIN DPM.T_DPM_OUTER_ACCOUNT@KJTDB B ON B.ACCOUNT_NO = A.ACCOUNT_NO
and a.accounting_date= '${start_date}'
INNER JOIN MEMBER.TM_MEMBER@KJTDB C ON C.MEMBER_ID = B.MEMBER_ID 

UNION ALL 

SELECT DISTINCT H.KJTID KJTID,'HRY' RESYSTEMID, '${start_date}' rptdt FROM BI_HRY_EXCHANGE_LIST H where to_char(h.fshtime,'yyyymmdd')= '${start_date}'
and h.orderstatus='成功'  "


-----
select 
count(distinct(t0.kjtid))
from bidata.bi_user_exchange t0
where t0.kjtid not in (
SELECT 
DISTINCT(C.MEMBER_ID) KJTID 
FROM DPM.T_DPM_OUTER_ACCOUNT_DETAIL@KJTDB A
INNER JOIN DPM.T_DPM_OUTER_ACCOUNT@KJTDB B 
ON B.ACCOUNT_NO = A.ACCOUNT_NO
INNER JOIN MEMBER.TM_MEMBER@KJTDB C ON C.MEMBER_ID = B.MEMBER_ID
)
;

-----
select 
count(distinct(t0.kjtid))
from bidata.BI_HRY_EXCHANGE_LIST t0
where t0.kjtid not in (
SELECT 
DISTINCT(C.MEMBER_ID) KJTID 
FROM DPM.T_DPM_OUTER_ACCOUNT_DETAIL@KJTDB A
INNER JOIN DPM.T_DPM_OUTER_ACCOUNT@KJTDB B 
ON B.ACCOUNT_NO = A.ACCOUNT_NO
INNER JOIN MEMBER.TM_MEMBER@KJTDB C ON C.MEMBER_ID = B.MEMBER_ID
)
and t0.orderstatus='成功'