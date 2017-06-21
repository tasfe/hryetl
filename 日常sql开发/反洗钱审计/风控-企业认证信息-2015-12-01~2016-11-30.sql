SELECT T1.member_id 会员ID,
  TO_CHAR(T1.create_time,'yyyy-MM-dd') 注册时间,
  (
  CASE T2.member_type
    WHEN 1
    THEN '个人'
    WHEN 2
    THEN '企业'
    WHEN 3
    THEN '特约商户'
  END)会员类型,
  (
  CASE T2.status
    WHEN 0
    THEN '未激活'
    WHEN 1
    THEN '正常'
    WHEN 2
    THEN '休眠'
    WHEN 3
    THEN '注销'
  END ) 会员状态,
  LEGAL_PERSON 法人代表,
  (case T1.IS_THREE_COMPLETE 
  when 0 then '否'
  when 1 then '是'
  end) 是否三证齐全,
  (case T1.IS_THREE 
  when 0 then '否'
  when 1 then '是'
  end) 是否三证合一,
  T1.LICENSE_NO 商户营业执照,
  LICENSE_EXPIRE_DATE "企业营业执照失效时间(营业期限)",
  ORGANIZATION_NO 组织机构代码,
  TAX_NO 税务登记证号,
  (case T1.COMPLETE_STATUS
  when 0 then '未审核'
  when 1 then '审核通过'
  when 2 then '审核驳回'
  when 3 then '审核中'
  end) 三证审核状态 ,
  T1.address 企业地址,
  T1.LICENSE_NO_PATH 企业营业执照附件url,
  T1.ORGANIZATION_NO_PATH 组织机构代码证附件url,
  T1.TAX_NO_PATH 税务登记证附件url
FROM member.tr_company_member@kjtdb T1
LEFT JOIN member.tm_member@kjtdb T2
ON T1.member_id      =T2.member_id
WHERE T1.create_time > TO_DATE('2015-12-01','yyyy-MM-dd')
AND T1.create_time   < TO_DATE('2016-12-01','yyyy-MM-dd')
ORDER BY TO_CHAR(T1.create_time,'yyyy-MM-dd') DESC;
