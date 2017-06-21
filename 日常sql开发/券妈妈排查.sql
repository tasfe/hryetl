select 
t1.f02 登录名,
t1.f04 手机号,
t1.f01 海融易id,
t1.kjtid 快捷通id,
t1.f08 注册来源,
t2.bid 标的id,
t2.bname 标的标题,
t2.amount 投资金额,
t2.invest_time 投标时间
from s_s61_t6110 t1
left join (select
b1.f03 bid,
b2.f03 bname,
b1.f05 amount,
to_char(b1.F06,'yyyy-MM-dd hh24:mm:ss') invest_time
from s_s62_t6250 b1
left join s_s62_t6230 b2
on b1.f02=b2.f01) t2
on t1.f01=t2.bid
where t1.f02='13736689892'

-----
select * from s_promo_promotion_relation where promoted_id='12202814'
select * from s_promo_promotion_relation where promoter_id='1000000005'


select * from bi_user_promotion_relation where promoted_id='12202814'
select * from bi_login_h5_app where user_id='100002362105'

select * from s_promo_user_promotion where user_id=12202814
select * from 