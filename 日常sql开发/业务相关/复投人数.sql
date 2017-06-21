

---复投人数
SELECT kjt_cust_id,count(1) 
FROM FUND.T_FUND_SHARE_ORDER_YM@fdb T
WHERE T.TRANS_TYPE IN ('I', 'O') and payment_status='S'
having count(1)>=2
group by kjt_cust_id
--88

----2次复投(不含2次)以上人数
SELECT kjt_cust_id,count(1) 
FROM FUND.T_FUND_SHARE_ORDER_YM@fdb T
WHERE T.TRANS_TYPE IN ('I', 'O') and payment_status='S'
having count(1)>2
group by kjt_cust_id
--33


SELECT *
FROM FUND.T_FUND_SHARE_ORDER_YM@fdb T left join s_s61_t6110 b on T.kjt_cust_id = b.KJTID
WHERE T.TRANS_TYPE IN ('I', 'O') and payment_status='S'
and success_amt = 400
