--4.1每月交易额以及变化趋势
select mm,
       round(nvl(p2p_amt_tot,0)/10000,0) p2p_amt_tot, --p2p金额(万元)
       nvl(round(p2p_percent,2),0) || '%' p2p_percent,
       nvl(round(p2p_mom,2),0) || '%' p2p_mom,
       round(nvl(ttj_amt_tot,0)/10000,0) ttj_amt_tot, --基金金额(万元)
       nvl(round(ttj_percent,2),0) || '%' ttj_percent,
       nvl(round(ttj_mom,2),0) || '%' ttj_mom,
       round(nvl(amt_tot,0)/10000,0) amt_tot, --总额(万元)
       nvl(round(tot_mom,2),0) || '%' tot_mom 
from (
select a.mm,--月份
    a.p2p_amt_tot, --p2p金额
    a.p2p_amt_tot / (b.ttj_amt_tot + a.p2p_amt_tot) * 100 p2p_percent, --p2p占比
    (a.p2p_amt_tot - lead(a.p2p_amt_tot) over(order by rownum)) / lead(a.p2p_amt_tot) over(order by rownum) * 100 p2p_mom, -- p2p月变化趋势
    b.ttj_amt_tot, -- ttj金额
    b.ttj_amt_tot / (b.ttj_amt_tot + a.p2p_amt_tot) * 100 ttj_percent, --ttj占比
    (b.ttj_amt_tot - lead(b.ttj_amt_tot) over(order by rownum)) / lead(b.ttj_amt_tot) over(order by rownum) * 100 ttj_mom,--ttj月变化趋势
    a.p2p_amt_tot + b.ttj_amt_tot amt_tot, --总金额
    (a.p2p_amt_tot+b.ttj_amt_tot-lead(a.p2p_amt_tot+b.ttj_amt_tot)over(order by rownum))/lead(a.p2p_amt_tot + b.ttj_amt_tot)over(order by rownum)*100 tot_mom -- 总金额月变化趋势
from (
  --p2p每月交易额以及变化趋势
  select b.the_month mm,
  sum(a.order_amt) p2p_amt_tot 
  from bidata.DM_USER_ORDER_MORE_D a left join bidim.dim_date b on a.date_key = b.date_key
  group by b.the_month
  order by b.the_month desc
)a full join (
  -- 基金每月交易额以及变化趋势
  SELECT to_char(create_time,'yyyymm') mm,sum(trans_amt) / 100 ttj_amt_tot FROM BIFUND.S_FUD_T_FUND_SHARE_ORDER where trans_type = 'I' and status = '05'
  group by to_char(create_time,'yyyymm')
  order by to_char(create_time,'yyyymm') desc
) b on a.mm = b.mm
)where mm between 201701 and 201703
;

