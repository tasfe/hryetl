
--按天计算平均访问时间
select to_char(logtime,'yyyymmdd')日期,network 网络状态,key,round(sum(value),2) as 总时间ms,count(key) 访问量, round(sum(value)/count(key),2) 时间ms from bi_data_event
where subkey = 'req' 
and  regexp_like(value,'^[+-]?\d{0,}\.?\d{0,}$') -- 数字的正则
and logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')
group by network,key,to_char(logtime,'yyyymmdd') order by to_char(logtime,'yyyymmdd')

-- 按网络状态分组
select network 网络状态,round(sum(value),2) as 总时间ms,count(key) 访问量, round(sum(value)/count(key),2) 时间ms from bi_data_event
where subkey = 'req' 
and  regexp_like(value,'^[+-]?\d{0,}\.?\d{0,}$')
and logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')
group by network

-- 按网络类型分组
select key,round(sum(value),2) as 总时间ms,count(key) 访问量, round(sum(value)/count(key),2) 时间ms from bi_data_event
where subkey = 'req' 
and  regexp_like(value,'^[+-]?\d{0,}\.?\d{0,}$')
and logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')
group by key order by 时间ms

-- 查看有问题的记录
select * from bi_data_event
where subkey = 'req' 
and asciistr(value) like '%\%' 
and logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')


-- 网络状态为空的有Android 12414行 为'-'的有5911个,版本2.0.5,6,7,8
select b.app_ver,a.network,sys_name,count(1) from bi_data_event a left join bi_data_com b on a.com_id = b.id 
where a.subkey = 'req' 
and  regexp_like(a.value,'^[+-]?\d{0,}\.?\d{0,}$') -- 数字的正则
and a.logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')
and (a.network = '-' or a.network is null)
group by b.sys_name,b.app_ver,a.network

-- key为 '-' 有iOS 13行  2.1.0.1
select a.key,b.app_ver,count(1) from bi_data_event a left join bi_data_com b on a.com_id = b.id 
where a.subkey = 'req' 
and  regexp_like(a.value,'^[+-]?\d{0,}\.?\d{0,}$') -- 数字的正则
and a.logtime between to_date('20161101','yyyymmdd') and to_date('20161201','yyyymmdd')
and a.key = '-'
group by a.key,b.app_ver


