CREATE TABLE dm_user_auth as
select 
to_char(authent_time,'yyyymmdd') as dt,
count(1) auth_users
--count(case when emp_type='内部员工' then hryid else null end) emp_auth_users,
--count(case when emp_type='非内部员工' then hryid else null end) noemp_auth_users
from dim_user_hry_users t 
where t.authent_status_name='已认证' and authent_time is not null
group by to_char(authent_time,'yyyymmdd')
order by to_char(authent_time,'yyyymmdd');

commit;