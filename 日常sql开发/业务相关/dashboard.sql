-- 投资笔数 p2p --520761(p2p) + 474(基金) = 521235
select count(1) 投资笔数 from S_S62_T6250 where f08 = 'S'

-- p2p累积交易金额 --  8898386095 + 918059(基金) = 8899304154
select sum(f04) from S_S62_T6250 where f07 = 'F' 


-- 投资人数 p2p   133792 + 294(p2p) = 134086
select count(distinct(f03)) from S_S62_T6250 where f07 = 'F'



-- 注册用户 kjt hry
select * from member.TM_MEMBER@kjtdb
--2269064
select COUNT(1) from member.TM_MEMBER@kjtdb where lock_status = 0 and verify_level is not null and member_type in (1,2)

select COUNT(1) from member.TM_MEMBER@kjtdb WHERE verify_level is not null

select * from member.TM_MEMBER@kjtdb where lock_status = 0 and verify_level is not null and member_type not in (1,2)

-------- 总体分析
select to_char(sysdate - 1,'yyyymmdd') rptdt,reg_count,trade_user_count,trade_count,amount from (select COUNT(1) as reg_count from member.TM_MEMBER@kjtdb),
(
  select count(distinct(hryid)) trade_user_count from (
    select a.f03 hryid,b.kjtid kjtid from S_S62_T6250 a left join S_S61_T6110 b on a.f03 = b.f01
    where a.f07 = 'F'
  )c left join (
    select * from FUND.T_FUND_SHARE_ORDER_YM@fdb  where trans_type = 'I' and payment_status = 'S'
  ) d on c.kjtid = d.kjt_cust_id
),( 
  select sum(counts) trade_count from (
    select count(1) counts from S_S62_T6250 where f08 = 'S' union select count(1) counts from FUND.T_FUND_SHARE_ORDER_YM@fdb where trans_type = 'I' and payment_status = 'S' 
   )
),(
  select sum(amt) amount from (
    select sum(f04) amt from S_S62_T6250 where f07 = 'F' union select sum(success_amt) amt from FUND.T_FUND_SHARE_ORDER_YM@fdb where trans_type = 'I' and payment_status = 'S'
    )
)

-- 登陆活跃 按小时划分
select to_char(log_time,'hh24'),count(distinct(device_id)) from bi_log  where sid is not null 
group by to_char(log_time,'hh24') 
order by to_char(log_time,'hh24')
-- 交易活跃 按小时划分
select to_char(f06,'hh24'),count(distinct(f03)) from s_s62_t6250 where f07 = 'F'
group by to_char(f06,'hh24')
order by to_char(f06,'hh24')



select to_char(sysdate - 1,'yyyymmdd') RPTDT,a.dt,a.login_count,b.trade_count from (
-- 登陆活跃 按小时划分
select to_char(log_time,'hh24') dt,count(distinct(device_id)) login_count from bi_log  where sid is not null 
group by to_char(log_time,'hh24') 
order by to_char(log_time,'hh24')
) a full join (
-- 交易活跃 按小时划分
select to_char(f06,'hh24') dt,count(distinct(f03)) trade_count from s_s62_t6250 where f07 = 'F'
group by to_char(f06,'hh24')
order by to_char(f06,'hh24')
) b on a.dt = b.dt




select * from bi_exchange_by_dt

--按时间,类型 分组
select dt,类型 type,sum(交易总额) from bi_exchange_by_dt group by dt,类型 order by dt
  
select * from s_s62_t6250 where f03 = '11766425'

select * from S_S65_T6501 where f08 = '11766425' AND F03 = 'CG'


select created_time rptdt,
case when (channel_name is not null) then 3
when  (channel_name is null and promoter_id is not null) then 2
  else 1 end as channel_type,
case when (channel_name is not null) then channel_name
when  (channel_name is null and promoter_id is not null) then '推荐' 
  else '自然注册' end as channel_name
   ,count(1) as user_num
 from 
(
select to_char(a.created_time,'yyyymmdd') created_time,a.f01,b.promoter_id,b.promoted_id, decode(c.channel_name,null,decode(d.channelname,'youmi',d.channelname,null),c.channel_name) as channel_name from s_s61_t6110 a left join s_promo_promotion_relation b on a.f01=b.promoted_id left join s_promo_channel_info c on b.promoter_id = c.ID
left join bi_offline_usr d on a.kjtid = d.memberid
--where to_char(a.created_time,'yyyymmdd') = '${start_date}'  --去掉注释之后是按日跑
)
group by 
case when (channel_name is not null) then 3
when  (channel_name is null and promoter_id is not null) then 2
  else 1 end,
case when (channel_name is not null) then channel_name
when  (channel_name is null and promoter_id is not null) then '推荐' 
  else '自然注册' end,
created_time
  order by created_time desc

