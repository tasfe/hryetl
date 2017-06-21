select
t1.THE_YEAR
,count(*) first_p2p_order
from BIDATA.DM_USER_ORDER_FIRST t0
left join bidim.dim_date t1
on t0.date_key=t1.DATE_KEY
where t0.date_key<20170401
group by t1.THE_YEAR
order by t1.THE_YEAR desc
;

select
count(distinct t0.KJTID)
from bidata.bi_user_exchange t0
inner join (
SELECT 
t1.kjtid
FROM BIDATA.DM_USER_ORDER_FIRST t0
INNER join bidata.s_s61_t6110 t1
on t0.hryid=t1.f01
where t0.DATE_KEY BETWEEN 20160101 and 20161231
) t1
on t0.KJTID=t1.kjtid
where t0.RPTDT BETWEEN 20161001 and 20170331
;