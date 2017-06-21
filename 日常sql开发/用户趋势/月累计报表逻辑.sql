
--月累计
select '汇总' 来源类型,注册用户,实名用户,交易用户,
       TO_CHAR( 实名用户 / 注册用户 * 100,'990.99')||'%' 认证率,
       TO_CHAR( 交易用户 / 注册用户 * 100,'990.99')||'%' 交易率
 from (select flag, all_num from BI_LJ_CUST_M where rptdt = ?) pivot (sum(all_num) for flag 
 in ('SMRZ' 实名用户,'REG' 注册用户,'JYYH' 交易用户))
 union all
select '推荐' 来源类型,注册用户,实名用户,交易用户,
       TO_CHAR( 实名用户 / 注册用户 * 100,'990.99')||'%' 认证率,
       TO_CHAR( 交易用户 / 注册用户 * 100,'990.99')||'%' 交易率 
 from (select flag, promo from BI_LJ_CUST_M where rptdt = ?) pivot (sum(promo) for flag 
 in ('SMRZ' 实名用户,'REG' 注册用户,'JYYH' 交易用户))
 union all
select '第三方' 来源类型,注册用户,实名用户,交易用户,
       TO_CHAR( 实名用户 / 注册用户 * 100,'990.99')||'%' 认证率,
       TO_CHAR( 交易用户 / 注册用户 * 100,'990.99')||'%' 交易率 
 from (select flag, dsf from BI_LJ_CUST_M where rptdt = ?) pivot (sum(dsf) for flag 
 in ('SMRZ' 实名用户,'REG' 注册用户,'JYYH' 交易用户))
 union all
select '自然注册' 来源类型,注册用户,实名用户,交易用户,
       TO_CHAR( 实名用户 / 注册用户 * 100,'990.99')||'%' 认证率,
       TO_CHAR( 交易用户 / 注册用户 * 100,'990.99')||'%' 交易率 
 from (select flag, ZRZC from BI_LJ_CUST_M where rptdt = ?) pivot (sum(ZRZC) for flag 
 in ('SMRZ' 实名用户,'REG' 注册用户,'JYYH' 交易用户)) 