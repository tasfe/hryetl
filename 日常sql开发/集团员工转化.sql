SELECT 
t0.MOBILE 手机号,
t1.f01 海融易id,
t1.kjtid 海融易绑定的快捷通id,
t1.rz_state 实名认证状态
FROM TMP_GROUP_STAFF_MOBILE t0
LEFT JOIN
  (SELECT s1.f01,
    s1.f04,
    s1.kjtid,
    DECODE(s2.f04,'TG','通过','BTG','不通过') rz_state
  FROM s_s61_t6110 s1
  LEFT JOIN s_s61_t6141 s2
  ON s1.f01                    =s2.f01
  )  t1 
  ON t0.MOBILE=t1.F04 ;


---
select * from s_s61_t6110 t0
where t0.f01=2165