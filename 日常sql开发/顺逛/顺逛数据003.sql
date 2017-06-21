create table TMP_SHUNGUANG_HIS_AMT_DT
as 
select 
tt0.account_no,
tt0.trade_date,
tt0.max_log_id,
tt1.after_amt
from (
select
t0.account_no,
to_char(t0.create_time,'yyyymmdd') trade_date,
max(t0.ACCOUNT_SUBSET_LOG_ID) max_log_id
from dpm.t_dpm_outer_account_sub_detail@kjtdb t0
where t0.fund_type=1 and t0.balance_type=1 and t0.create_time >= to_date('20170201','yyyymmdd') 
group by t0.account_no,to_char(t0.create_time,'yyyymmdd')
) tt0
left join dpm.t_dpm_outer_account_sub_detail@kjtdb tt1
on tt0.account_no=tt1.account_no and tt0.max_log_id=tt1.ACCOUNT_SUBSET_LOG_ID
order by tt0.account_no desc,tt0.trade_date desc
;


-------------
create table TMP_SHUNGUANG_ANALYSIS
AS
select
ua.LOGIN_NAME,
ua.member_id,
ua.BALANCE,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170308') amt_20170308,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170307') amt_20170307,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170306') amt_20170306,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170305') amt_20170305,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170304') amt_20170304,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170303') amt_20170303,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170302') amt_20170302,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170301') amt_20170301,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170228') amt_20170228,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170227') amt_20170227,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170226') amt_20170226,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170225') amt_20170225,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170224') amt_20170224,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170223') amt_20170223,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170222') amt_20170222,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170221') amt_20170221,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170220') amt_20170220,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170219') amt_20170219,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170218') amt_20170218,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170217') amt_20170217,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170216') amt_20170216,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170215') amt_20170215,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170214') amt_20170214,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170213') amt_20170213,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170212') amt_20170212,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170211') amt_20170211,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170210') amt_20170210,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170209') amt_20170209,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170208') amt_20170208,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170207') amt_20170207,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170206') amt_20170206,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170205') amt_20170205,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170204') amt_20170204,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170203') amt_20170203,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170202') amt_20170202,
(select after_amt from TMP_SHUNGUANG_HIS_AMT_DT where account_no=ua.account_id and trade_date='20170201') amt_20170201
from TMP_SHUNGUANG_B_0309_0044 ua
;
