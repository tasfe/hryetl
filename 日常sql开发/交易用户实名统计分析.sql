

---------------------------
-------------- 已实名有交易状态正常的会员数
SELECT 
count(distinct(t0.kjtid))
FROM
  (SELECT DISTINCT(kjtid) FROM bi_user_exchange
  ) t0
LEFT JOIN member.tr_personal_member@kjtdb t1
ON t0.kjtid=t1.member_id
LEFT JOIN
  (SELECT a1.member_id,
    a1.account_id,
    a1.status,
    a2.status_map
  FROM member.tr_member_account@kjtdb a1
  LEFT JOIN dpm.t_dpm_outer_account@kjtdb a2
  ON a1.account_id   =a2.account_no
  ) t2 ON t0.kjtid   =t2.member_id
WHERE t1.true_name  IS NOT NULL
AND t1.CHANNEL_AMOUNT>0
AND t2.status        =1
AND t2.status_map    =1000
and t0
order by t0.kjtid desc;

---------------------------
-------------- 截止到2016年底 已实名有交易状态正常的会员数
SELECT 
count(distinct(t0.kjtid))
FROM
  (SELECT DISTINCT(kjtid) FROM bi_user_exchange where rptdt<20170101
  ) t0
LEFT JOIN member.tr_personal_member@kjtdb t1
ON t0.kjtid=t1.member_id
LEFT JOIN
  (SELECT a1.member_id,
    a1.account_id,
    a1.status,
    a2.status_map
  FROM member.tr_member_account@kjtdb a1
  LEFT JOIN dpm.t_dpm_outer_account@kjtdb a2
  ON a1.account_id   =a2.account_no
  ) t2 ON t0.kjtid   =t2.member_id
WHERE t1.true_name  IS NOT NULL
AND t1.CHANNEL_AMOUNT>0
--AND t2.status        =1
--AND t2.status_map    =1000
order by t0.kjtid desc;
---
select count(*) from  member.tr_personal_member@kjtdb t1
where t1.CHANNEL_AMOUNT>0

---------------------------
--------------  已实名有交易状态正常的会员 明细
SELECT t0.kjtid 会员id,
  t1.default_login_name 登录名,
  t1.true_name 真实姓名掩码,
  TO_CHAR(t1.create_time,'yyyy-MM-dd hh24:mm:ss') 个人会员创建时间,
  TO_CHAR(t1.update_time,'yyyy-MM-dd hh24:mm:ss') 个人会员更新时间,
  t1.verify_level 认证等级,
  t1.channel_amount 认证渠道数,
  t2.account_id,
  t2.status,
  t2.status_map
FROM
  (SELECT DISTINCT(kjtid) FROM bi_user_exchange
  ) t0
LEFT JOIN member.tr_personal_member@kjtdb t1
ON t0.kjtid=t1.member_id
LEFT JOIN
  (SELECT a1.member_id,
    a1.account_id,
    a1.status,
    a2.status_map
  FROM member.tr_member_account@kjtdb a1
  LEFT JOIN dpm.t_dpm_outer_account@kjtdb a2
  ON a1.account_id   =a2.account_no
  ) t2 ON t0.kjtid   =t2.member_id
WHERE t1.true_name  IS NOT NULL
AND t1.CHANNEL_AMOUNT>0
AND t2.status        =1
AND t2.status_map    =1000
order by t0.kjtid desc;