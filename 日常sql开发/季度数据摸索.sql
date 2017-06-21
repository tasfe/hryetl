select count(distinct(t0.kjtid))
from bi_user_exchange t0
where t0.RPTDT BETWEEN 20161001 and 20161231
;


select 
sum(t0.f05) 金额,
count(distinct(t0.F03))
from s_s62_t6250 t0
where t0.f07='F'
and t0.f06 BETWEEN to_date('20161001','yyyymmdd') and to_date('20170101','yyyymmdd')
;


select 
sum(t0.f05) 金额,
count(distinct(t0.F03))
from s_s62_t6250 t0
where t0.f07='F'
and t0.f06 BETWEEN to_date('20160701','yyyymmdd') and to_date('20161001','yyyymmdd')
;