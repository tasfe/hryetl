---- 交易会员数 -- 区分会员类型
select
decode(T.member_type,1,'个人',2,'企业',3,'特约商户') 会员类型,
count(distinct(T.kjtid)) 会员数
from (
select
distinct(kjtid),
t1.member_type
from bi_user_exchange t0
left join member.tm_member@kjtdb t1
on t0.kjtid=t1.member_id
where t1.member_type is not null
) T
group by T.member_type
;

---------
----- 已经实名（库里有真实姓名）账户状态正常
select
count(distinct(t0.kjtid))
from bi_user_exchange t0
LEFT JOIN member.tr_personal_member@kjtdb t1
on t0.kjtid=t1.member_id
left join (
select
a1.member_id,
a1.account_id,
a1.status,
a2.status_map
from member.tr_member_account@kjtdb a1
left join dpm.t_dpm_outer_account@kjtdb a2
on a1.account_id=a2.account_no
) t2
on t0.kjtid=t2.member_id
where t1.true_name is not null and t1.CHANNEL_AMOUNT>0 and t2.status=1 and t2.status_map=1000




-----------
----- 实名影印件审核通过账户状态正常
select
count(distinct(t0.kjtid))
from bi_user_exchange t0
LEFT JOIN member.tr_personal_member@kjtdb t1
on t0.kjtid=t1.member_id
left join member.tr_member_account@kjtdb t2
on t0.kjtid=t2.member_id
left join (SELECT tt1.member_id,
    tt1.auth_name,
    (
    CASE tt1.auth_type
      WHEN 'identity'
      THEN '国政通验证'
      WHEN 'realName'
      THEN'影印件审核'
    END ) auth_type,
    (
    CASE tt1.result
      WHEN 'checkPass'
      THEN '通过'
      WHEN 'checkReject'
      THEN '驳回'
      WHEN 'init'
      THEN '已提交'
    END ) result
  FROM (
    select t0.member_id,max(t0.order_no) order_no,t0.auth_type,t0.result,t0.cert_type,t0.auth_name from cert.tt_auth_order@kjtdb t0
    group by(t0.member_id,t0.auth_type,t0.result,t0.cert_type,t0.auth_name)
  ) tt1
  LEFT JOIN cert.tt_auth_file@kjtdb tt2
  ON tt1.order_no               =tt2.order_no
  WHERE tt1.cert_type           ='idCard' and tt1.auth_type='realName' and tt1.result='checkPass' and tt2.file_path is not null
  group by tt1.member_id,tt1.auth_name,tt1.auth_type,tt1.result) Tcert
on t0.kjtid=Tcert.member_id
where t1.true_name is not null and t2.status=1 and Tcert.result='通过'


-----------
------- 用户注册来源 非 快捷通、海融易
SELECT count(*) FROM
  ( SELECT DISTINCT(kjtid) FROM bi_user_exchange
  ) t0
left join member.tm_member@kjtdb t1
on t0.kjtid=t1.member_id
where t1.member_type=1 and t1.register_source <> 0 and t1.register_source <> 2


-----------
SELECT tt1.member_id,
    tt1.auth_name,
    (
    CASE tt1.auth_type
      WHEN 'identity'
      THEN '国政通验证'
      WHEN 'realName'
      THEN'影印件审核'
    END ) auth_type,
    (
    CASE tt1.result
      WHEN 'checkPass'
      THEN '通过'
      WHEN 'checkReject'
      THEN '驳回'
      WHEN 'init'
      THEN '已提交'
    END ) result
  FROM (
    select t0.member_id,max(t0.order_no) order_no,t0.auth_type,t0.result,t0.cert_type,t0.auth_name from cert.tt_auth_order@kjtdb t0
    group by(t0.member_id,t0.auth_type,t0.result,t0.cert_type,t0.auth_name)
  ) tt1
  LEFT JOIN cert.tt_auth_file@kjtdb tt2
  ON tt1.order_no               =tt2.order_no
  WHERE tt1.cert_type           ='idCard' and tt1.auth_type='realName' and tt1.result='checkPass' and tt2.file_path is not null
  group by tt1.member_id,tt1.auth_name,tt1.auth_type,tt1.result



---------------- 用户状态正常

