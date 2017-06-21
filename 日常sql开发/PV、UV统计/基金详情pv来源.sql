select distinct scene, count(1) from bi_data_pv where scene like 'HHome%' group by scene

select distinct scene , count(1) from bi_data_pv where scene like '%Fund%' group by prescene

select count(1) from bi_data_pv where scene = 'HFundDetailScene' and prescene = 'HHomeScene' --8484
  and sessionid in (select distinct sessionid from bi_data_pv where scene = 'HHomeScene')
--8376


select count(1) from bi_data_pv where scene = 'HFundDetailScene' -- 12952
  and prescene = 'HFundListScene' -- 2699
  and sessionid in (select distinct sessionid from bi_data_pv where scene = 'HFundListScene')
-- 2630

select count(1) from bi_data_pv a
 where a.scene = '%基金%' and a.PRESCENE = 'HFundDetailScene'
 and logtime between to_date('20160928','yyyymmdd') and to_date('20161117','yyyymmdd')
 group by a.scene
 
 select count(1) from bi_data_pv a
 where a.scene = 'HFundDetailScene' 
 and logtime between to_date('20160928','yyyymmdd') and to_date('20161117','yyyymmdd')
 group by a.scene 