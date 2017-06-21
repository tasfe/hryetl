 


INSERT INTO K_TRADE.DWD_FUNDOUT_ORDER_D
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM fos.tt_fundout_order@kjtdb t

select * from K_TRADE.DWD_FUNDOUT_ORDER_D;


 