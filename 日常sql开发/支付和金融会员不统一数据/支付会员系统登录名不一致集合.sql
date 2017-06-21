

select
t0.member_id,
t0.default_login_name,
t1.identity,
to_char(t0.create_time,'yyyymmdd hh24:mi:ss'),
(case when t0.default_login_name=t1.identity then '相等' else '不等' end) flag
from member.tr_personal_member@kjtdb t0
left join member.tm_member_identity@kjtdb t1
on t0.member_id=t1.member_id
WHERE t0.default_login_name != t1.identity
;