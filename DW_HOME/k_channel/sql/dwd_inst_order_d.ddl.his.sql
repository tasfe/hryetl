INSERT INTO K_CHANNEL.DWD_INST_ORDER_D nologging
SELECT 
  s0.*
  ,sysdate DW_CREATE_TIME
  ,sysdate DW_MODIFIED_TIME
FROM K_CHANNEL_ODS.INST_ORDER_INC s0
--where s0.gmt_create >= to_date('20170101','yyyymmdd') and s0.gmt_create<to_date('20170616','yyyymmdd')
--where s0.gmt_create<to_date('2017101','yyyymmdd') and s0.gmt_create>=to_date('20160101','yyyymmdd')
--where s0.gmt_create<to_date('20160101','yyyymmdd') and s0.gmt_create>=to_date('20150101','yyyymmdd')
where s0.gmt_create<to_date('20150101','yyyymmdd')
;
commit;