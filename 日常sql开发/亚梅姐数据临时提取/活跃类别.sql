---------  [20170103-20170202]有一次投资的用户；14667
SELECT COUNT(1)
FROM
  (SELECT t0.F03 hryid,
    COUNT(t0.F03)
  FROM bidata.s_s62_t6250 t0
  WHERE t0.F06 BETWEEN to_date('2017-01-03','yyyy-MM-dd') AND to_date('2017-02-03','yyyy-MM-dd')
  GROUP BY t0.F03
  ---HAVING COUNT(t0.F03)>0
  ) T ;
-------- [20161103-20170202]之内有两次投资的用户（剔重）:19015
SELECT COUNT(1)
FROM
  (SELECT t0.F03 hryid,
    COUNT(t0.F03)
  FROM bidata.s_s62_t6250 t0
  WHERE t0.F06 BETWEEN to_date('2016-11-03','yyyy-MM-dd') AND to_date('2017-02-03','yyyy-MM-dd')
  GROUP BY t0.F03
  HAVING COUNT(t0.F03)>1
  ) T ;
  ----
  select COUNT(distinct(T.hryid)) from (
  SELECT t0.F03 hryid,
    COUNT(t0.F03)
  FROM bidata.s_s62_t6250 t0
  WHERE t0.F06 BETWEEN to_date('2016-11-03','yyyy-MM-dd') AND to_date('2017-02-03','yyyy-MM-dd')
  GROUP BY t0.F03
  UNION all
  SELECT t0.F03 hryid,
    COUNT(t0.F03)
  FROM bidata.s_s62_t6250 t0
  WHERE t0.F06 BETWEEN to_date('2017-01-03','yyyy-MM-dd') AND to_date('2017-02-03','yyyy-MM-dd')
  GROUP BY t0.F03
  ) T

  
-------- 这个需要跟尚忠确认
select 
t0.F01 order_id,
t0.f02 bid,
t0.F03 investor_hryid,
t0.F05 invest_amount,
TO_CHAR(t0.F06,'yyyy-mm-dd hh24:mi:ss') invest_time,
decode(t0.F07,'F','未取消','S','已取消') order_state,
decode(t0.F08,'F','未放款','S','已放款') bid_state,
decode(t1.f20,'SQZ','申请中','DSH','待审核','DFB','待发布','YFB','预发布','TBZ','投标中','DFK','待放款','HKZ','还款中','YJQ','已结清','YLB','已流标','YDF','已垫付','YZF','已作废') 标的状态
FROM bidata.s_s62_t6250 t0
left join bidata.s_s62_t6230 t1
on t0.f02=t1.F01
where t0.F06 BETWEEN to_date('2016-11-01','yyyy-MM-dd') AND to_date('2017-02-01','yyyy-MM-dd')
and t0.F03='11927100'
;
select * from bidata.s_s62_t6252 t0
where t0.f02=5048 and t0.f04=11927100