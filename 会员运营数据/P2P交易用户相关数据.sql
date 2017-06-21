-----------
SELECT
S1.THE_MONTH
,COUNT(*) MEMBER_COUNT
FROM DM_USER_ORDER_FIRST S0
LEFT JOIN BIDIM.DIM_DATE S1
ON S0.DATE_KEY=S1.DATE_KEY
GROUP BY S1.THE_MONTH
ORDER BY S1.THE_MONTH
;
----------

WITH TMP_FIRST_TRADE_USER AS (
select
s0.HRYID,
s1.THE_MONTH
FROM bidata.DM_USER_ORDER_FIRST s0
left join bidim.dim_date s1
on s0.date_key=s1.date_key
),
TMP_ORDER_MONTH AS (
select
s1.the_month
,s0.*
from DM_ORDER_P2P_OK s0
left join bidim.dim_date s1
on s0.date_key=s1.date_key
)

select
count(*)
from (
SELECT 
S0.HRYID
,count(*) order_count
FROM TMP_FIRST_TRADE_USER S0
LEFT JOIN TMP_ORDER_MONTH  S1
ON S0.HRYID=S1.HRYID
WHERE S0.the_month=201610
AND S1.the_month<=201611
GROUP BY S0.HRYID
HAVING COUNT(*)>1
)
;