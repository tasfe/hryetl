-- bi_9
select to_char(a.logtime,'yyyymmdd'),a.key,count(distinct(b.dievice_id)) from bi_data_event a left join bi_data_com b
on a.com_id = b.id
where key in ('task_007','task_008','task_009','task_010','task_011','task_012','task_013')
and a.logtime > to_date('20161115','yyyymmdd') and a.logtime < to_date('20161128','yyyymmdd')
group by to_char(a.logtime,'yyyymmdd'), a.key order by a.key


-- 验证
--156 15号 task_007 pv
select count(1) from bi_data_event where key = 'task_007' and to_char(logtime,'yyyymmdd') = 20161115

-- 132 15号 task_007 pv
select count(dievice_id) from bi_data_com where id in (select com_id from bi_data_event where key = 'task_007' and to_char(logtime,'yyyymmdd') = 20161115)


-- pv uv
select --to_char(a.logtime,'yyyymmdd') 时间
a.key KEY,count(1) PV,count(distinct(b.dievice_id)) UV from bidata.bi_data_event a left join bidata.bi_data_com b on a.com_id = b.id
where a.logtime between to_date('20161115','yyyymmdd') and to_date('20161205','yyyymmdd') 
and a.key = 'home_010' --(a.key like 'task_0%' or a.key in ('discovery_001','home_007','home_008'))
group by a.key order by a.key--to_char(a.logtime,'yyyymmdd')

-- 检查
select * from bidata.bi_data_event where key = 'task_013' and to_char(logtime,'yyyymmdd') = 20161126

select distinct(to_char(logtime,'yyyymmdd')) from bidata.bi_data_event where key = 'task_002'
