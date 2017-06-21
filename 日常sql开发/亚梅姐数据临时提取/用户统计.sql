------ 用户统计-- 已实名用户
select
count(*)
from member.tr_personal_member@kjtdb t0
where t0.CHANNEL_AMOUNT >0
;

------- P2P投资用户
select 
count(distinct(t0.f03))
from bidata.s_s62_t6250 t0
;

------- 交易用户
select 
count(distinct(t0.kjtid))
from bidata.bi_user_exchange t0
;
