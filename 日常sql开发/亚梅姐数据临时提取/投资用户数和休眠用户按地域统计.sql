select phone_province,count(distinct hryid) users
from 
(
select hryid,phone_province,max(fshtime),min(spanMonths)
from (
select  a.hryid,a.kjtid,phone_province, b.pid,b.fshtime,ceil(months_between(sysdate,fshtime)) as spanMonths 
from bidata.ods_user_hry_users a 
inner join bidata.ods_order_p2p_list b 
on a.hryid=b.hryid where -- a.hryid=31053
  b.orderstatus='CG'
) t 
where spanMonths>6
and hryid not in (select distinct f04 hryid 
from bidata.s_s62_t6252 t0 
where t0.F09 in ('WH','HKZ'))
and kjtid not in (select kjt_cust_id  from funduser.t_fund_share_info@fdb where avl_share>100)
group by hryid,phone_province
) t
group by phone_province
order by users desc
;

------ 投资用户总数
select 
sum(total_users)
from
(
select a.phone_province,count(distinct a.hryid) total_users 
from bidata.ods_user_hry_users a 
inner join bidata.ods_order_p2p_list b 
on a.hryid=b.hryid
where b.orderstatus='CG'
group by a.phone_province
order by total_users desc
) 
;
------ 投资用户地域分布
select 
*
from
(
select a.phone_province,count(distinct a.hryid) total_users 
from bidata.ods_user_hry_users a 
inner join bidata.ods_order_p2p_list b 
on a.hryid=b.hryid
where b.orderstatus='CG'
group by a.phone_province
order by total_users desc
) 
;



-- 地区投资用户数
select b.phone_province,count(distinct a.hryid) order_users from dm_order_p2p_ok a  inner join dim_user_hry_users b on a.hryid=b.hryid where a.date_key<=20170331
group by b.phone_province
order by order_users desc;
-- 流失用户
select phone_province,count(distinct hryid) users
from 
(
select hryid,phone_province,max(fshtime),min(spanMonths)
from (
select  a.hryid,a.kjtid,phone_province, b.bid,b.finish_time as fshtime,ceil(months_between(sysdate,finish_time)) as spanMonths 
from bidata.dim_user_hry_users a 
inner join bidata.dw_order_p2p_list b
on a.hryid=b.hryid  where fangkuan_status='已放款' and to_char(finish_time,'yyyymmdd')<= 20170331
) t 
where spanMonths>6
and hryid not in (select distinct f04 hryid 
from bidata.s_s62_t6252 t0 
where t0.F09 in ('WH','HKZ'))
and kjtid not in (select kjt_cust_id  from  bifund.s_fud_t_fund_share_info  where avl_share>100)
group by hryid,phone_province
) t
group by phone_province
order by users desc
;