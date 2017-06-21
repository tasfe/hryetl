SELECT
to_char(t0.reg_time_new,'yyyymm') the_month
,count(*) member_count
FROM BIDATA.DIM_USER_HRY_USERS t0
where t0.EMP_TYPE='内部员工'
--AND t0.USER_TYPE_NAME='自然人'
group by to_char(t0.reg_time_new,'yyyymm') 
order by to_char(t0.reg_time_new,'yyyymm') 
;

with TMP_USER_FIRST_TRADE AS (
select
t0.hryid
,min(t1.rptdt) first_trade_date
from dim_user_hry_users t0
left join bidata.bi_user_exchange t1
on t0.kjtid=t1.kjtid
where t0.EMP_TYPE='内部员工'
AND t1.resystemid != 'KJT'
--AND t0.USER_TYPE_NAME='自然人'
AND t1.kjtid is not null
group by t0.hryid
)
select
s1.the_month
,COUNT(*) member_count
from TMP_USER_FIRST_TRADE s0
left join bidim.dim_date s1
on s0.first_trade_date=s1.date_key
group by s1.the_month
order by s1.the_month
;