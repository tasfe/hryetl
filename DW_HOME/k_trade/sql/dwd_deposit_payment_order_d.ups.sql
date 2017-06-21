DELETE K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D t 
WHERE  exists (
  select 1 
    from k_trade_ods.ods_deposit_payment_order_inc o 
    where t.PAYMENT_VOUCHER_NO = o.PAYMENT_VOUCHER_NO
);


INSERT INTO K_TRADE.DWD_DEPOSIT_PAYMENT_ORDER_D（
SELECT 
  t.*
  ,sysdate
  ,sysdate
FROM k_trade_ods.ods_deposit_payment_order_inc t
);


