INSERT INTO K_TRADE.DWD_TSS_TRADE_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM tss.t_trade_order@kjtdb t
WHERE GMT_SUBMIT >= to_date('20170101','YYYYMMDD') --and GMT_CREATE < to_date('20170201','YYYYMMDD');

