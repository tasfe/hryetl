------ 还款统计标的明细
SELECT T1.*,
  t3.f22 借款期限天,
  TO_CHAR(t4.f08,'yyyy-MM-dd') 应还日期,
  t4.f06 期号,
  t4.bill_count 还款笔数,
  t4.total_amount 应还总金额,
  t3.f16 还款来源
FROM
  (SELECT t0.f01 bid,
    t0.F03 标的名称,
    t1.F02 标的类型,
    t0.f05 借款金额,
    DECODE(t0.f20,'SQZ','申请中','DSH','待审核','DFB','待发布','YFB','预发布','TBZ','投标中','DFK','待放款','HKZ','还款中','YJQ','已结清','YLB','已流标','YDF','已垫付','YZF','已作废') 标的状态,
    (t0.f05-t0.F07) YMJE,
    TO_CHAR(t0.f24,'yyyy-MM-dd hh24:mm:ss') 申请时间,
    TO_CHAR(t0.f22,'yyyy-MM-dd hh24:mm:ss') 发标时间,
    t0.f09 "借款周期(月)",
    DECODE(t0.f10,'DEBX','等额本息','MYFX','每月付息,到期还本','YCFQ','本息到期一次付清','DEBJ','等额本金','DBDX','等本等息') 还款方式,
    DECODE(t0.f17,'ZRY','自然月','GDR','固定日') 付息方式
  FROM s_s62_t6230 t0
  LEFT JOIN s_s62_t6211 t1
  ON t0.f04     =t1.F01
  --- WHERE t0.f20 IN ('SQZ','DSH','DFB','YFB','TBZ','DFK','HKZ','YDF')
  WHERE t0.f20 ='HKZ'
  ORDER BY t0.f24 DESC
  ) T1
LEFT JOIN S_S62_T6231 t3
ON T1.bid=t3.f01
LEFT JOIN
  (SELECT t5.f02 bid,
    t5.f06,
    t5.f08,
    COUNT(*) bill_count,
    SUM(t5.f07) total_amount
  FROM s_s62_T6252 t5
  GROUP BY t5.F02,
    t5.F06,t5.f08
  ) t4
ON T1.bid=t4.bid 
--- order by T1.bid desc,t4.f06 asc
order by TO_CHAR(t4.f08,'yyyy-MM-dd') asc
;

------- 按日总还款计划
select 
return_date 应还款日期,
count(*) 应还标的数,
sum(total_amount) 应还总金额
from (
SELECT T1.*,
  t3.f22 借款期限天,
  TO_CHAR(t4.f08,'yyyy-MM-dd') return_date,
  t4.f06 期号,
  t4.bill_count 还款笔数,
  t4.total_amount,
  t3.f16 还款来源
FROM
  (SELECT t0.f01 bid,
    t0.F03 标的名称,
    t1.F02 标的类型,
    t0.f05 借款金额,
    DECODE(t0.f20,'SQZ','申请中','DSH','待审核','DFB','待发布','YFB','预发布','TBZ','投标中','DFK','待放款','HKZ','还款中','YJQ','已结清','YLB','已流标','YDF','已垫付','YZF','已作废') 标的状态,
    (t0.f05-t0.F07) YMJE,
    TO_CHAR(t0.f24,'yyyy-MM-dd hh24:mm:ss') 申请时间,
    TO_CHAR(t0.f22,'yyyy-MM-dd hh24:mm:ss') 发标时间,
    t0.f09 "借款周期(月)",
    DECODE(t0.f10,'DEBX','等额本息','MYFX','每月付息,到期还本','YCFQ','本息到期一次付清','DEBJ','等额本金','DBDX','等本等息') 还款方式,
    DECODE(t0.f17,'ZRY','自然月','GDR','固定日') 付息方式
  FROM s_s62_t6230 t0
  LEFT JOIN s_s62_t6211 t1
  ON t0.f04     =t1.F01
  --- WHERE t0.f20 IN ('SQZ','DSH','DFB','YFB','TBZ','DFK','HKZ','YDF')
  WHERE t0.f20 ='HKZ'
  ORDER BY t0.f24 DESC
  ) T1
LEFT JOIN S_S62_T6231 t3
ON T1.bid=t3.f01
LEFT JOIN
  (SELECT t5.f02 bid,
    t5.f06,
    t5.f08,
    COUNT(*) bill_count,
    SUM(t5.f07) total_amount
  FROM s_s62_T6252 t5
  GROUP BY t5.F02,
    t5.F06,t5.f08
  ) t4
ON T1.bid=t4.bid 
order by T1.bid desc,t4.f06 asc
) ts
group by return_date
order by return_date asc
;
