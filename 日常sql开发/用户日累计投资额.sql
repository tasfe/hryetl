select TT.dt,TT.udim,count(hryid)
from (
select T.*,
decode(greatest(t.amount,4999),4999,'0-5000',decode(greatest(t.amount,19999),19999,'5000-20000',decode(greatest(t.amount,49999),49999,'20000-50000',decode(greatest(t.amount,99999),99999,'50000-100000','>100000')))) udim
from (
select 
to_char(t0.f06,'yyyyMMdd') dt,
t0.f03 hryid,
sum(t0.f05) amount
from S_S62_T6250 t0
where t0.f06 BETWEEN to_date('20161101','yyyyMMdd') and to_date('20170124','yyyyMMdd') 
group by to_char(t0.f06,'yyyyMMdd'),t0.f03
ORDER BY to_char(t0.f06,'yyyyMMdd') desc
) T) TT
group by TT.dt,TT.udim
ORDER BY TT.dt desc
;
