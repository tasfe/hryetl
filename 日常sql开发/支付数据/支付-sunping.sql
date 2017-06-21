---- 收单
select
* from (
select
decode(t.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') 业务和支付方式,
decode(p.status,'S','支付成功','未支付') 交易状态,
count(p.payment_voucher_no) 订单笔数,
sum(p.amount) 交易金额
  FROM tss.t_pay_method@kjtdb t
  LEFT JOIN tss.t_payment_order@kjtdb p
    ON p.payment_voucher_no = t.payment_voucher_no
  LEFT JOIN tss.t_trade_order@kjtdb tr
    ON tr.trade_voucher_no = p.trade_voucher_no
  LEFT JOIN tss.t_trade_fee@kjtdb tf
    ON tf.trade_voucher_no = tr.trade_voucher_no
   AND tf.party_role = 'payee'
  LEFT JOIN payment.tb_payment_order@kjtdb po
    ON po.payment_order_no = p.payment_voucher_no
  LEFT JOIN cmf.tt_cmf_order@kjtdb co
    ON co.payment_seq_no = po.payment_seq_no
 WHERE to_char(tr.gmt_create,'yyyymmdd') >= '20170313'
   AND to_char(tr.gmt_create,'yyyymmdd') < '20170320'
   AND t.extension IS NOT NULL
   AND t.pay_mode in ('ONLINE_BANK','BALANCE','QPAY','TRUST_COLLECT')
group by 
decode(t.pay_mode,'ONLINE_BANK','网银支付','BALANCE','余额支付','QPAY','快捷支付','TRUST_COLLECT','代扣支付','FUNDSHARE_PAY','基金支付','其他支付方式') ,
decode(p.status,'S','支付成功','未支付')
UNION ALL
---- 转账到卡
select
'转账到卡' AS 业务和支付方式,
decode(t0.status,'bankSuccess','交易成功','交易失败') 交易状态,
--t0.status,---decode(t0.status,'401','已支付','未支付') 交易状态,---'100','申请成功','998','支付失败','999','支付关闭','其它状态') 交易状态,
count(*) 订单笔数,
sum(t0.amount) 交易金额
FROM fos.tt_fundout_order@kjtdb t0
WHERE t0.product_code IN ('10220', '10230') and t0.order_time>=to_date('20170313','yyyymmdd') and  t0.order_time<to_date('20170320','yyyymmdd')
group by decode(t0.status,'bankSuccess','交易成功','交易失败'),'转账到卡'

UNION ALL

--- 退款
select
'退款交易' AS 业务和支付方式,
decode(t.status,'951','退款成功','952','退款失败') 交易状态,
count(*) 订单笔数,
sum(trade_amount) 交易金额
FROM tss.t_trade_order@kjtdb t
WHERE t.status IN ('951', '952') and  t.gmt_submit >= to_date('20170313','yyyymmdd') and t.gmt_submit < to_date('20170320','yyyymmdd')
group by decode(t.status,'951','退款成功','952','退款失败'),'退款交易'

UNION ALL

---- 充值交易
select
'充值交易' AS 业务和支付方式,
decode(t.trade_status,'S','支付成功','未完成支付') 交易状态,
count(t.trade_voucher_no) 订单笔数,
sum(t.amount) 交易金额
from deposit.t_deposit_order@kjtdb t
where t.gmt_submit >= to_date('20170313','yyyymmdd') and t.gmt_submit < to_date('20170320','yyyymmdd')
group by decode(t.trade_status,'S','支付成功','未完成支付'),'充值交易'

UNION ALL
------ 提现交易
select
'提现交易' AS 业务和支付方式,
decode(t0.status,'bankSuccess','提现成功','提现失败') 交易状态,
count(t0.fundout_order_no) 订单笔数,
sum(t0.amount) 交易金额
from FOS.TT_FUNDOUT_ORDER@kjtdb t0
where  t0.PRODUCT_CODE in (10210,10211) ---产品码含义:10210 提现T+N ,10211 提现实时
AND t0.order_time >=to_date('20170313','yyyymmdd') and t0.order_time <to_date('20170320','yyyymmdd')
group by decode(t0.status,'bankSuccess','提现成功','提现失败'),'提现交易'

UNION ALL
--- 转账到账户
select
decode(t1.member_type,1,'个人转账到账户','企业商户转账到账户') 业务和支付方式,---,3,'特约商户'
decode(t0.status,'401','已支付','未支付') 交易状态,---'100','申请成功','998','支付失败','999','支付关闭','其它状态') 交易状态,
count(*) 订单笔数,
sum(t0.trade_amount) 交易金额
FROM tss.t_trade_order@kjtdb t0
left join member.tm_member@kjtdb t1
on t0.buyer_id=t1.member_id
WHERE t0.biz_product_code IN ('10310', '10231') and t0.gmt_submit>=to_date('20170313','yyyymmdd') and t0.gmt_submit<to_date('20170320','yyyymmdd')
group by decode(t1.member_type,1,'个人转账到账户','企业商户转账到账户'),decode(t0.status,'401','已支付','未支付')

union all
---- 基金申购
select
'基金申购' AS 业务和支付方式,
decode(t0.status,5,'申购成功','申购失败') 交易状态,
count(*) 订单笔数,
sum(t0.trans_amt)/100 金额
from fund.t_fund_share_order@FDB t0
where t0.trans_type='I' and t0.create_time >=to_date('20170313','yyyymmdd') and t0.create_time <to_date('20170320','yyyymmdd') and (t0.status=5 or t0.status>=20)
group by '基金申购',decode(t0.status,5,'申购成功','申购失败')

union all
---基金赎回
select
'基金赎回' AS 业务和支付方式,
decode(t0.status,5,'赎回成功','赎回失败') 交易状态,
count(*) 订单笔数,
sum(t0.trans_amt)/100 金额
from fund.t_fund_share_order@FDB t0
where t0.trans_type='O' and t0.create_time >=to_date('20170313','yyyymmdd') and t0.create_time <to_date('20170320','yyyymmdd') and (t0.status=5 or t0.status>=20)
group by '基金赎回',decode(t0.status,5,'赎回成功','赎回失败')
) T
order by T."业务和支付方式",T."交易状态"
;




