---- 历史总交易用户: 221531
select 
count(distinct(kjtid)) 
from bi_user_exchange t0
;
---- 截止2015年12月31日 交易用户:106843
select 
count(distinct(kjtid)) 
from bi_user_exchange t0
where t0.RPTDT < 20160101 
;
---- 2015年内 交易用户:106681
select 
count(distinct(kjtid)) 
from bi_user_exchange t0
where t0.RPTDT between 20150101 and 20151231 
;

---- 截止2016年12月31日 交易用户:215014
select 
count(distinct(kjtid)) 
from bi_user_exchange t0
where t0.RPTDT < 20170101 
;
---- 2016年内 交易用户:153071
select 
count(distinct(kjtid)) 
from bi_user_exchange t0
where t0.RPTDT between 20160101 and 20161231 
;
----