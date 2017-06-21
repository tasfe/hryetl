SELECT t0.sjhm 手机号,
    t1.F01 海融易id,
    decode(t1.f07,'QY','启用','SD','锁定','HMD','黑名单','未枚举状态') 会员状态,
    t1.KJTID 海融易绑定的快捷通id,
    t2.member_id 快捷通id,
    t2.is_verify 是否实名
  FROM wdh.ls_sjhm@kjtdb t0
  LEFT JOIN s_s61_t6110 t1
  ON t0.sjhm=t1.F02
  left join (
  select 
  m0.identity login_name,
  m0.member_id,
  decode(m1.channel_amount, 0, '未实名', '已实名') as is_verify
  from member.tm_member_identity@kjtdb m0
  left join member.tr_personal_member@kjtdb m1
  on m0.member_id=m1.member_id
  left join ura.t_usr_art_info@kjtdb m2
  on m0.member_id=m2.member_id
  ) t2
  on  t0.sjhm=t2.login_name
  where t1.KJTID is not null 
  and t2.member_id is not null 
  and t1.kjtid !=t2.member_id 
  group by t0.sjhm,t1.F01,t1.f07,t1.kjtid,t2.member_id,t2.is_verify
  ORDER BY t0.sjhm
  ;
-----
SELECT t0.sjhm 手机号,
    t1.F01 海融易id,
    ---t1.KJTID 海融易绑定的快捷通id,
    t2.member_id 快捷通id,
    t2.is_verify 是否实名
  FROM wdh.ls_sjhm@kjtdb t0
  LEFT JOIN s_s61_t6110 t1
  ON t0.sjhm=t1.F02
  left join (
  select 
  m0.identity login_name,
  m0.member_id,
  decode(m1.channel_amount, 0, '未实名', '已实名') as is_verify
  from member.tm_member_identity@kjtdb m0
  left join member.tr_personal_member@kjtdb m1
  on m0.member_id=m1.member_id
  left join ura.t_usr_art_info@kjtdb m2
  on m0.member_id=m2.member_id
  ) t2
  on  t0.sjhm=t2.login_name
  where t0.sjhm not in ( select * from V_DOUBLE_HRYID_FOR_LOGINNAME) and t0.sjhm not in (select phone from V_DIF_KJTID_FOR_PHONE)
  group by t0.sjhm,t1.F01,t2.member_id,t2.is_verify
  ORDER BY t0.sjhm
  ;
  
  ----
  select
  t0.sjhm,
  t1.f01 hryid,
  decode(t1.f07,'QY','启用','SD','锁定','HMD','黑名单','未枚举状态') state,
  t1.kjtid 绑定快捷通id
  from wdh.ls_sjhm@kjtdb t0
  LEFT JOIN s_s61_t6110 t1
  ON t0.sjhm=t1.F02
  where 
  t0.sjhm in (
  select t.sjhm from (
select 
t0.sjhm,
count(t1.f01) hry_count
from wdh.ls_sjhm@kjtdb t0
LEFT JOIN s_s61_t6110 t1
ON t0.sjhm=t1.F02
group by t0.sjhm
) t
where t.hry_count>1
  ) 
  --and t1.f07='QY'
  order by t0.sjhm
 ; 
-----



select
s0.F01 hryid,
s0.f02 login_name,
s0.KJTID
from s_s61_t6110 s0
where s0.F07='QY'
;

select t.F02 login_name from (
select 
s0.F02,
count(*) hryid_count
from s_s61_t6110 s0
group by s0.F02) t
where t.hryid_count >1
;