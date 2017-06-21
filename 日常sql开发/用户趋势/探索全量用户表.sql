--全量
select flag 来源类型, reg_num 注册用户, realname_num 实名用户, txn_num 交易用户,
       TO_CHAR( realname_num / reg_num * 100,'990.99')||'%' 认证率,
       TO_CHAR( txn_num / reg_num * 100,'990.99')||'%' 交易率
  from BI_CUST_ALL
 where rptdt = 20170331
 order by decode(flag, '汇总', 1, '推荐', 2, '第三方', 3,'口碑', 4,5)
 

-- 截止到当日,各渠道用户数
select '${start_date}' rptdt,reg_num, realname_num, txn_num, promoter_source_name flag from (
  select a.promoter_source_name,sum(reg_users) reg_num, sum(auth_users) realname_num, sum(order_new_users) txn_num
  from dm_user_reg a left join dm_user_auth b on a.date_key = b.date_key and a.promoter_source_name = b.promoter_source_name
  left join DM_USER_ORDER c on a.date_key = c.date_key  and a.promoter_source_name = c.promoter_source_name
  group by a.promoter_source_name
)
;


-- 手机渠道
select * from bi_offline_usr

-- 三方渠道
select * from s_promo_channel_info 

-- 推广关系个数129085
select count(distinct(promoted_id)) from s_promo_promotion_relation

-- 含有三方关系的推广信息
select * from s_promo_promotion_relation a inner join s_promo_channel_info b
on a.promoter_id = b.id 

-- 某一天三方推荐人数
select count(distinct(promoted_id)) from s_promo_promotion_relation a inner join s_promo_channel_info b
on a.promoter_id = b.id 
where to_char(a.created_time,'yyyymmdd') = 20170412


select * from dm_user_reg

select sum(reg_users) from dm_user_reg

select count(1) from member.TM_MEMBER@kjtdb 
select * from member.TM_MEMBER@kjtdb 


select * from DIM_PROMO_PROMOTION_RELATION

-- 各渠道人数
select promoter_source_name,sum(reg_users) tot from dm_user_reg
group by promoter_source_name