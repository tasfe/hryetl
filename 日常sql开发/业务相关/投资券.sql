SELECT a.id,
  e.transaction_type,
  nvl((SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_COUPON_FUND_TRANSFER'
  AND field_name   = 'transaction_type'
  AND field_key    = b.coupon_type
  ), '找BI') as transaction_type_name,
  e.transaction_id order_id,
  e.orig_trade_voucher_no,
  e.voucher_no,
  e.access_channel,
  e.kjt_response,
  e.kjt_payment_voucher_no,
  e.kjt_trade_voucher_no,
  a.promotion_activity_id,
  c.activity_type,
  DECODE(c.activity_type,NULL,NULL, NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_PROMOTION_ACTIVITY'
  AND field_name   = 'activity_type'
  AND field_key    = c.activity_type
  ),'找BI')) AS activity_type_name,
  c.promotion_activity_name,
  c.start_time activity_start_time,
  c.end_time activity_end_time,
  c.creator_id activity_creator_id,
  c.editor_id activity_editor_id,
  a.promotion_activity_rule_id,
  d.promoted_action_type,
  DECODE(d.promoted_action_type,NULL,NULL, NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_PROMOTION_ACTIVITY_RUL'
  AND field_name   = 'promoted_action_type'
  AND field_key    = d.promoted_action_type
  ),'找BI')) AS promoted_action_type_name,
  d.rewards_type,
  DECODE(d.rewards_type,NULL,NULL, NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_PROMOTION_ACTIVITY_RUL'
  AND field_name   = 'rewards_type'
  AND field_key    = d.rewards_type
  ),'找BI')) AS rewards_type_name,
  d.promoted_location,
  d.payment_type,
  DECODE(d.payment_type,NULL,NULL, NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_PROMOTION_ACTIVITY_RUL'
  AND field_name   = 'payment_type'
  AND field_key    = d.payment_type
  ),'找BI')) AS payment_type_name,
  a.COUPON_CATEGORY_ID,
  b.coupon_name,
  b.coupon_type,
  NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_COUPON_CATEGORY'
  AND field_name   = 'coupon_type'
  AND field_key    = b.coupon_type
  ), '找BI') AS coupon_type_name,
  b.min_payment,
  b.min_product_maturity,
  b.platform,
  NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_COUPON_CATEGORY'
  AND field_name   = 'platform'
  AND field_key    = b.platform
  ),'找BI') AS platform_name,
  b.winning_rate,
  a.coupon_no,
  a.coupon_value,
  a.state,
  NVL(
  (SELECT field_value
  FROM dim_field_metadata
  WHERE table_name = 'S_PROMO_COUPON'
  AND field_name   = 'state'
  AND field_key    = a.state
  ),'找BI') AS state_name,
  a.user_id hry_id,
  a.comments,
  a.usage_comments,
  a.usage_time,
  a.batch_no,
  a.activate_time,
  a.coupon_group_item_id,
  b.effective_date,
  b.expired_date
FROM s_promo_coupon a
LEFT JOIN s_promo_coupon_category b
ON a.coupon_category_id = b.id
LEFT JOIN S_PROMO_PROMOTION_ACTIVITY c
ON a.promotion_activity_id = c.id
LEFT JOIN S_PROMO_PROMOTION_ACTIVITY_RUL d
ON a.PROMOTION_ACTIVITY_RULE_ID = d.id
LEFT JOIN S_PROMO_COUPON_FUND_TRANSFER e
ON a.id = e.COUPON_ID