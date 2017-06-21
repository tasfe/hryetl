--总额
select sum(amt_tot) from (
select f02 user_id,amt_tot,rank() over( order by amt_tot desc) ranks from (
select a.f02,sum(a.f05)-sum(a.f07) amt_tot from s_s62_t6230 a 
where a.f20 in ('HKZ','YJQ','YDF')
group by a.f02
)order by amt_tot desc
) a


select b.f12 放款,b.f22 借款天,a.f09 借款月,
a.f01 p_id,a.f02 user_id,a.f05 amt
from s_s62_t6230 a left join s_s62_t6231 b on a.f01 = b.f01 
where a.f20 = 'HKZ' and a.f02 = '3903'


-- 结果
select a.f02,sum(a.f05) - sum(a.f07) from s_s62_t6230 a left join s_s62_t6231 b on a.f01 = b.f01 
where a.f20 = 'HKZ' and a.f02 in (
  select user_id from (
  select * from (
  select f02 user_id,amt_tot,rank() over( order by amt_tot desc) ranks from (
  select f02,sum(f05) amt_tot from s_s62_t6230 
  where f20 in ('HKZ','YJQ','YDF')
  group by f02
  )order by amt_tot desc
  ) a where ranks < 11
  )
)
group by a.f02

--主要产品尚未结清交易余额
select sum(f05) - sum(f07) from s_s62_t6230 where f20 = 'HKZ'


