-- 交易用户地区分布
select * from (
select phone_province,count(1) total_users from ods_user_hry_users a inner join 
(select distinct kjtid from BI_USER_EXCHANGE ) b on a.kjtid=b.kjtid
group by phone_province
order by total_users desc
) where rownum<11
;


-- 流失用户地区分布
select phone_province,count(1) total_users from 
(
select a.kjtid,phone_province,ceil(months_between(sysdate,to_date(max(rptdt),'yyyymmdd')))  max_dt from BI_USER_EXCHANGE a inner join ods_user_hry_users b on a.kjtid=b.kjtid
group by a.kjtid,phone_province
having  ceil(months_between(sysdate,to_date(max(rptdt),'yyyymmdd')))>6
) t where
 kjtid not in ( select distinct kjtid from s_s62_t6252 t inner join ods_user_hry_users b on t.f04=b.hryid where t.F09 in ('WH','HKZ') )
and kjtid not in  (select kjt_cust_id  from funduser.t_fund_share_info@fdb where avl_share>100)
group by phone_province
order by total_users desc
;




-------------
-- 交易用户地区分布
select * from (
select phone_province,count(1) total_users from ods_user_hry_users a inner join 
(
select distinct kjtid from BI_USER_EXCHANGE 
where rptdt <20170101
) b on a.kjtid=b.kjtid
group by phone_province
order by total_users desc
) where rownum<11



-- 流失用户地区分布
select phone_province,count(1) total_users from 
(
select a.kjtid,phone_province,ceil(months_between(sysdate,to_date(max(rptdt),'yyyymmdd')))  max_dt from BI_USER_EXCHANGE a inner join ods_user_hry_users b on a.kjtid=b.kjtid
group by a.kjtid,phone_province
having  ceil(months_between(sysdate,to_date(max(rptdt),'yyyymmdd')))>6
) t where
 kjtid not in ( select distinct kjtid from s_s62_t6252 t inner join ods_user_hry_users b on t.f04=b.hryid where t.F09 in ('WH','HKZ') )
and kjtid not in  (select kjt_cust_id  from funduser.t_fund_share_info@fdb where avl_share>100)
group by phone_province
order by total_users desc