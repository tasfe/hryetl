with user_promot as (
select 
promoter_id
,user_name
,mobile
,substr(id_card,13) idcard
, a.promoted_id promoted_hryid 
from dim_promo_promotion_relation a 
inner join dim_user_hry_users b 
on a.promoter_id=b.hryid 
where emp_type='内部员工'
AND to_char(a.action_time,'yyyymm')='201705'
)



select 
s0.promoter_id
,s0.user_name
,s0.mobile
,s0.idcard
,count(DISTINCT promoted_hryid) 推荐人数
,sum(nvl(s1.order_amount,0)) 被推荐人P2P投资总额
from user_promot s0 
left join dm_order_p2p_ok s1 
on s0.promoted_hryid=s1.hryid 
--where substr(s1.date_key,0,6)=201705
group by s0.promoter_id,s0.user_name,s0.mobile,s0.idcard
order by count(DISTINCT promoted_hryid) desc
;
