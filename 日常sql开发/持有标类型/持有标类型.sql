select PARENT_BID_TYPE_NAME,sum(amt) from (
select d.pid,d.PARENT_BID_TYPE_NAME,a.f04 amt,a.F03 hryid
from s_s62_t6250 a 
inner join DIM_PROD_P2P_LIST d on a.f02 = d.pid
where sysdate - d.GRANT_TIME  > 5 and d.GRANT_TIME + d.DAY_BORROW_DURATION - sysdate > 45
and a.f07 = 'F'
)
group by PARENT_BID_TYPE_NAME;


-- 按标的周期分类
select PARENT_BID_TYPE_NAME,day_borrow_duration,sum(amt) from (
select d.pid,d.PARENT_BID_TYPE_NAME,a.f04 amt,
 decode(greatest(d.DAY_BORROW_DURATION,30),30,'0-30',decode(greatest(d.DAY_BORROW_DURATION,45),45,'30-45',
 decode(greatest(d.DAY_BORROW_DURATION,60),60,'45-60',decode(greatest(d.DAY_BORROW_DURATION,90),90,'60-90',
 decode(greatest(d.DAY_BORROW_DURATION,180),180,'90-180',decode(greatest(d.DAY_BORROW_DURATION,270),270,'180-270',
 decode(greatest(d.DAY_BORROW_DURATION,365),365,'270-365',decode(greatest(d.DAY_BORROW_DURATION,400),400,'365-400','大于400')))))))) DAY_BORROW_DURATION,
 a.f03 hryid
from s_s62_t6250 a 
inner join DIM_PROD_P2P_LIST d on a.f02 = d.pid
where sysdate - d.GRANT_TIME  > 5 and d.GRANT_TIME + d.DAY_BORROW_DURATION - sysdate > 45
and a.f07 = 'F'
)
group by PARENT_BID_TYPE_NAME,day_borrow_duration;

------ 以上业务相关投资 用户数
select 
count(distinct(hryid))
from (
select 
hryid
from (
select d.pid,d.PARENT_BID_TYPE_NAME,a.f04 amt,
 decode(greatest(d.DAY_BORROW_DURATION,30),30,'0-30',decode(greatest(d.DAY_BORROW_DURATION,45),45,'30-45',
 decode(greatest(d.DAY_BORROW_DURATION,60),60,'45-60',decode(greatest(d.DAY_BORROW_DURATION,90),90,'60-90',
 decode(greatest(d.DAY_BORROW_DURATION,180),180,'90-180',decode(greatest(d.DAY_BORROW_DURATION,270),270,'180-270',
 decode(greatest(d.DAY_BORROW_DURATION,365),365,'270-365',decode(greatest(d.DAY_BORROW_DURATION,400),400,'365-400','大于400')))))))) DAY_BORROW_DURATION,
 a.f03 hryid
from s_s62_t6250 a 
inner join DIM_PROD_P2P_LIST d on a.f02 = d.pid
where sysdate - d.GRANT_TIME  > 5 and d.GRANT_TIME + d.DAY_BORROW_DURATION - sysdate > 45
and a.f07 = 'F'
) T
UNION ALL
select
hryid
from (
select d.pid,d.PARENT_BID_TYPE_NAME,a.f04 amt,a.F03 hryid
from s_s62_t6250 a 
inner join DIM_PROD_P2P_LIST d on a.f02 = d.pid
where sysdate - d.GRANT_TIME  > 5 and d.GRANT_TIME + d.DAY_BORROW_DURATION - sysdate > 45
and a.f07 = 'F'
) TT
) ttt
;



-- 按持有金额区分
select amt,count(1) from (
select hryid,
       case when amt between 0 and 49999 then '0-49999'
       when amt between 50000 and 99999 then '5w-99999'
       when amt between 100000 and 199999 then '10w-199999'
       when amt between 200000 and 499999 then '20-499999'
       when amt between 500000 and 999999 then '50w-999999'
       when amt between 1000000 and 4999999 then '100-4999999'
       else '500w+' end as amt
from (
  select a.f03 hryid, sum(a.f04) amt from s_s62_t6250 a inner join DIM_PROD_P2P_LIST b on a.f02 = b.bid
  where to_date('20170227 00:00:00','yyyymmdd hh24:mi:ss') - b.grant_time >= 0 
  and b.grant_time + b.DAY_BORROW_DURATION - to_date('20170227 00:00:00','yyyymmdd hh24:mi:ss') >= 0
  and a.f07 = 'F'
  and b.bid_type_name != '新客专享'
  group by a.f03
)
) group by amt;




