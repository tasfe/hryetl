
-- 理财金
select decode(grouping(the_month)+grouping(reward_status_code),1,'小计',2,'合计',the_month) the_month,
       reward_status_code,
       sum(amt)
from (
select b.the_month,reward_status_code,sum(rewards_amt) amt
from bidata.DW_LCJ_GRANT a left join bidim.dim_date b on a.date_key = b.date_key
group by b.the_month,reward_status_code
order by b.the_month
)
group by rollup(the_month,reward_status_code)


-- 收益加速
select b.the_month, sum(order_amount / 100) amt
  from bidata.dw_accelerator_grant a 
  left join bidim.dim_date b on a.date_key = b.date_key
group by b.the_month
order by b.the_month


-- 投资券
select * from bidata.DW_COUPON_GRANT a left join bidim.dim_date b on a.date_key = b.date_key;

select activity_id,activity_name,dis_channel_type,activity_type_name from bidata.DW_COUPON_GRANT a left join bidim.dim_date b on a.date_key = b.date_key
group by activity_id,activity_name,dis_channel_type,activity_type_name;
-- activity_id 38:注册 41:推荐

-- 注册
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where activity_name like '%注册%' and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

-- 首投
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where activity_name like '%首投%' and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

-- 推荐
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where activity_name like '%推荐%' and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

-- 投资
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where activity_name like '%投资%' and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

-- 领券中心
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where activity_type_name like '%领券中心%' --and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

-- 海尔渠道
select decode(grouping(the_month)+grouping(name),1,'小计',2,'合计',the_month) the_month,
       name,
       sum(amt) amt
  from (
    select b.the_month,a.COUPON_STATUS_NAME name,sum(coupon_value) amt from bidata.DW_COUPON_GRANT a
      left join bidim.dim_date b
        on a.date_key = b.date_key
     where dis_channel_type = '线下渠道' --and activity_name not like '%测试%'
     group by b.the_month,a.COUPON_STATUS_NAME
)
group by rollup(the_month,name);

