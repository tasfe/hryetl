SELECT T1.member_id 会员ID,
  T1.default_login_name 默认登录名,
  T2.auth_name 认证实名,
  T2.auth_type 认证类型,
  T2.result 认证结果,
  TO_CHAR(T1.create_time,'yyyy-MM-dd hh:mm:ss') 注册日期,
  T2.file_path 影印文件路径
FROM member.tr_personal_member@kjtdb T1
LEFT JOIN
  (SELECT tt1.member_id,
    tt1.auth_name,
    (
    CASE tt1.auth_type
      WHEN 'identity'
      THEN '国政通验证'
      WHEN 'realName'
      THEN'影印件审核'
    END ) auth_type,
    tt1.cert_type,
    (
    CASE tt1.result
      WHEN 'checkPass'
      THEN '通过'
      WHEN 'checkReject'
      THEN '驳回'
      WHEN 'init'
      THEN '已提交'
    END ) result,
    tt2.file_path
  FROM (
    select t0.member_id,max(t0.order_no) order_no,t0.auth_type,t0.result,t0.cert_type,t0.auth_name from cert.tt_auth_order@kjtdb t0
    group by(t0.member_id,t0.auth_type,t0.result,t0.cert_type,t0.auth_name)
  ) tt1
  LEFT JOIN cert.tt_auth_file@kjtdb tt2
  ON tt1.order_no               =tt2.order_no
  WHERE tt1.cert_type           ='idCard'
  ) T2 ON T1.member_id          = T2.member_id
WHERE T1.create_time            > to_date('2015-12-01','yyyy-MM-dd')
AND TO_CHAR(T1.create_time,'dd')='01'
ORDER BY TO_CHAR(T1.create_time,'dd') DESC,
  T1.member_id DESC;
