select distinct(RESYSTEMID) from bi_user_exchange t0;

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
---- 交易会员 -- 区分认证状态
SELECT T.vl 认证,
  COUNT(DISTINCT(T.kjtid)) 会员数
FROM
  (SELECT t2.verify_level vl,
  t1.member_type,
    t0.kjtid
  FROM bi_user_exchange t0
  LEFT JOIN member.tr_personal_member@kjtdb t2
  ON t0.KJTID=t2.member_id
  LEFT JOIN member.tm_member@kjtdb t1
  ON t0.kjtid         =t1.member_id
  WHERE t1.member_type=1
  ) T
GROUP BY T.vl ;


select 
t2.verify_level,
count(t2.kjtid)
from 
(
select 
t0.kjtid,
t1.verify_level
FROM (select distinct(kjtid) from bi_user_exchange) t0
left join member.tr_personal_member@kjtdb t1
on t0.kjtid=t1.member_id
where t1.verify_level <>'L0' and t1.verify_level <>'L01'
group by t0.kjtid,t1.verify_level
order by t0.kjtid asc
) t2
left join member.tr_member_account@kjtdb t3
on t2.kjtid=t3.member_id
where t3.status=1 --- 账户状态为正常
group by t2.verify_level



select * from member.tm_member@kjtdb t1

select 
distinct(kjtid) 
from 
bi_user_exchange
order by kjtid desc;

select * from BI_USER_EXCHANGE where KJTID=100000076573;

----------
select 
t0.kjtid 会员id,
t1.member_name 会员名称,
decode(t1.member_type,1,'个人',2,'公司',3,'组织') 会员类型,
decode(t1.status,0,'未激活',1,'正常',2,'休眠',3,'注销') 会员状态,

decode(t1.lock_status,0,'未锁定',1,'锁定') 是否锁定,
decode(t1.REGISTER_SOURCE,0,'快捷通',1,'手机端',2,'海融易',3,'人人创客',99,'其他') 注册来源,
decode(t1.VERIFY_LEVEL,0,'未认证',1,'实名校验',2,'实名认证v1',3,'实名认证v2') 认证,
to_char(t1.update_time,'yyyyMMdd hh24:mm:ss') 更新时间,
decode(t2.status,0,'未激活',1,'正常',2,'')
from (
  select 
  distinct(kjtid) kjtid
  from bi_user_exchange
  where kjtid is not null
) t0
left join member.tm_member@kjtdb t1
on t0.kjtid=t1.member_id
left join member.tr_member_account@kjtdb t2
on t0.kjtid=t2.member_id
where t1.member_type=1 and t1.VERIFY_LEVEL>1 and t1.lock_status=0
order by t1.update_time desc


----
select count(1) from (
SELECT tt.mid,ttt.status
FROM
  (SELECT t0.kjtid mid,
    t1.member_name 会员名称,
    DECODE(t1.member_type,1,'个人',2,'公司',3,'组织') 会员类型,
    DECODE(t1.status,0,'未激活',1,'正常',2,'休眠',3,'注销') 会员状态,
    DECODE(t1.lock_status,0,'未锁定',1,'锁定') 是否锁定,
    DECODE(t1.REGISTER_SOURCE,0,'快捷通',1,'手机端',2,'海融易',3,'人人创客',99,'其他') 注册来源,
    DECODE(t1.VERIFY_LEVEL,0,'未认证',1,'实名校验',2,'实名认证v1',3,'实名认证v2') 认证,
    TO_CHAR(t1.update_time,'yyyyMMdd hh24:mm:ss') 更新时间
  FROM
    ( SELECT DISTINCT(kjtid) kjtid FROM bi_user_exchange WHERE kjtid IS NOT NULL
    ) t0
  LEFT JOIN member.tm_member@kjtdb t1
  ON t0.kjtid         =t1.member_id
  WHERE t1.member_type=1
  AND t1.VERIFY_LEVEL >1
  AND t1.lock_status   =0
  ORDER BY t1.update_time DESC
  ) tt
  left join member.tr_member_account@kjtdb ttt
  on tt.mid=ttt.member_id
  where ttt.status=1
) total


---

