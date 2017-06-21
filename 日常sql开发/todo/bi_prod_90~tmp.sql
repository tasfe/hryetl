SELECT t0.sjhm 手机号,
    t1.hryid 海融易id,
    t1.KJTID 海融易绑定的快捷通id,
    t2.member_id 快捷通id,
    t2.is_verify 是否实名
  FROM wdh.ls_sjhm@kjtdb t0
  LEFT JOIN V_QY_MEMBER_HRY_KJT t1
  ON t0.sjhm=t1.LOGIN_NAME
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
  ---and t1.kjtid !=t2.member_id 
  group by t0.sjhm,t1.HRYID,t1.KJTID,t2.member_id,t2.is_verify
  ;
  
  ----
  select 
t.LOGIN_NAME
from (
select
v0.LOGIN_NAME,
COUNT(*) hryid_count
from V_QY_MEMBER_HRY_KJT v0
group by v0.LOGIN_NAME
) t
where t.hryid_count>1
;