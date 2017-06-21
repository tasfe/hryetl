select 
ft.verivyL 认证状态,
ft.accountStatus 账户状态,
ft.memberStatus 会员状态,
ft.registerRource 注册来源,
ft.yyjCheck 影印件审核状态,
count(*)
from (
SELECT 
t0.kjtid member_id,
t1.default_login_name,
t3.member_name 会员名称,
t1.verify_level verivyL,
decode(t2.status,0,'未激活',1,'正常',2,'锁定',3,'止出',4,'止入') accountStatus,
decode(t3.status,0,'未激活',1,'正常',2,'休眠',3,'注销') memberStatus,
decode(t3.register_source,0,'快捷通',1,'手机端',2,'海融易',3,'人人创客',99,'其他','未知来源') registerRource,
decode(t4.result,'checkPass','通过','checkReject','驳回','init','已提交','未提交') yyjCheck ,
to_char(t3.update_time,'yyyy-MM-dd hh24:mm:ss') 更新时间
FROM
  ( SELECT DISTINCT(kjtid) kjtid FROM bi_user_exchange WHERE kjtid IS NOT NULL
  ) t0
left join member.tr_personal_member@kjtdb t1
on t0.kjtid=t1.member_id
left join member.tr_member_account@kjtdb t2
on t0.kjtid=t2.member_id
left join member.tm_member@kjtdb t3
on t0.kjtid=t3.member_id
left join (
  select t0.member_id,max(t0.order_no) order_no,t0.auth_type,t0.result,t0.cert_type,t0.auth_name from cert.tt_auth_order@kjtdb t0
  where auth_type='realName'
  group by(t0.member_id,t0.auth_type,t0.result,t0.cert_type,t0.auth_name)
) t4
on t0.kjtid=t4.member_id
where t3.member_type =1 --- 1 个人会员
order by t3.update_time desc
) ft
group by 
ft.verivyL,
ft.accountStatus,
ft.memberStatus,
ft.registerRource,
ft.yyjCheck
order by
ft.verivyL,
ft.accountStatus,
ft.memberStatus,
ft.registerRource,
ft.yyjCheck
;