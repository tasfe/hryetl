----- 基金投资
WITH TMP_USER AS (
select
t1.HRYID hryid
,t0.phone STAFF_PHONE
,t1.AUTHENT_STATUS_NAME
,t1.kjtid

from BIDIM.OBJ_HAIR_GROUP_STAFF_PHONE_M5 t0
inner join BIDATA.DIM_USER_HRY_USERS  t1
on t0.phone=t1.HRY_ACCT or t0.phone=t1.MOBILE
where t1.CTIME < to_date('20170601','yyyymmdd')
)

SELECT
'天天聚投资' as flag
,sum(s1.order_amt) order_amt
FROM TMP_USER S0
LEFT JOIN BIDATA.DW_ORDER_FUND_LIST s1
ON S0.HRYID=S1.HRYID
WHERE S1.FUND_TYPE='天天聚' 
AND s1.trade_type='申购'
AND s1.order_time<to_date('20170601','yyyymmdd')
group by '天天聚投资'
UNION all
-----  P2P 投资
SELECT
'P2P投资' as flag
,sum(s1.order_amount) order_amt
FROM TMP_USER S0
LEFT JOIN BIDATA.DW_ORDER_P2P_LIST S1
ON S0.HRYID=S1.HRYID
WHERE S1.pay_status_name ='支付成功'
AND S1.CTIME < to_date('20170601','yyyymmdd')
group by 'P2P投资'
;

