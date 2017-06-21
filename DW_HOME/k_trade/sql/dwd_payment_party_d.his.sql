INSERT INTO K_TRADE.DWD_PAYMENT_PARTY_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM payment.tb_party_payment@kjtdb t
--WHERE GMT_CREATE >= to_date('20170101','YYYYMMDD') --and GMT_CREATE < to_date('20170201','YYYYMMDD');


select * from K_TRADE.DWD_DEPOSIT_ORDER_D;