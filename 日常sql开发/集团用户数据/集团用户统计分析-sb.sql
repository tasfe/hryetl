------
select
count(DISTINCT t0.kjtid) 投资用户数
from BIDATA.DIM_USER_HRY_USERS t0
inner join BIDATA.BI_USER_EXCHANGE t1
on t0.KJTID=t1.KJTID
where t0.EMP_TYPE='内部员工' 
and t1.RESYSTEMID !='KJT' 
AND t1.RPTDT<=20170331 
;

------
select
count(*) 认证用户数
from bidata.DIM_USER_HRY_USERS t0
where t0.EMP_TYPE='内部员工' 
and t0.authent_status='TG' 
and t0.reg_time<to_date('20170401','yyyymmdd')
;

------
select 
count(distinct a.HRYID) P2P用户数
from bidata.dim_user_hry_users a
where a.emp_type='内部员工' and a.reg_time<to_date('20170301','yyyymmdd') and a.reg_time>to_date('20170122','yyyymmdd') and a.authent_status='TG'
;

------
select 
sum(b.F05) P2P累计金额
from bidata.dim_user_hry_users a 
INNER join bidata.s_s62_t6250 b 
on a.hryid=b.F03 
where emp_type='内部员工' 
and b.f07='F' 
AND B.F06 < TO_DATE('20170401','yyyymmdd') 
--AND B.F06 > TO_DATE('20170122','yyyymmdd')
;

select 
sum(b.trans_amt)/100 基金累计金额
from bidata.dim_user_hry_users a 
inner join funduser.t_fund_share_order@fdb b
on a.kjtid=b.kjt_cust_id
where a.emp_type='内部员工' 
and b.create_time < TO_DATE('20170401','yyyymmdd') 
--and b.create_time >= TO_DATE('20170123','yyyymmdd') 
and b.trans_type='I' and b.status=5
;

select
count(*)
from (
select
t1.HRYID 注册用户,
to_char(t1.REG_TIME ,'yyyymmdd hh24:mm:ss') 注册时间,
decode(t1.authent_status,'TG','Y','N') 实名认证
from bidata.dim_user_hry_users t1
where t1.EMP_TYPE='内部员工' 
and  t1.reg_time<TO_DATE('20170401','yyyymmdd')
) s0
;


----
WITH TMP_FUND_AVL_AMT AS (select
t1.F01 hryid
,t0.AVL_SHARE/100 avl_amt
from BIFUND.S_FUD_T_FUND_SHARE_INFO t0
left join bidata.s_s61_t6110 t1
on t0.KJT_CUST_ID=t1.KJTID)

select
t1.HRYID 海融易id
,t3.order_count p2p投资次数
,t3.amt p2p投资金额
,t4.invest_times 天天聚投资次数
,t4.invest_amt 天天聚投资金额
,t3.order_count+t4.invest_times 总投资次数
,t3.amt+t4.invest_amt 总投资金额
,t5.avl_amt 天天聚可用余额
from bidata.dim_user_hry_users t1
inner join (select distinct kjtid from BIDATA.BI_USER_EXCHANGE where RESYSTEMID != 'KJT' ) t2
on t1.KJTID=t2.KJTID
left join (
select
s.f03 hryid,
count(s.f01) order_count,
sum(s.f05) amt
from bidata.s_s62_t6250 s
where s.f06 < to_date('20170401','yyyymmdd')
group by s.f03
) t3
on t1.hryid=t3.hryid
left join  (
select 
b.kjt_cust_id kjtid,
count(1) invest_times,
sum(b.trans_amt)/100 invest_amt 
from funduser.t_fund_share_order@fdb b
where b.create_time < TO_DATE('20170401','yyyymmdd') and b.trans_type='I' and b.status=5
group by b.kjt_cust_id
) t4
on t1.kjtid=t4.kjtid
left join TMP_FUND_AVL_AMT t5
on  t1.hryid=t5.hryid
where t1.EMP_TYPE='内部员工' and t1.reg_time < TO_DATE('20170401','yyyymmdd')
--------

;

加上统计持有资产
---------
WITH TMP_FUND_AVL_AMT AS (select
t1.F01 hryid
,t0.AVL_SHARE/100 avl_amt
from FUND.T_FUND_SHARE_INFO@FDB t0
left join bidata.s_s61_t6110 t1
on t0.KJT_CUST_ID=t1.KJTID)
,TMP_PAY_AVL_AMT AS (
SELECT
T1.F01 HRYID
,T2.BALANCE avl_amt
FROM MEMBER.TR_MEMBER_ACCOUNT@KJTDB T0
INNER JOIN BIDATA.S_S61_T6110 T1
ON T0.MEMBER_ID=T1.KJTID
INNER JOIN DPM.T_DPM_OUTER_ACCOUNT_SUBSET@KJTDB T2
ON T0.ACCOUNT_ID=T2.ACCOUNT_NO
WHERE T2.FUND_TYPE=1 AND T2.BALANCE_TYPE=1
)
,TMP_P2P_AVL_AMT AS (
select
t0.f04 hryid
,sum(t0.f07) avl_amt
from bidata.s_s62_t6252 t0
where t0.f09='WH' or t0.f09='HKZ'
group by t0.f04
)

select
s.海融易id
,count(*)
from (
select
t1.HRYID 海融易id
,NVL(t3.order_count,0) p2p投资次数
,NVL(t3.amt,0) p2p投资金额
,NVL(t4.invest_times,0) 天天聚投资次数
,NVL(t4.invest_amt,0) 天天聚投资金额
,NVL(t3.order_count+t4.invest_times,0) 总投资次数
,NVL(t3.amt+t4.invest_amt,0) 总投资金额
,NVL(t5.avl_amt,0) 天天聚可用余额
,NVL(t6.avl_amt,0) 支付可用余额
,NVL(t7.avl_amt,0) P2P持有资产金额
from bidata.dim_user_hry_users t1
inner join (select distinct kjtid from BIDATA.BI_USER_EXCHANGE where RESYSTEMID != 'KJT' ) t2
on t1.KJTID=t2.KJTID
left join (
select
s.f03 hryid,
count(s.f01) order_count,
sum(s.f05) amt
from bidata.s_s62_t6250 s
where s.f06 < to_date('20170401','yyyymmdd')
group by s.f03
) t3
on t1.hryid=t3.hryid
left join  (
select 
b.kjt_cust_id kjtid,
count(1) invest_times,
sum(b.trans_amt)/100 invest_amt 
from funduser.t_fund_share_order@fdb b
where b.create_time < TO_DATE('20170401','yyyymmdd') and b.trans_type='I' and b.status=5
group by b.kjt_cust_id
) t4
on t1.kjtid=t4.kjtid
left join TMP_FUND_AVL_AMT t5
on  t1.hryid=t5.hryid
left join TMP_PAY_AVL_AMT t6
on  t1.hryid=t6.hryid
left join TMP_P2P_AVL_AMT t7
on  t1.hryid=t7.hryid
where t1.EMP_TYPE='内部员工' and t1.reg_time < TO_DATE('20170401','yyyymmdd')
) s
group by s.海融易id
having count(*)>1
;
