-- 全量用户表逻辑
select  '${start_date}' rptdt ,sum(reg_num) reg_num,sum(realname_num) realname_num,sum(txn_num) txn_num,'汇总' flag
from(
    select  count(distinct member_id) reg_num ,0 realname_num,0 txn_num 
    from BI_NEW_REGISTER_CUST_D
    where reg_dt<= '${start_date}'
    union all
     select  0,count(distinct kjtid) ,0
    from BI_REAL_NAME_AUTH_CUST_D
   where rptdt<= '${start_date}'
    union all
    select 0,0,count(distinct a.kjtid)  
     from bi_user_exchange a 
     where a.rptdt<= '${start_date}'
)
union all
select '${start_date}' rptdt,reg_num, realname_num, txn_num,
  decode(promoter_source_name,'外部渠道用户','第三方','海融易用户','推荐','口碑') flag from (
  select a.promoter_source_name,sum(reg_users) reg_num, sum(auth_users) realname_num, sum(order_new_users) txn_num
  from dm_user_reg a left join dm_user_auth b on a.date_key = b.date_key and a.promoter_source_name = b.promoter_source_name
  left join DM_USER_ORDER c on a.date_key = c.date_key  and a.promoter_source_name = c.promoter_source_name
  where a.date_key <= '${start_date}'
  group by a.promoter_source_name
);


select '${start_date}' rptdt,reg_num, realname_num, txn_num,
  decode(promoter_source_name,'外部渠道用户','第三方','海融易用户','推荐','口碑') flag from (
  select a.date_key,a.promoter_source_name, reg_users,auth_users, order_new_users
  from dm_user_reg a left join dm_user_auth b on a.date_key = b.date_key and a.promoter_source_name = b.promoter_source_name
  left join DM_USER_ORDER c on a.date_key = c.date_key  and a.promoter_source_name = c.promoter_source_name
  where a.date_key >= 20161215
  
  group by a.promoter_source_name
  order by a.date_key
)

-- 插入数据
insert into tmp_bi_cust_all
select a.date_key rptdt,--reg_users,auth_users, order_new_users,
  sum(reg_users) over(partition by a.flags order by a.date_key) reg_num,
  sum(auth_users) over(partition by a.flags order by a.date_key) realname_num,
  sum(order_new_users) over(partition by a.flags order by a.date_key) txn_num,
  promoter_source_name flag
  from (
  select dat date_key,'口碑' promoter_source_name,nvl(reg_users, 0) reg_users,nvl(auth_users,0) auth_users,
    nvl(order_new_users,0) order_new_users,'1' flags  from 
  (
    select to_char(to_date('2016-12-15','yyyy-mm-dd')+level-1,'yyyymmdd') as dat from dual
    connect by level <=to_date('2017-04-12','yyyy-mm-dd')-to_date('2016-12-15','yyyy-mm-dd')+1
    ) b left join (
    select a.date_key,a.promoter_source_name,reg_users, auth_users, order_new_users
    from dm_user_reg a left join dm_user_auth b on a.date_key = b.date_key and a.promoter_source_name = b.promoter_source_name
    left join DM_USER_ORDER c on a.date_key = c.date_key  and a.promoter_source_name = c.promoter_source_name
    where a.date_key >= 20161215  and a.promoter_source_name = '自然注册'
    order by a.date_key
    ) a on b.dat = a.date_key
    order by b.dat
) a order by date_key



select * from dm_user_reg

