  select
  b1.f01,
  b1.f03,
  b1.f20,
  to_char(b2.f13,'yyyy-MM-dd') jq_date
  from s_s62_t6230 b1
  left join s_s62_t6231 b2
  on b1.f01=b2.f01
  
  
  
  select 
TT.*,
t4.f03
from (
SELECT 
T.*,
t3.f02 bid,
t3.f05 债券金额,
to_char(t3.f06,'yyyy-MM-dd hh24:mm:ss')
FROM
  (SELECT t0.f01 hryid,
    t0.f02 login_name,
    t1.avl_share/100 天天聚可用余额
  FROM s_s61_t6110 t0
  LEFT JOIN funduser.t_fund_share_info@fdb t1
  ON t0.kjtid =kjt_cust_id
  WHERE t0.f02='18997086635'
  ) T
  left join
  s_s62_T6250 t3
  on T.hryid=t3.f03
  ) TT
  left join s_s62_t6230 t4
  on TT.bid=t4.f01
  
  select * from funduser.t_fund_share_info@fdb t
  