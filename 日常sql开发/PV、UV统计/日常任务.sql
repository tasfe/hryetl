select * from bi_data_sys a left join bi_data_com b on a.com_id = b.id
where to_char(a.create_time,'yyyymmdd') = 20161213 and a.subkey = '2.0.4'

-- task_008-task_012的 每日 Pv、uv 12.2-12.8
select to_char(a.logtime,'yyyymmdd') dates,a.key KEY,count(1) PV,count(distinct(b.dievice_id)) UV
from bi_data_event a left join bi_data_com b on a.com_id = b.id
where key in ('task_008','task_009','task_010','task_011','task_012' )
and logtime between to_date('20161130','yyyymmdd') and to_date('20161214','yyyymmdd')
group by to_char(a.logtime,'yyyymmdd'), a.key ORDER BY a.key


  -- task_008-task_012的 总的 Pv、uv 12.2-12.8
select a.key KEY,count(1) PV,count(distinct(b.dievice_id)) UV
from bi_data_event a left join bi_data_com b on a.com_id = b.id
where key in ('task_008','task_009','task_010','task_011','task_012' )
and logtime between to_date('20161202','yyyymmdd') and to_date('20161208','yyyymmdd')
group by a.key 

-- 每日 pv uv
select to_char(a.logtime,'yyyymmdd'), count(1) PV,count(distinct(b.dievice_id)) UV
from bi_data_event a left join bi_data_com b on a.com_id = b.id
where a.key = 'purchase_015'
and logtime between to_date('20161130','yyyymmdd') and to_date('20161213','yyyymmdd')
group by to_char(a.logtime,'yyyymmdd') order by to_char(a.logtime,'yyyymmdd')

-- 总pv uv
select count(1) PV,count(distinct(b.dievice_id)) UV
from bi_data_event a left join bi_data_com b on a.com_id = b.id
where a.key = 'purchase_015'
and logtime between to_date('20161130','yyyymmdd') and to_date('20161213','yyyymmdd')


--问题sql
--select * from s_s61_t6110 where f01 = '3927'

--select * from s_s62_t6250 where f03 = '3927'

--select * from S_PROMO_PROMOTION_RELATION where PROMOTED_ID = '3927'





