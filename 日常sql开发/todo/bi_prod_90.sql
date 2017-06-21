------------ 交易 tss -- 收单转账  ------------
-- 目前业务场景 一对多 ,账户转账 一对一
select * from tss.t_trade_order@kjtdb;
select * from  tss.t_payment_order@kjtdb; 

----- 支付方式
select * from tss.t_pay_method@kjtdb
select distinct(t0.pay_mode)
from tss.t_pay_method@kjtdb t0
--  交易状态 变更表 tts.t_trade_status_his

------------ 出款 fos ------------
-- 目前业务场景  一对一
select * from fos.tt_fundout_order@kjtdb;
select * from fos.tt_payment_order@kjtdb;


------------ 充值 deposit
select * from deposit.t_deposit_order@kjtdb;
select * from deposit.t_payment_order@kjtdb;

select
decode(t.trade_type,01,'转账',17,'代扣',18,'基金',11,'即时到帐',12,'担保',14,'收单退款',15,'合并',19,'转账到卡') 交易类型 ,
*
from tss.t_trade_order@kjtdb t; -- 转账和收单
select distinct(t.trade_type) from tss.t_trade_order@kjtdb t;

-- 业务产品码 == 王贤亮

--- 账户转账 的交易 只有一笔支付订单

select * from  tss.t_payment_order@kjtdb;  

