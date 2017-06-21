--------------------
select
t0.PROMOTER_ID,
t1.HRYID,
t3.INVEST_TIMES
from bidata.s_promo_promotion_relation t0
inner join bidata.v_first_invest t1
on t0.PROMOTED_HRY_ID=t1.HRYID
inner join BIDATA.V_USER_INVEST_TIMES t3
on t0.PROMOTED_HRY_ID=t3.HRYID
left join BIDATA.S_PROMO_CHANNEL_INFO t2
on t0.PROMOTER_ID=t2.ID
where t0.CREATED_TIME >= to_date('20170117','yyyymmdd')  and  t0.CREATED_TIME <= to_date('20170301','yyyymmdd') 
and t1.INVEST_TIME >= to_date('20170117','yyyymmdd')  and  t1.INVEST_TIME <= to_date('20170301','yyyymmdd')
and t2.CHANNEL_NAME is null
and t3.INVEST_TIMES>1
order by t0.PROMOTER_ID-- t3.INVEST_TIMES desc
;
--------------------
select
*
from bidata.s_promo_promotion_relation t0
;