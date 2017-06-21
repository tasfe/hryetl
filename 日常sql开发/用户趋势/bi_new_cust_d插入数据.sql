insert into bi_new_cust_d 
select * from (
select rptdt ,sum(a) all_num,sum(tj) promo,sum(dsf) dsf,sum(zrzc) zrzc,'SMRZ' flag
from(
    select  date_key rptdt,sum(auth_users) a ,0 tj,0 dsf,0 zrzc --汇总
    from dm_user_auth
    group by date_key
   -- where  date_key =20170101
    union all
    select date_key,0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from dm_user_auth 
    pivot(sum(auth_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
    --where date_key = 20170101
)
group by rptdt
union all       
-----注册用户群体
select rptdt,sum(a) all_num ,sum(tj) promo,sum(dsf)dsf , sum(zrzc) zrzc,'REG' flag
from(
    select date_key  rptdt,sum(reg_users) a,0 tj,0 dsf,0 zrzc
    from dm_user_reg
    group by date_key
    --where  date_key =20170101--'${start_date}'
    union all
    select date_key,0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from dm_user_reg 
    pivot(sum(reg_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
   -- where date_key = 20170101
)
group by rptdt
union all
----交易用户      
select rptdt,sum(a),sum(tj),sum(dsf),sum(zrzc),'JYYH'
from(
    select  date_key rptdt,sum(order_new_users) a,0 tj,0 dsf,0 zrzc             ------所有交易用户（不仅仅是海融易用户)
    from  DM_USER_ORDER d
    group by date_key
    --where  date_key =20170101--'${start_date}' 
    union all
    select date_key,0,nvl(tj,0) tj,nvl(dsf,0) dsf, nvl(zrzc,0) zrzc
    from DM_USER_ORDER 
    pivot(sum(order_new_users) for promoter_source_name in ('海融易用户' tj,'外部渠道用户' dsf,'自然注册' zrzc))
   -- where date_key = 20170101
)
group by rptdt
)