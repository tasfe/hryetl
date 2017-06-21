create table TMP_SHUNGUANG_AMT
as 
SELECT 
t1.MEMBER_ID,
t1.LOGIN_NAME,
t0.account_id,
t2.balance AS "20170224_amt",
(case when t3.after_amt is null then t4.after_amt  else t3.after_amt end) "20170223_amt",
(case when t4.after_amt is null then t5.after_amt  else t4.after_amt end) "20170222_amt",
(case when t5.after_amt is null then t6.after_amt  else t5.after_amt end) "20170221_amt",
(case when t6.after_amt is null then t7.after_amt  else t6.after_amt end) "20170220_amt",
(case when t7.after_amt is null then t8.after_amt  else t7.after_amt end) "20170219_amt",
(case when t8.after_amt is null then t9.after_amt  else t8.after_amt end) "20170218_amt",
(case when t9.after_amt is null then t10.after_amt  else t9.after_amt end) "20170217_amt",
(case when t10.after_amt is null then t11.after_amt  else t10.after_amt end) "20170216_amt",
(case when t11.after_amt is null then t12.after_amt  else t11.after_amt end) "20170215_amt",
t12.after_amt "20170214_amt"
--(case when t3.amt is not null then t3.amt else t2.balance end) AS "20170223 余额",
--(case when t4.amt is not null then t4.amt else t2.balance end) AS "20170222 余额"
FROM member.tr_member_account@kjtdb t0 
inner JOIN BIDATA.TMP_SHUNGUANG t1
on t0.member_id=t1.member_id
left join dpm.t_dpm_outer_account_subset@kjtdb t2
on t0.account_id=t2.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170223'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t3
on t0.account_id=t3.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170222'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t4
on t0.account_id=t4.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170221'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t5
on t0.account_id=t5.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170220'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t6
on t0.account_id=t6.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170219'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t7
on t0.account_id=t7.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170218'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t8
on t0.account_id=t8.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170217'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t9
on t0.account_id=t9.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170216'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t10
on t0.account_id=t10.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170215'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t11
on t0.account_id=t11.account_no
left join (
SELECT t2.account_no,
  t2.after_amt
FROM
  (SELECT t2.account_no,
    MAX(t2.create_time) last_trade_time
  FROM dpm.t_dpm_outer_account_sub_detail@kjtdb t2
  WHERE TO_CHAR(t2.create_time,'yyyymmdd')='20170214'
  GROUP BY t2.account_no
  ) T1
INNER JOIN dpm.t_dpm_outer_account_sub_detail@kjtdb T2
ON T1.account_no      =T2.account_no
AND T1.last_trade_time=T2.create_time 
) t12
on t0.account_id=t12.account_no
order by t2.balance desc
;