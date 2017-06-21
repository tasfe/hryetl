select rptdt ,sum(a) all_num,sum(tj) promo,sum(dsf) dsf,sum(zrzc) zrzc,'SMRZ' flag
from(
    select  '${start_date}' rptdt,sum(auth_users) a ,0 tj,0 dsf,0 zrzc --汇总
    from dm_user_auth
    where  date_key ='${start_date}'
    union all
    select '${start_date}',0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from dm_user_auth 
    pivot(sum(auth_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
    where date_key = '${start_date}'
)         
group by rptdt
union all
-----注册用户群体
select rptdt,sum(a) all_num ,sum(tj) promo,sum(dsf)dsf , sum(zrzc) zrzc,'REG' flag
from(
    select '${start_date}'  rptdt,sum(reg_users) a,0 tj,0 dsf,0 zrzc
    from dm_user_reg
    where  date_key ='${start_date}'
    union all
    select '${start_date}',0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from dm_user_reg 
    pivot(sum(reg_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
    where date_key = '${start_date}'
)
group by rptdt
union all
----交易用户      
select rptdt,sum(a),sum(tj),sum(dsf),sum(zrzc),'JYYH'
from(
    select  '${start_date}' rptdt,sum(order_new_users) a,0 tj,0 dsf,0 zrzc             ------所有交易用户（不仅仅是海融易用户)
    from  DM_USER_ORDER d
    where  date_key ='${start_date}'
    union all
    select '${start_date}',0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from DM_USER_ORDER 
    pivot(sum(order_new_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
    where date_key = '${start_date}'
)
group by rptdt