WITH TMP_REPAY_CAPITAL_PLAN AS (
  SELECT
  S0.F04 HRYID
  ,S0.F07 AMT
  ,to_char(S0.F08,'yyyymmdd') to_repay_date
  ,S2.QIXI_DATE
  --,S1.F02 repay_category
  FROM BIDATA.S_S62_T6252 S0
  LEFT JOIN BIDATA.S_S51_T5122 S1
  ON S0.F05=S1.F01
  LEFT JOIN (
    SELECT 
    S0.F01 BID
    ,TO_CHAR(S0.F19+S1.F12,'YYYYMMDD') QIXI_DATE
    FROM BIDATA.S_S62_T6230 S0
    LEFT JOIN BIDATA.S_S62_T6231 S1
    ON S0.F01=S1.F01
    WHERE S0.F20 NOT IN ('YZF','YLB')
  ) S2
  ON S0.F02=S2.BID
  WHERE S1.F02='本金'
  AND S0.F08>SYSDATE - 30 
),
TMP_REPAY_USER AS (
  SELECT
  DISTINCT S0.F04 HRYID
  FROM BIDATA.S_S62_T6252 S0
)

--SELECT
--T.HRYID
--,NVL(T.AMT_D,0) NEXT_AMT
--,NVL((T.AMT_D_1+T.AMT_D_2+T.AMT_D_3+T.AMT_D_4+T.AMT_D_5+T.AMT_D_6+T.AMT_D_6+T.AMT_D_7+T.AMT_D_8+T.AMT_D_9+T.AMT_D_10+T.AMT_D_11+T.AMT_D_12+T.AMT_D_13+T.AMT_D_14+T.AMT_D_15+T.AMT_D_16+T.AMT_D_17+T.AMT_D_18+T.AMT_D_19+T.AMT_D_20+T.AMT_D_21+T.AMT_D_22+T.AMT_D_23+T.AMT_D_24+T.AMT_D_25+T.AMT_D_26+T.AMT_D_27+T.AMT_D_28+T.AMT_D_29+T.AMT_D_30)/30,0) AVG_AMT
--FROM (
  SELECT
s0.HRYID
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate,'yyyymmdd') and s1.to_repay_date>to_char(sysdate,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-1,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_1
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-2,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_2
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-3,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_3
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-4,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_4
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-5,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_5
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-6,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_6
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-7,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_7
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-8,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_8
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-9,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_9
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-10,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_10
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-11,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_11
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-12,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_12
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-13,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_13
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-14,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_14
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-15,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_15
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-16,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_16
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-17,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_17
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-18,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_18
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-19,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_19
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-20,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_20
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-21,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_21
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-22,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_22
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-23,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_23
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-24,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_24
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-25,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_25
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-26,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_26
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-27,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_27
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-28,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_28
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-29,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_29
,(SELECT SUM(AMT) FROM TMP_REPAY_CAPITAL_PLAN S1 WHERE S1.hryid=s0.hryid AND s1.QIXI_DATE<=to_char(sysdate-30,'yyyymmdd') and s1.to_repay_date>to_char(sysdate-1,'yyyymmdd') GROUP BY S1.HRYID ) AMT_D_30
FROM TMP_REPAY_USER s0
WHERE S0.HRYID=380
--) T
;

