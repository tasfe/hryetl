SELECT t0.f01 标的id,
  t0.F03 标的名称,
  decode(t0.f20,'SQZ','申请中','DSH','待审核','DFB','待发布','YFB','预发布','TBZ','投标中','DFK','待放款','HKZ','还款中','YJQ','已结清','YLB','已流标','YDF','已垫付','YZF','已作废') 标的状态,
  t0.f05 发标金额,
  (t0.f05-t0.F07) 已募集金额,
  (
  CASE
    WHEN t2.f21='S'
    THEN t2.f22
    WHEN t2.f21='F'
    THEN t0.f09
  END) 借款期限,
  decode(t2.F21,'S','天','F','月') 借款期限单位,
  t0.f06*100 年化利率,
  DECODE(t0.F10,'DEBX','等额本息','MYFX','每月付息,到期还本','YCFQ','本息到期一次付清','DEBJ','等额本金','DBDX','等本等息') 还款方式,
  DECODE(t0.f17,'ZRY','自然月','GDR','固定日') 付息方式,
  TO_CHAR(t0.F22,'yyyy-MM-dd') 标的上线时间,
  t1.售罄时间 标的募集所花时间
FROM s_s62_t6230 t0
LEFT JOIN bi_prod_end t1
ON t0.f01=t1.PID
LEFT JOIN s_s62_t6231 t2
ON t0.f01=t2.F01
WHERE t0.F22 BETWEEN to_date('20161214','yyyy-MM-dd') AND to_date('20170121','yyyy-MM-dd')
ORDER BY TO_CHAR(t0.F22,'yyyy-MM-dd') ;