--4.2按产品分类计算变化趋势
select mm, --日期
       round(nvl(ttj,0)/10000,0) ttj, -- 基金金额 
       nvl(to_char((ttj - lead(ttj) over(order by rownum)) / lead(ttj) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' ttj_mom, --ttj环比
       nvl(to_char(ttj / tot_amt * 100,'fm9999999990.00'),0) || '%' ttj_percent, -- 基金结构
       round(nvl(p2p_amt,0)/10000,0) p2p_amt, --p2p金额
       nvl(to_char((p2p_amt - lead(p2p_amt) over(order by rownum)) / lead(p2p_amt) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' p2p_mom, --p2p环比
       nvl(to_char(p2p_amt / tot_amt * 100,'fm9999999990.00'),0) || '%' p2p_percent, -- p2p结构
       round(nvl(hz,0)/10000,0) hz, -- 海赚金额
       nvl(to_char((hz - lead(hz) over(order by rownum)) / lead(hz) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' hz_mom, --hz环比
       nvl(to_char(hz / tot_amt * 100,'fm9999999990.00'),0) || '%' hz_percent, -- 海赚结构
       round(nvl(ryf,0)/10000,0) ryf, -- 融易发
       nvl(to_char((ryf - lead(ryf) over(order by rownum)) / lead(ryf) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' ryf_mom, --ryf环比
       nvl(to_char(ryf / tot_amt * 100,'fm9999999990.00'),0) || '%' ryf_percent, -- 融易发结构
       round(nvl(xjl,0)/10000,0) xjl, --小金链
       nvl(to_char((xjl - lead(xjl) over(order by rownum)) / lead(xjl) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' xjl_mom, --xjl环比
       nvl(to_char(xjl / tot_amt * 100,'fm9999999990.00'),0) || '%' xjl_percent, -- 容易发结构
       round(nvl(tot_amt,0)/10000,0) tot_amt, -- 总额
       nvl(to_char((tot_amt - lead(tot_amt) over(order by rownum)) / lead(tot_amt) over(order by rownum) * 100,'fm9999999990.00'),0) || '%' tot_mom --总额环比
from (
  select mm,nvl(hz,0) + nvl(ryf,0) + nvl(xjl,0) p2p_amt,ttj,hz,ryf,xjl,nvl(ttj,0) + nvl(hz,0) + nvl(ryf,0) + nvl(xjl,0) tot_amt
  from (
    select to_char(date_key) mm,parent_bid_type_name type_name,sum(order_amount) amt from (
    select c.the_month date_key,a.order_amount,b.parent_bid_type_name 
    from bidata.dm_order_p2p_ok a left join bidata.dim_prod_p2p_list b on a.bid = b.bid left join bidim.dim_date c on a.date_key = c.date_key
    ) group by date_key,parent_bid_type_name
    union all
    SELECT to_char(create_time,'yyyymm') mm, '基金' type_name,sum(trans_amt) / 100 amt FROM BIFUND.S_FUD_T_FUND_SHARE_ORDER where trans_type = 'I' and status = '05'
    group by to_char(create_time,'yyyymm'),'基金'
   )
  pivot(sum(amt) for type_name in ('基金' ttj,'海赚' hz,'融易发'ryf,'小金链'xjl))
  order by mm desc
) where mm between 201601 and 201701;

-- 4.3 
select p_dur, -- 期限
       round(sum(nvl(amt,0)) / 10000,0) amt, -- 金额
       nvl(round(ratio_to_report(sum(nvl(amt,0))) over() * 100,2) ,0) || '%' whk_percent, -- 比例
       count(bid_status) order_count -- 订单数
from (
select p_dur,amt,day_borrow_duration,
       case when (a.end_time between b.start_date and b.end_date) then 5 
          when (a.end_time between b.start_date and b.end_date) or 
                    (b.end_date between a.date_key and a.end_time) then 6 
          end bid_status
from (
  select a.date_key,to_char(to_date(a.date_key,'yyyymmdd') + day_borrow_duration,'yyyymmdd') end_time,order_amount amt,
          day_borrow_duration,
          decode(borrow_duration_scope,'180-365','180天-365天','30-90','30天-90天','小于30','小于30天','90-180','90天-180天','大于365天') p_dur
      from bidata.dm_order_p2p_ok a left join bidata.dim_prod_p2p_list b on a.bid = b.bid
) a left join (
   select '20170321' start_date, '20170327' end_date from dual
) b on (end_time between start_date and end_date) or (end_date between date_key and end_time)
) 
where bid_status = 6 or bid_status = 5 -- 存量:6 累积:5
group by p_dur ;

-- 4.4
select the_month,hz,xjl,ryf,hz+xjl+ryf tot_amt from (
select * from (
select parent_bid_type_name,the_month,tot_amt
from (
-- 每月到期金额
select parent_bid_type_name,to_char(the_month) the_month,round(nvl(sum(amt),0)/10000,0) tot_amt,'1' result_type from (
select a.date_key,
       to_char(to_date(a.date_key,'yyyymmdd') + day_borrow_duration,'yyyymmdd') end_time,
       c.the_month,
       order_amount amt,
       b.parent_bid_type_name
       from bidata.dm_order_p2p_ok a left join bidata.dim_prod_p2p_list b on a.bid = b.bid left join bidim.dim_date c 
       on to_char(to_date(a.date_key,'yyyymmdd') + day_borrow_duration,'yyyymmdd') = c.date_key
)
group by parent_bid_type_name,to_char(the_month),'1'
union all
-- 存量
select a.parent_bid_type_name,to_char(b.the_month) the_month,round(nvl(sum(amt),0)/10000,2) tot_amt,'2' result_type from (
select a.date_key,
       to_char(to_date(a.date_key,'yyyymmdd') + day_borrow_duration,'yyyymmdd') end_time,
       c.the_month,
       order_amount amt,
       b.parent_bid_type_name
       from bidata.dm_order_p2p_ok a left join bidata.dim_prod_p2p_list b on a.bid = b.bid left join bidim.dim_date c 
       on to_char(to_date(a.date_key,'yyyymmdd') + day_borrow_duration,'yyyymmdd') = c.date_key
) a left join  (
   select * from (
      SELECT 
             to_char(last_day(TO_DATE('2014-01-01', 'yyyy-MM-dd') + ROWNUM - 1),'yyyymmdd') last_day,
             to_char(TO_DATE('2014-01-01', 'yyyy-MM-dd') + ROWNUM - 1,'yyyymm') the_month
      FROM DUAL
      CONNECT BY ROWNUM <=
      trunc(sysdate - to_date('2014-01-01', 'yyyy-MM-dd')) + 1
    )
    group by last_day,the_month
) b on b.last_day between a.date_key and a.end_time
where b.the_month is not null
group by a.parent_bid_type_name,to_char(b.the_month),'2'
)
where result_type = 1 -- 1代表到期  2代表持有
and the_month between 201601 and 201701   --筛选条件
order by the_month
)
pivot(sum(tot_amt) for parent_bid_type_name in ('海赚' hz,'小金链' xjl,'融易发' ryf))
)
order by the_month
;