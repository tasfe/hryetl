----------- 首投用户年度分布
select 
T.first_invest inv_year,
count(*)
from (
select 
t0.f03 hryid,
to_char(MIN(t0.f06),'yyyy') first_invest
FROM bidata.s_s62_t6250 t0
where t0.F07='F'
group by t0.F03) T
group by T.first_invest
order by T.first_invest desc
;
-------------- P2P 业务线累积投资:用户、金额
SELECT T.category_display_name,
  COUNT(DISTINCT(T.investor_hryid)),
  SUM(T.invest_amount)
FROM
  (SELECT t0.F01 order_id,
    t0.f02 bid,
    t0.F03 investor_hryid,
    t0.F05 invest_amount,
    t0.F06 invest_time, ---TO_CHAR(t0.F06,'yyyy-mm-dd hh24:mi:ss') invest_time,
    v1.category_display_name,
    v2.YEARLY_INTEREST,
    v2.BID_PERIOD,
    v2.BID_PERID_U
  FROM bidata.s_s62_t6250 t0
  LEFT JOIN bidata.v_bid_category v1
  ON t0.f02=v1.bid
  LEFT JOIN BIDATA.V_BID_ANALYSIS v2
  ON t0.f02   =v2.bid
  WHERE t0.F07='F'
  ) T
where T.invest_time < to_date('20160101','yyyymmdd')
GROUP BY T.category_display_name ;

--------- 基金
select 
*
from funduser.T_FUND_SHARE_ORDER@FDB t0
;

---------
select
T.b_period,
count(distinct T.investor_hryid) 累计投资用户数,
sum(T.invest_amount) 累计投资金额
from (
select 
t0.F01 order_id,
t0.f02 bid,
t0.F03 investor_hryid,
t0.F05 invest_amount,
TO_CHAR(t0.F06,'yyyy-mm-dd hh24:mi:ss') invest_time,
v1.category_display_name,
v2.YEARLY_INTEREST,
v2.BID_PERIOD,
v2.BID_PERID_U,
(case v2.BID_PERID_U
 when '天' then decode(greatest(v2.BID_PERIOD,30),30,'<=30',decode(greatest(v2.BID_PERIOD,90),90,'30<期限<=90',decode(greatest(v2.BID_PERIOD,180),180,'90<期限<=180',decode(greatest(v2.BID_PERIOD,365),365,'180<期限<=365','>365'))))
 when '月' then decode(greatest(v2.BID_PERIOD,3),3,'30<期限<=90',decode(greatest(v2.BID_PERIOD,6),6,'90<期限<=180',decode(greatest(v2.BID_PERIOD,12),12,'180<期限<=365','>365')))
 else '未知周期'
 end) b_period
FROM bidata.s_s62_t6250 t0
left join bidata.v_bid_category v1
on t0.f02=v1.bid
left JOIN BIDATA.V_BID_ANALYSIS v2
on t0.f02=v2.bid
where t0.F07='F' 
and t0.F06 < to_date('20170101','yyyymmdd')
) T
GROUP BY T.b_period
---and v2.BID_PERID_U='月'
;