-- Android scene com.haier.hairy.ui.home.IndexActivity    
-- iOS scene HHomeScene
select scene,count(1) from bi_data_event where key = 'home_007' group by scene

-- pv all 477255   iOS 235655  Android 241600
select scene,count(1) from bi_data_pv where scene in ('HHomeScene','com.haier.hairy.ui.home.IndexActivity')
and logtime between to_date('20161101','yyyymmdd') and to_date('20161114','yyyymmdd')
group by scene

-- uv all 39428  iOS 13652   Android 25776
select a.scene,count(1),count(distinct b.dievice_id) from bi_data_pv a left join bi_data_com b on a.com_id = b.id 
  where a.scene in ('HHomeScene','com.haier.hairy.ui.home.IndexActivity')
  and logtime between to_date('20161101','yyyymmdd') and to_date('20161114','yyyymmdd')
  group by a.scene
-- uv all
select count(distinct b.dievice_id) from bi_data_pv a left join bi_data_com b on a.com_id = b.id 
  where a.scene in ('HHomeScene','com.haier.hairy.ui.home.IndexActivity')
  and logtime between to_date('20161101','yyyymmdd') and to_date('20161114','yyyymmdd')
  
  
  

