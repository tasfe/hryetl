select * from tmp_pay_charge;

select trade_status,count(1) from tmp_pay_charge 
group by trade_status;

select trade_status,sum(amount) from tmp_pay_charge
group by trade_status;


select * from tmp_pay_refund;

select status,count(1) from tmp_pay_refund 
group by status;

select status,sum(trade_amount) from tmp_pay_refund 
group by status;


select * from tmp_pay_withdraw;

select status,count(1) from tmp_pay_withdraw 
group by status;

select status,sum(amount) from tmp_pay_withdraw 
group by status;


select * from funduser.t_fund_share_order@FDB 


select * from funduser.t_fund_share_order@FDB
where kjt_cust_id = '100001884720'


select trans_type,status,count(1) from funduser.t_fund_share_order@FDB
where to_char(create_time,'yyyymmdd') between 20170130 and 20170205
--where to_char(create_time,'yyyymm') = 201610
group by trans_type,status
order by trans_type


select trans_type,status,sum(trans_amt) from funduser.t_fund_share_order@FDB
where to_char(create_time,'yyyymmdd') between 20170130 and 20170205
group by trans_type,status
order by trans_type



