

INSERT INTO K_TRADE.DWD_FUNDOUT_PAYMENT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM fos.tt_payment_order@kjtdb t;
