-- 概览
select rptdt,decode(state,'SB','交易失败','CG','交易成功','DQR','待确认','找BI') state, counts from (
select to_char(a.f05,'yyyymmdd') rptdt,
       a.f03 state,
       count(1) counts from S_S65_T6501 a inner join S_S65_T6504 b on a.f01 = b.f01 
where to_char(a.f05,'yyyymm') = 201612
group by a.f03,to_char(a.f05,'yyyymmdd')
order by to_char(a.f05,'yyyymmdd')
)

-- 详情


--select distinct(状态) from (
select to_char(a.f05,'yyyymmdd') 时间,
       a.f01 订单ID,
       c.f02 账号,
       c.f04 手机号,
       d.f02 姓名,
       to_char(a.f05,'yyyymmdd') 交易时间,
       b.f04 交易金额,
       decode(a.f03,'SB','交易失败','CG','交易成功','DQR','待确认','找BI') 状态,
       a.err_msg 失败信息, 
       e.f03 标的名称
  from S_S65_T6501 a inner join S_S65_T6504 b on a.f01 = b.f01
  left join s_s61_t6110 c on a.f08 = c.f01
  left join S_S61_T6141 d on a.f08 = d.f01
  left join S_S62_T6230 e on b.f03 = e.f01
 where to_char(a.f05,'yyyymm') = 201612
   and a.f03 != 'CG'
   and a.err_msg is not null
 ORDER BY to_char(a.f05,'yyyymmdd')
--)

-- 12月份交易详情,各个状态占比

select rownum,
	   to_char(a.f05,'yyyymmdd') 时间,
       a.f01 订单ID,
       c.f02 账号,
       c.f04 手机号,
       substr(d.f02,1,1)||'**' 姓名,
       to_char(a.f05,'yyyymmdd') 交易时间,
       b.f04 交易金额,
       decode(a.f03,'SB','交易失败','CG','交易成功','DQR','待确认','找BI') 状态,
       a.err_msg 失败信息, 
       e.f03 标的名称, 
       i.sb/i.tot * 100 失败占比,
       i.cg/i.tot * 100 成功占比,
       i.dqr/i.tot * 100 待确认占比
  from BIDATA.S_S65_T6501 a inner join BIDATA.S_S65_T6504 b on a.f01 = b.f01
  left join BIDATA.s_s61_t6110 c on a.f08 = c.f01
  left join BIDATA.S_S61_T6141 d on a.f08 = d.f01
  left join BIDATA.S_S62_T6230 e on b.f03 = e.f01
  left join (select times,cg,sb,dqr,(cg+sb+dqr) tot from (
                select * from (
                select to_char(a.f05,'yyyymmdd') times, a.f03 status
                from BIDATA.S_S65_T6501 a inner join BIDATA.S_S65_T6504 b on a.f01 = b.f01 
                where to_char(a.f05,'yyyymm') = 201612
                ) pivot ( -- 行转列
                  count(status)
                  for status
                  in ('CG' cg,'SB' sb,'DQR' dqr)
                )
                ORDER BY times
                )
            ) i on to_char(a.f05,'yyyymmdd') = i.times
 where to_char(a.f05,'yyyymm') = 201612
 ORDER BY to_char(a.f05,'yyyymmdd')



