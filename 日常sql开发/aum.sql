select  
t1.f01 hryid,
t0.avl_share/100 amount
from funduser.t_fund_share_info@fdb t0
left join S_S61_T6110 t1
on t0.kjt_cust_id=t1.kjtid
ORDER BY amount desc
;


select t0.f04 hryid,
sum(t0.f07) amount
from s_s62_t6252 t0
where t0.F09 in ('WH','HKZ')
group by t0.F04
order by amount desc
;

SELECT 
t0.f03 hryid,
sum(t0.f05) amount
from s_s62_t6250 t0
where t0.f07='F' and t0.F08='F'
group by t0.F03
;


select 
sum(t0.f05)
from s_s62_t6250 t0

