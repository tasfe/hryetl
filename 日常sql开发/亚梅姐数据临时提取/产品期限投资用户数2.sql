select * from (
select days,
  count(distinct(usr_id)) user_tot --用户数
  --sum(f05) amt_tot -- 金额
  from (
  select to_char(a.f06,'yyyymmdd') f06,f03 usr_id,f05,
         decode(greatest(b.days,30),30,'1-30天',decode(greatest(b.days,90),90,'30-90天',
         decode(greatest(b.days,180),180,'90-180天',decode(greatest(b.days,365),365,'180-365天','大于365天')))) days,
         days dayss
         --decode(day_borrow_duration,0,monty_borrow_duration * 30, day_borrow_duration) days
  from s_s62_t6250 a inner join
    (SELECT a.f01 pid,
    --decode(a.f09,0,0,a.f09) AS monty_borrow_duration,
    decode(a.f09,0,c.f22,a.f09*30) AS days
    FROM S_S62_T6230 a
    LEFT JOIN S_S62_T6231 c
    ON a.f01 = c.f01
    ) b 
  on a.f02 = b.pid
  --and f06 between to_date('20161222','yyyymmdd') and to_date('20161227','yyyymmdd')
)
group by days

)