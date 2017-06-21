--  1）投资周期30天以下、30天、90天、180天和365天及以上订单数比例
select fanwei,count(1) orders from (
select  order_id,
        HRYID,
        decode(greatest(p_duration,29),29,'30天以下',decode(greatest(p_duration,89),89,'30-90',decode(greatest(p_duration,179),179,'90-180',
         decode(greatest(p_duration,364),364,'180-365','365以上')))) fanwei,
        BUY_BALANCE
  from (
   select decode(b.DAY_BORROW_DURATION,0,b.MONTY_BORROW_DURATION * 30,b.DAY_BORROW_DURATION) p_duration,
          a.ORDER_ID,
          a.BUY_BALANCE,
          a.HRYID
     from ODS_ORDER_P2P_LIST a left join ODS_PROD_P2P_LIST b on a.pid = b.pid
    where a.ORDERSTATUS = 'CG' --and a.pay_status = 'ZFCG'
)
)group by fanwei
order by fanwei
   
--  2）投资金额5万以下、5万-10万，10-30万，30万以上的用户比例
select tot_amt,count(1) from (
select 
      decode(greatest(amt,49999.99),49999.99,'5万以下',decode(greatest(amt,99999.99),99999.99,'5-10w',
        decode(greatest(amt,299999.99),299999.99,'10-30w','大于等于30w'))) tot_amt,
      hryid
from (
select hryid,sum(buy_balance) amt
from (
  select decode(b.DAY_BORROW_DURATION,0,b.MONTY_BORROW_DURATION * 30,b.DAY_BORROW_DURATION) p_duration,
            a.ORDER_ID,
            a.BUY_BALANCE,
            a.HRYID
       from ODS_ORDER_P2P_LIST a left join ODS_PROD_P2P_LIST b on a.pid = b.pid
      where a.ORDERSTATUS = 'CG' --and a.pay_status = 'ZFCG'
)
group by hryid
)
) group by tot_amt


--  3）投资频率1次，2次及2次以上的用户比例
select counts,count(1)
from (
select hryid,decode(count(1),1,'一次',2,'二次','多次') counts from (
select decode(b.DAY_BORROW_DURATION,0,b.MONTY_BORROW_DURATION * 30,b.DAY_BORROW_DURATION) p_duration,
            a.ORDER_ID,
            a.BUY_BALANCE,
            a.HRYID
       from ODS_ORDER_P2P_LIST a left join ODS_PROD_P2P_LIST b on a.pid = b.pid
      where a.ORDERSTATUS = 'CG' --and
)group by hryid
)group by counts





