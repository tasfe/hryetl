-- pv uv
select to_char(a.logtime,'yyyymmdd') 时间,count(distinct(b.dievice_id)) UV,count(1) PV from bi_data_event a left join bi_data_com b on a.com_id = b.id
where key = 'purchase_015' and a.logtime between to_date('20161114','yyyymmdd') and to_date('20161130','yyyymmdd') 
group by to_char(a.logtime,'yyyymmdd') order by to_char(a.logtime,'yyyymmdd')

-- 验证
select * from bi_data_event where key = 'purchase_015' and to_char(logtime,'yyyymmdd') = 20161115 order by com_id asc

