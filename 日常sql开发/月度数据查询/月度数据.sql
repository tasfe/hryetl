-- 总指标
-- 201612月年快捷通新增注册用户数
select COUNT(*) CNT, '注册用户' toltype FROM MEMBER.TM_MEMBER@KJTDB B WHERE TO_CHAR(B.CREATE_TIME,'yyyymm') = '201612'; 
-- 38821

-- 2016年12月快捷通新增实名用户数
select sum(case when b.verify_level>0 then 1 else 0 end ) CNT,'实名认证用户' toltype FROM MEMBER.TM_MEMBER@kjtdb B WHERE TO_CHAR(B.CREATE_TIME,'yyyymm') = '201612';
-- 24176

-- 2016年12月激活用户数 
select sum(case when b.active_time is not null then 1 else 0 end ) CNT, '激活用户' toltype FROM MEMBER.TM_MEMBER@kjtdb B WHERE TO_CHAR(B.CREATE_TIME,'yyyymm') = '201612';
-- 38655

--2016年12月交易用户数
select count(distinct a.kjtid) CNT, '交易用户(资金变动)' toltype from bi_user_exchange a where a.rptdt between 20161201 and 20170101;
-- 28629

---------------------------------------------------------------------- 
-- p2p 指标

-- 2016年12月p2p新增注册用户数
select count(1) 新增用户数 from S_S61_T6110 where to_char(F09,'yyyymm')='201612';
-- 38689

-- 2016年12月p2p新增实名用户数
select count(1) from S_S61_T6141 where F04 ='TG' and to_char(F10,'yyyymm')='201612';
-- 24598

-- 2016年12月p2p交易用户数
select count(distinct kjtid) from bi_hry_exchange_list where orderstatus='成功' and to_char(FSHTIME,'yyyymm')='201612';
-- 19035

-- 2016年12月p2p交易订单数量 (这里是加上失败的订单?我是这样查的)
select count(1) from bi_hry_exchange_list where orderstatus='成功' and to_char(FSHTIME,'yyyymm')='201612';
-- 51715

-- 2016年12月p2p总交易额
select sum(BUYBALANCE) from bi_hry_exchange_list where to_char(FSHTIME,'yyyymm')='201612';


-- 2016年12月p2p绑卡用户数 
select count(1) from S_S61_T6110 a left join member.TM_MEMBER@kjtdb b on a.kjtid = b.member_id
where b.verify_level > 1;

---------------------------------------------------------------------- 
-- 月活跃-平台贡献
select count(1) from BI_LOG where sys_name like 'IOS%' and to_char(log_time,'yyyymm')='201612';
--6660638
select count(1) from BI_LOG where sys_name like 'Android%' and to_char(log_time,'yyyymm')='201612';
-- 12164711

--剩余各种类型统计的数字
select distinct(sys_name),count(1) from BI_LOG where (sys_name not like 'IOS%' and SYS_NAME not like 'Android%')group by sys_name;

--剩余总量统计
select count(1) from BI_LOG where sys_name  like 'h5%' and to_char(log_time,'yyyymm')='201612';
--428303
---------------------------------------------------------------------- 
--盈米基金
-- select * from fund.t_fund_entity_info_ym@fdb i  where i.open_stat='S';

--盈米基金2016年 12月开户数
SELECT COUNT(1) AS open_num_all FROM FUND.T_FUND_ENTITY_INFO_YM@fdb T WHERE T.Open_Stat = 'S'
AND TO_CHAR(T.OPEN_TIME, 'yyyymm')='201612';
-- select count(1) from fund.t_fund_entity_info_ym@fdb i  where i.open_stat='S' and to_char(create_time,'yyyymmdd')>'20161130';
--487

--盈米基金2016年 12月交易用户数
select count(distinct(kjt_cust_id)) from FUND.T_FUND_SHARE_ORDER_YM@fdb where trans_type = 'I' 
and payment_status = 'S' and to_char(create_time,'yyyymm')='201612';
--174

--盈米基金2016年12月转入流水
select sum(success_amt) from FUND.T_FUND_SHARE_ORDER_YM@fdb where trans_type = 'I' and payment_status = 'S'
and to_char(create_time,'yyyymm')='201612';
-- 104562

--盈米基金2016年12月转出流水
select sum(success_amt) from FUND.T_FUND_SHARE_ORDER_YM@fdb where trans_type = 'O' and payment_status = 'S'
and to_char(create_time,'yyyymm')='201612';
-- 109612.58

--盈米基金截止2016年12月31日的存量资金
SELECT SUM(OT.ASSETS)  assets_all FROM (
    SELECT T1.FUND_CODE,T1.SUM_SHARE,T2.FUND_NAV,T2.FUND_DATE,round(T1.SUM_SHARE * T2.FUND_NAV,2) AS ASSETS
    FROM (
        SELECT T.FUND_CODE,SUM(T.SHARE_AMT) AS SUM_SHARE 
        FROM FUND.T_FUND_SHARE_INFO_YM@fdb T 
        WHERE  T.SHARE_DATE IS NOT NULL
        GROUP BY T.FUND_CODE) T1 
    LEFT JOIN  FUND.T_FUND_NAV_YM@fdb T2
     ON (T1.FUND_CODE = T2.FUND_CODE)
    WHERE T2.FUND_DATE = ( SELECT MAX(T.FUND_DATE) FROM FUND.T_FUND_NAV_YM@fdb T WHERE T.FUND_CODE = T2.FUND_CODE )
) OT;

---------------------------------------------------------------------- 
-- 天天聚表
select * from dpm.t_dpm_outer_account_detail@kjtdb;

--天天聚2016年12月交易用户数
select count(DISTINCT account_no) from dpm.t_dpm_outer_account_detail@kjtdb where to_char(txn_time,'yyyymm') = '201612';
--36116

--天天聚截止2016年12月31日的存量资金
select * from funduser.t_fund_dayend_sum@fdb where to_char(create_time,'yyyymmdd')='20161231';

-- 天天聚2016年12月开户数
select count(KJT_CUST_ID) from fund.T_FUND_ENTITY_INFO@fdb where to_char(OPEN_TIME,'yyyymm')='201612';
--8320

-- 天天聚转入转出数据集合
select trans_type,
decode(trans_type,'I','转入','O','转出','P','收益','C','消费') trans_type_name,
oper_mode,
decode(oper_mode,'04','主动申购','05','余额自动','07','还款自动','01','转出到余额','03','提现','06','消费') oper_mode_name,
sum(trans_amt) 
from fund.t_fund_share_order@fdb
where to_char(create_time,'yyyymm') = 201612
group by trans_type,oper_mode 
order by trans_type
















