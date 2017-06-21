SELECT T.category_display_name 类别,
  T.yearly_inter*100 利率,
  COUNT(DISTINCT(T.investor_hryid)) 投资用户数,
  sum(T.invest_amount) 累计投资金额
FROM
  (SELECT t0.F01 order_id,
    t0.f02 bid,
    t0.F03 investor_hryid,
    t0.F05 invest_amount,
    TO_CHAR(t0.F06,'yyyy-mm-dd hh24:mi:ss') invest_time,
    ---decode(t0.F07,'F','未取消','S','已取消') order_state,
    v1.category_display_name,
    t2.F06 yearly_inter
  FROM bidata.s_s62_t6250 t0
  LEFT JOIN bidata.v_bid_category v1
  ON t0.f02=v1.bid
  LEFT JOIN BIDATA.S_S62_T6230 t2
  ON t0.f02   =t2.F01
  WHERE t0.F07='F' and t0.f06 < to_date('20170101','yyyymmdd')
  ) T
GROUP BY T.category_display_name,
  T.yearly_inter
ORDER BY T.category_display_name,
  T.yearly_inter ;

select 
T.bid,
t3.f03 b_title,
T.investor_count,
t3.*
from (
select 
t0.f02 bid,
count(distinct(t0.f03)) investor_count
from bidata.s_s62_t6250 t0
group by t0.F02
HAVING count(distinct(t0.f03))<10) T
left JOIN BIDATA.S_S62_T6230 t3
on T.bid=t3.f01
;
----
select 
TT.time_tag,
count(*)
from (
select 
T.hry_id,
T.last_invest_time,
decode(greatest(T.last_invest_time,to_date('20160803','yyyymmdd')),to_date('20160803','yyyymmdd'),'6个月以前',decode(greatest(T.last_invest_time,to_date('20161102','yyyymmdd')),to_date('20161102','yyyymmdd'),'3-6月',decode(greatest(T.last_invest_time,to_date('20170102','yyyymmdd')),to_date('20170102','yyyymmdd'),'1-3月','最近1月内'))) time_tag
from (
select 
---t0.f02 bid,
t0.f03 hry_id,
max(t0.F06) last_invest_time
from bidata.s_s62_t6250 t0
group by t0.f03) T
order by T.last_invest_time desc) TT
group by TT.time_tag
;

