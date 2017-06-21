create table dm_user_login AS
select dt as rptdt,
count(1) total_login_users_noemp
from bi_user_loginuser_dt
group by dt
order by dt;
commit;

