SELECT distinct merchant_id  FROM (
SELECT t.merchant_id FROM voucher.t_union_bill@kjtdb t where t.merchant_id like '1%' and t.trade_status='995'  and  t.trade_time< to_date('20170101000000','yyyymmddhh24miss')  group by t.merchant_id
union all
SELECT t.member_id FROM voucher.t_union_bill@kjtdb t where t.member_id like '1%' and t.trade_status='995'  and  t.trade_time < to_date('20170101000000','yyyymmddhh24miss') group by t.member_id)