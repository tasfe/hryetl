select 
a.hryid
,a.mobile
,a.user_name
,substr(a.id_card,13) idcard
,sum(b.order_amount) order_amt
,count(1) order_num 
from dim_user_hry_users a
inner join dm_order_p2p_ok b 
on a.hryid=b.hryid
where emp_type='内部员工' 
and to_char(reg_time_new,'yyyymm')=201705 
and substr(b.date_key,0,6)=201705
group by a.hryid,a.mobile,a.user_name,a.id_card
order by order_amt desc