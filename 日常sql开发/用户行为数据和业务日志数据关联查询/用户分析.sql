
------ 活跃用户数
select
to_char(LOG_TIME,'yyyymm') 月份,
count(distinct t0.USER_ID) 登录活跃用户数
from BIDATA.BI_LOG t0
where t0.USER_ID is not null
group by to_char(LOG_TIME,'yyyymm')
order by to_char(LOG_TIME,'yyyymm') desc
;

select
to_char(LOG_TIME,'yyyymmdd') 日期,
count(distinct t0.USER_ID) 登录活跃用户数
from BIDATA.BI_LOG t0
where t0.USER_ID is not null
group by to_char(LOG_TIME,'yyyymmdd')
order by to_char(LOG_TIME,'yyyymmdd') desc
;



------- 新增用户数
select
to_char(t0.created_time,'yyyymm') 月份,
count(*) 注册用户数
from bidata.s_s61_t6110 t0
group by to_char(t0.created_time,'yyyymm')
order by to_char(t0.created_time,'yyyymm') desc
;


----- 注册用户数
select
count(*) 注册用户数
from bidata.s_s61_t6110 t0
where t0.CREATED_TIME < to_date('20170213','yyyymmdd')
;
select
count(*) 注册用户数
from bidata.s_s61_t6110 t0
where t0.CREATED_TIME < to_date('20170201','yyyymmdd')
;
select
count(*) 注册用户数
from bidata.s_s61_t6110 t0
where t0.CREATED_TIME < to_date('20161101','yyyymmdd')
;

