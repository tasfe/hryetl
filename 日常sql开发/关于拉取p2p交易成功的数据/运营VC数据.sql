--- 每月表
SELECT
S1.THE_MONTH
,sum(S0.ORDER_AMOUNT) total_amt
FROM BIDATA.DM_ORDER_P2P_OK S0
LEFT JOIN BIDIM.DIM_DATE S1
ON S0.DATE_KEY=S1.DATE_KEY
group by S1.THE_MONTH
ORDER BY S1.THE_MONTH
;
---- P2P资产总量（元）
SELECT
to_char(S0.F22,'yyyy') the_year
,sum(s0.F05) amt
from BIDATA.S_S62_T6230 S0
where s0.f20 not in ('YZF','DFB')
group by to_char(S0.F22,'yyyy')
;
