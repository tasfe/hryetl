-- 每年交易金额
select yea,sum(a) as total from (
    SELECT   to_number( SUM(F04)) as a, to_char(f06,'yyyy') as yea FROM s_s62_t6250 WHERE F07 = 'F'  and to_char(f06,'yyyymmdd') <= 20170219
     group by to_char(f06,'yyyy')
    union all
    select to_number( max(TOTAL_DEAL)) a, to_char(update_time,'yyyy') as yea from s_s71_HB_INFOMATION a  where to_char(update_time,'yyyymmdd') <= 20170219
    group by to_char(update_time,'yyyy')
    union all
    select SUM(trade_amount) a, to_char(created_time,'yyyy') as yea from s_s70_hry_offline_trade_stats where to_char(created_time,'yyyymmdd') <= 20170219
    group by to_char(created_time,'yyyy')
    union all
    select to_number( SUM(F.TRANS_AMT/100)) a,to_char(create_time,'yyyy') yea from FUNDUSER.T_FUND_SHARE_ORDER@FDB  f
    WHERE F.STATUS='05'
    and f.TRANS_TYPE in ('I'/*转入，O--转出，C--消费，R--退款转入，P--收益转入*/)
    and to_char(create_time,'yyyymmdd') <= 20170219
    group by to_char(create_time,'yyyy')
) t group by yea
;
select sum(a) as total from (
    SELECT   to_number( SUM(F04)) as a FROM s_s62_t6250 WHERE F07 = 'F'  and to_char(f06,'yyyymmdd') <= 20170219
    union all
    select to_number( max(TOTAL_DEAL)) a from s_s71_HB_INFOMATION a  where to_char(update_time,'yyyymmdd') <= 20170219
    union all
    select SUM(trade_amount) a from s_s70_hry_offline_trade_stats where to_char(created_time,'yyyymmdd') <= 20170219
    group by to_char(created_time,'yyyy')
    union all
    select to_number( SUM(F.TRANS_AMT/100)) a from FUNDUSER.T_FUND_SHARE_ORDER@FDB  f
    WHERE F.STATUS='05'
    and f.TRANS_TYPE in ('I'/*转入，O--转出，C--消费，R--退款转入，P--收益转入*/)
    and to_char(create_time,'yyyymmdd') <= 20170219
) t
;
-- 2016每月交易额
select yea,sum(a) as total from (
    SELECT   to_number( SUM(F04)) as a, to_char(f06,'yyyymm') as yea FROM s_s62_t6250 WHERE F07 = 'F'  and to_char(f06,'yyyy') = 2016
     group by to_char(f06,'yyyymm')
    union all
    select to_number( max(TOTAL_DEAL)) a, to_char(update_time,'yyyymm') as yea from s_s71_HB_INFOMATION a  where to_char(update_time,'yyyy') = 2016
    group by to_char(update_time,'yyyymm')
    union all
    select SUM(trade_amount) a, to_char(created_time,'yyyymm') as yea from s_s70_hry_offline_trade_stats where to_char(created_time,'yyyy') = 2016
    group by to_char(created_time,'yyyymm')
    union all
    select to_number( SUM(F.TRANS_AMT/100)) a,to_char(create_time,'yyyymm') yea from FUNDUSER.T_FUND_SHARE_ORDER@FDB  f
    WHERE F.STATUS='05'
    and f.TRANS_TYPE in ('I'/*转入，O--转出，C--消费，R--退款转入，P--收益转入*/)
    and to_char(create_time,'yyyy') = 2016
    group by to_char(create_time,'yyyymm')
) t group by yea
;

-- 年龄分布
select age,count(1) from (
select decode(greatest(age,19),19,'小于19',decode(greatest(age,30),30,'20-30',
decode(greatest(age,40),40,'30-40',decode(greatest(age,50),50,'40-50','大于50')))) age from (
select a.kjtid, to_char(sysdate,'yyyy') - to_char(b.birthday,'yyyy') age
from 
(select distinct(kjtid) kjtid from bi_user_exchange where rptdt <20170101)
a left join dim_user_hry_users b on a.kjtid = b.kjtid
where b.birthday is not null
)
) group by age

-- 按星座分布用户
select xingzuo,count(1) from (
select a.kjtid, nvl(b.xingzuo,'其他') xingzuo from (
select distinct(kjtid) kjtid from bi_user_exchange where rptdt between 20160101 and 20161231)
a left join dim_user_hry_users b on a.kjtid = b.kjtid
)group by xingzuo 

