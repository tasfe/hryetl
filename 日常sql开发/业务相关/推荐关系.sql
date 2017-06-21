
select count(distinct(PROMOTER_ID)) from S_PROMO_PROMOTION_RELATION where IS_VALID = 1
and promoted_id not in (
  select f03 from S_S62_T6250 a inner join S_PROMO_PROMOTION_RELATION b on a.f03 = b.PROMOTED_ID
  where f07 = 'F' AND F08 = 'S' 
  and round(to_number(b.action_time-a.f06)) < 90
)



-- 验证   投资时间比推广时间还早,有问题
select count(distinct(PROMOTER_ID)) from S_PROMO_PROMOTION_RELATION where IS_VALID = 1
and promoted_id not in (
  select b.PROMOTED_ID, round(to_number(a.f06 - b.action_time)),to_char(a.f06,'yyyymmdd') 投资时间,to_char(b.action_time,'yyyymmdd') 推广时间
  from S_S62_T6250 a inner join S_PROMO_PROMOTION_RELATION b on a.f03 = b.PROMOTED_ID
  where f07 = 'F' AND F08 = 'S' 
  and round(to_number(a.f06 - b.action_time)) < 0
)





