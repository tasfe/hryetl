--账号,投资金额,首投时间,投资期限,投资次数
  select d.hryid hryid,d.f04 first_amt,d.f06 first_time,d.rn1 orders,d.duration from (
    select user_id kjtid from bi_log
    where 
    channel = 'JRTT' 
    and event_type = 'register' and event_status = 'success'
  ) a
  left join s_s61_t6110 b on a.kjtid = b.kjtid
  left join (
      select * from s_s61_t6141 where f04 = 'TG'
  ) c on b.f01 = c.f01
  inner join (
    select * from (
      select f03 hryid,
             a.*,
             rank() over(partition by f03 order by f06 asc) rn,
             rank() over(partition by f03 order by f06 desc) rn1,
             rank() over(partition by f03 order by day_borrow_duration) rn2,
             b.duration || b.duration_name duration
      from s_s62_t6250 a left join dim_prod_p2p_list b on a.f02 = b.bid
      where f07 = 'F'
    )where rn = 1
  ) d on b.f01 = d.hryid
  order by d.hryid;


-- 最长投资期限
  select d.hryid hryid,d.duration from (
    select user_id kjtid from bi_log
    where 
    channel = 'JRTT' 
    and event_type = 'register' and event_status = 'success'
  ) a
  left join s_s61_t6110 b on a.kjtid = b.kjtid
  left join (
      select * from s_s61_t6141 where f04 = 'TG'
  ) c on b.f01 = c.f01
  inner join (
    select distinct(hryid) hryid, duration from (
      select f03 hryid,
             rank() over(partition by f03 order by day_borrow_duration desc) rn,
             b.duration || b.duration_name duration
      from s_s62_t6250 a left join dim_prod_p2p_list b on a.f02 = b.bid
      where f07 = 'F'
    )where rn = 1
  ) d on b.f01 = d.hryid
  order by d.hryid;


-- 累积投资金额
  select d.hryid hryid,d.amt from (
    select user_id kjtid from bi_log
    where 
    channel = 'JRTT' 
    and event_type = 'register' and event_status = 'success'
  ) a
  left join s_s61_t6110 b on a.kjtid = b.kjtid
  left join (
      select * from s_s61_t6141 where f04 = 'TG'
  ) c on b.f01 = c.f01
  inner join (
    select * from (
      select f03 hryid,
             sum(f04) amt
      from s_s62_t6250 a left join dim_prod_p2p_list b on a.f02 = b.bid
      where f07 = 'F'
      group by f03
    )
  ) d on b.f01 = d.hryid
  order by d.hryid;