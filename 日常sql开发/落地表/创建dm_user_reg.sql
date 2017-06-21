create table dm_user_reg as
select 
to_char(reg_time,'yyyymmdd') as rptdt,
count(1) reg_users
--count(case when emp_type='内部员工' then hryid else null end) emp_reg_users,
--count(case when emp_type='非内部员工' then hryid else null end) noemp_reg_users 
from dim_user_hry_users
group by to_char(reg_time,'yyyymmdd')
order by to_char(reg_time,'yyyymmdd');

commit;

