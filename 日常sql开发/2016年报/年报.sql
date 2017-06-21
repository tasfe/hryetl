-- 各年龄段投资笔数
select age,count(1) from (
select 
      hryid,
      buy_balance,
      pid,
      bid_type_name,
      decode(greatest(age,19), 19, '0-19',decode(greatest(age,29),29,'20-29',
        decode(greatest(age,39),39,'30-39',decode(greatest(age,49),49,'40-49','50+')))) age
  from (
  select a.hryid,
         a.buy_balance,
         a.pid,
         c.bid_type_name,
         to_char(sysdate,'yyyy') - to_char(b.f08,'yyyy') age
    from ods_order_p2p_list a left join S_S61_T6141 b on a.hryid = b.f01
    left join ods_prod_p2p_list c on a.pid = c.pid
   where a.orderstatus = 'CG'
     and to_char(sysdate,'yyyy') - to_char(b.f08,'yyyy') > 0
     and a.buy_balance > 100
     and to_char(a.ctime,'yyyy') = 2016
  )
) group by age


--年龄分布及2016年人均投资

select birth_years,count(distinct(hryid)) tot_users,sum(buy_balance) tot_amt,sum(buy_balance) / count(distinct(hryid)) average
from (
  select a.hryid,
         a.buy_balance,
         a.pid,
         c.bid_type_name,
         decode(birth_years,'00后','90后',decode(birth_years,'10后','90后',decode(birth_years,'20后','50后',
           decode(birth_years,'30后','50后',decode(birth_years,'40后','50后',birth_years))))) birth_years
    from ods_order_p2p_list a left join ods_user_hry_users b on a.hryid = b.hryid
    left join ods_prod_p2p_list c on a.pid = c.pid
   where a.orderstatus = 'CG'
     and a.buy_balance > 100
     and to_char(a.ctime,'yyyy') = 2016
     and b.birth_years != '未知'
) group by birth_years



-- 2016年各年龄喜好
select birth_years,year_profit 年化收益,count(1) 投资笔数 from (
  select a.hryid,
         a.buy_balance,
         a.pid,
         round(c.year_profit * 100,0) || '%' year_profit,
         decode(birth_years,'00后','90后',decode(birth_years,'10后','90后',decode(birth_years,'20后','50后',
           decode(birth_years,'30后','50后',decode(birth_years,'40后','50后',birth_years))))) birth_years
    from ods_order_p2p_list a left join ods_user_hry_users b on a.hryid = b.hryid
    left join ods_prod_p2p_list c on a.pid = c.pid
   where a.orderstatus = 'CG'
     and a.buy_balance > 100
     and to_char(a.ctime,'yyyy') = 2016
     and b.birth_years != '未知'
--  )
) group by birth_years, year_profit
order by birth_years

-- 2016年各星座喜好
select xingzuo,year_profit 年化收益,count(1) 投资笔数 from (
  select a.hryid,
         a.buy_balance,
         a.pid,
         round(c.year_profit * 100,0) || '%' year_profit,
         xingzuo
    from ods_order_p2p_list a left join ods_user_hry_users b on a.hryid = b.hryid
    left join ods_prod_p2p_list c on a.pid = c.pid
   where a.orderstatus = 'CG'
     and a.buy_balance > 100
     and to_char(a.ctime,'yyyy') = 2016
     and b.birth_years != '未知'
) group by xingzuo, year_profit
order by xingzuo

-- 2016年各属相喜好
select shuxiang,year_profit 年化收益,count(1) 投资笔数 from (
  select a.hryid,
         a.buy_balance,
         a.pid,
         round(c.year_profit * 100,0) || '%' year_profit,
         shuxiang
    from ods_order_p2p_list a left join ods_user_hry_users b on a.hryid = b.hryid
    left join ods_prod_p2p_list c on a.pid = c.pid
   where a.orderstatus = 'CG'
     and a.buy_balance > 100
     and to_char(a.ctime,'yyyy') = 2016
     and b.birth_years != '未知'
) group by shuxiang, year_profit
order by shuxiang

select the_year,xingzuo,avg(buy_balance) 人均投资金额,count(1)/count(distinct hryid) 人均投资笔数,sum(buy_balance) 投资金额,count(1) 投资笔数,bishu 总投资笔数,money 总投资金额,round(count(1)/bishu,4)*100||'%' 投资笔数占比,round(sum(buy_balance)/money,4)*100||'%'  投资金额占比
from (
select a.hryid,a.sex,a.birthday,a.id_card,a.shuxiang,a.xingzuo,(to_char(sysdate,'YYYY')-to_char(a.birthday, 'YYYY')) as age,b.pay_balance,b.buy_balance,b.pid,the_year,
count(1) over(partition by 1) as bishu,sum(buy_balance) over(partition by 1) money
 from ODS_USER_HRY_USERS a inner join ods_order_p2p_list b on a.hryid=b.hryid
inner join ods_prod_p2p_list d on b.pid=d.pid
inner join bidim.dim_date c on to_char(b.ctime,'yyyymmdd')=c.date_key
where b.orderstatus='CG'   and xingzuo is not null
) t group by the_year,xingzuo,bishu,money;


select the_year,shuxiang,avg(buy_balance) 人均投资金额,count(1)/count(distinct hryid) 人均投资笔数,sum(buy_balance) 投资金额,count(1) 投资笔数,bishu 总投资笔数,money 总投资金额,round(count(1)/bishu,4)*100||'%' 投资笔数占比,round(sum(buy_balance)/money,4)*100||'%'  投资金额占比
from (
select a.hryid,a.sex,a.birthday,a.id_card,a.shuxiang,a.xingzuo,(to_char(sysdate,'YYYY')-to_char(a.birthday, 'YYYY')) as age,b.pay_balance,buy_balance,b.pid,the_year,
count(1) over(partition by 1) as bishu,sum(buy_balance) over(partition by 1) money
 from ODS_USER_HRY_USERS a inner join ods_order_p2p_list b on a.hryid=b.hryid
inner join ods_prod_p2p_list d on b.pid=d.pid
inner join bidim.dim_date c on to_char(b.ctime,'yyyymmdd')=c.date_key
where b.orderstatus='CG' and shuxiang is not null 
) t group by the_year,shuxiang,bishu,money


select * from v_table_meta

select * from bi_daily_tasks_test
