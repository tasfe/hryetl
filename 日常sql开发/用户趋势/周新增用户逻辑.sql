select repyear||'' repyear,repweek||'周' repweek1,repdt,
       sum(case flag when 'REG' then all_num else 0 end) reg_all_num,
       sum(case flag when 'REG' then promo else 0 end) reg_promo,
       sum(case flag when 'REG' then dsf else 0 end) reg_dsf,
       sum(case flag when 'REG' then zrzc else 0 end) reg_zrzc,
       sum(case flag when 'SMRZ' then all_num else 0 end) smrz_all_num,
       sum(case flag when 'SMRZ' then promo else 0 end) smrz_promo,
       sum(case flag when 'SMRZ' then dsf else 0 end) smrz_dsf,
       sum(case flag when 'SMRZ' then zrzc else 0 end) smrz_zrzc,
       sum(case flag when 'JYYH' then all_num else 0 end) jyyh_all_num,
       sum(case flag when 'JYYH' then promo else 0 end) jyyh_promo,
       sum(case flag when 'JYYH' then dsf else 0 end) jyyh_dsf,
       sum(case flag when 'JYYH' then zrzc else 0 end) jyyh_zrzc
  from (select t2.repyear,
       t2.repweek,
       min(repdate) || '-' || max(repdate) repdt,
       sum(all_num) all_num,
       sum(promo) promo,
       sum(dsf) dsf,
       sum(zrzc) zrzc,
       flag
  from BI_NEW_CUST_D t1, (select * from bidim.obj_date
 where repdate >= (select min(repdate) from bidim.obj_date where repyear =? and repweek =?)
   and repdate <= (select max(repdate) from bidim.obj_date where repyear =? and repweek =?)) t2
 where t1.rptdt = t2.repdate
 group by t2.repyear, t2.repweek, t1.flag)
 group by repyear,repweek,repdt order by repyear,repweek
 

