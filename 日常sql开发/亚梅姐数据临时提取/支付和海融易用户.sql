select
t0.member_id,
count(*)
FROM BIDATA.S_ZHUAN_MEMBER_AGENT t0
group by t0.MEMBER_ID
HAVING count(*)>1 
ORDER BY count(*) desc
;

-----
select 
count(*) 
from member.tr_personal_member@kjtdb
;


select 
count(*)
from member.tr_company_member@kjtdb
;


------------------
select 
decode(t0.member_type,1,'个人',2,'公司',3,'组织','未知类型') 快捷通会员类型,
count(t0.member_id) 会员数
from member.tm_member@kjtdb t0
group by t0.member_type
;
------------------
select 
decode(t0.f06,'ZRR','自然人','FZRR','非自然人','未知类型') 海融易会员类型,
count(t0.f01) 会员数
from bidata.s_s61_t6110 t0
group by t0.f06
;

------------- 海融易用户没有关联的快捷通账号的会员 8898
select 
count(*) 海融易没有关联上快捷通的会员数
from bidata.s_s61_t6110 t0
where t0.KJTID is null
;