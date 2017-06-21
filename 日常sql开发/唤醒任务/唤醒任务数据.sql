SELECT rownum id,
  c.f02 login_id,
  amt,
  rptdt
FROM
  (SELECT a.user_id,
    REGEXP_SUBSTR(a.promotion_activity_rule_id ,'[^,]+',1,l) AS rolecode,
    payment /100 amt,
    TO_CHAR(created_time,'yyyymmdd') rptdt
  FROM s_promo_user_all_action_sync a,
    (SELECT LEVEL l FROM DUAL CONNECT BY LEVEL<=100
    ) b
  WHERE l                          <=LENGTH(a.promotion_activity_rule_id) - LENGTH(REPLACE(promotion_activity_rule_id,','))+1
  AND a.promotion_activity_rule_id IS NOT NULL
    --and to_char(created_time,'yyyymmdd') = '${start_date}'
  ) a
INNER JOIN
  (SELECT a.id id
  FROM s_promo_activate_user_rule a
  LEFT JOIN s_promo_promotion_activity b
  ON a.promotion_activity_id = b.id
  WHERE b.activity_type      = 5
  AND a.status               = 1
  ) b ON a.rolecode          = b.id
LEFT JOIN s_s61_t6110 c
ON a.user_id = c.f01 