--按星座分布金额
select xingzuo,sum(amt) as total from (
    select b.kjtid,a.f04 amt,b.xingzuo from s_s62_t6250 a left join dim_user_hry_users b on a.f03 = b.hryid --f03
     where to_char(f06,'yyyymmdd') between 20160101 and 20161231 and f07 = 'F'
    union all
--    select 'qita' kjtid,  amt,'qita' xingzuo from s_s71_HB_INFOMATION a  where to_char(update_time,'yyyy') = 2016
--    union all
    select 'qita' kjtid, SUM(trade_amount) amt, 'qita' xingzuo from s_s70_hry_offline_trade_stats where to_char(created_time,'yyyy') = 2016
    union all
select b.kjtid,a.trans_amt / 100, b.xingzuo from FUNDUSER.T_FUND_SHARE_ORDER@FDB a inner join dim_user_hry_users b on a.kjt_cust_id = b.kjtid
WHERE a.STATUS='05'
    and a.TRANS_TYPE in ('I'/*转入，O--转出，C--消费，R--退款转入，P--收益转入*/)
    and to_char(a.create_time,'yyyy') = 2016
) t group by xingzuo
;

select b.kjtid,a.trans_amt / 100, b.xingzuo from FUNDUSER.T_FUND_SHARE_ORDER@FDB a inner join dim_user_hry_users b on a.kjt_cust_id = b.kjtid

--p2p年化投资排名

select kjtid,hry_acct,sum(amt) from (
select b.kjtid,
       a.f04,
       decode(c.REGULAR_BY_DAY,'S',c.day_borrow_duration * a.f04 / 365,c.monty_borrow_duration * a.f04 / 12) amt,
       b.hry_acct
from s_s62_t6250 a left join dim_user_hry_users b on a.f03 = b.hryid inner join dim_prod_p2p_list c on a.f02 = c.pid
     where to_char(a.f06,'yyyymmdd') between 20160101 and 20161231 and a.f07 = 'F'
)group by kjtid ,hry_acct
order by sum(amt) desc
-- 投资排名

select * from (
select kjtid,hry_acct,sum(amt) amt from (
    select b.kjtid,a.f04 amt,b.hry_acct from s_s62_t6250 a left join dim_user_hry_users b on a.f03 = b.hryid --f03
     where to_char(f06,'yyyymmdd') between 20160101 and 20161231 and f07 = 'F'
    union all
    select 'qita' kjtid, SUM(trade_amount) amt, 'qita' hry_acct from s_s70_hry_offline_trade_stats where to_char(created_time,'yyyy') = 2016
    union all
select b.kjtid,a.trans_amt / 100, b.hry_acct from FUNDUSER.T_FUND_SHARE_ORDER@FDB a inner join dim_user_hry_users b on a.kjt_cust_id = b.kjtid
WHERE a.STATUS='05'
    and a.TRANS_TYPE in ('I'/*转入，O--转出，C--消费，R--退款转入，P--收益转入*/)
    and to_char(a.create_time,'yyyy') = 2016
) t group by kjtid,hry_acct
)order by amt desc


select * from (
select '两周年活动3' flag,hryid,account_hry ,trunc(sum(nh_txn_amt),2)  nh_txn_amt  
    from(
            select  e.F01 hryid, e.F02 account_hry  ,case when period like '%天' then a.F04 * to_number(substr(d.period,1,length(d.period)-1)) / 365 else a.f04*to_number(substr(d.period,1,length(d.period)-1))/12  end  nh_txn_amt
            from   s_s61_t6110 e
            inner join( select a.f01 ,a.f02,a.f03 ,a.F04 from  s_s65_t6504 a ) a
            on a.f02=e.F01
            inner join  s_s65_t6501 c
            on   c.f01 = a.f01
            AND  c.f08 = a.f02
            AND  c.f02 = '20001' 
            and  c.f03='CG' 
            inner join( 
                select a.F01,case when c.F21 = 'S' then  TO_CHAR(c.F22)||'天'  when c.f21='F' then   TO_CHAR(a.f09)||'月' end period,a.f03
                from S_S62_t6230 a, S_S62_t6231 c where c.F01=a.F01
            ) d
            on a.f03=d.f01
            where    to_char(c.F06,'yyyymmdd') between 20161222 and 20170120 ----- 20161221-20160121
    ) s
    group by hryid,account_hry
) order by nh_txn_amt desc

