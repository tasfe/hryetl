select 
count(*) 
from s_s61_t6110 
where kjtid is null;

---- 海融易用户,没有绑定的快捷通会员
select 
t0.f01 海融易id,
t0.f02 登录名,
t0.f04 手机号,
t0.f05 邮箱,
decode(t0.f07,'QY','启用','SD','锁定','HMD','黑名单')
from s_s61_t6110 t0
where kjtid is null;