select count(1) from S_PROMO_PROMOTION_RELATION where promoter_source = 2 and promotion_source = 1



select * from dim_field_metadata


select * from bi_login_h5_app

select count(1) from bi_login_h5_app

select * from BI_PROD_END_DAY

select * from ODS_PROMO_PROMOTION_RELATION a inner join ODS_PROMO_PROMOTION_URI  
 
select * from ODS_PROMO_PROMOTION_URI
 
select * from S_SHORT_ADVERT_DEVICE



select * from bi_page_views@uatdb

select * from s_s10_message_marketing

select * from bi_tg_user

select * from ODS_PROMO_PROMOTION_RELATION a inner join ODS_PROMO_PROMOTION_URI b on a.promoter_id=b.user_id
and  a.PROMOTER_SOURCE=b.USER_SOURCE  ---推广者来源
and a.PLATFORM_ID=b.PLATFORM_ID  ---推广平台
and a.PROMOTION_SOURCE=b.PROMOTION_SOURCE


--商品
select f03,count(1) from S_S62_T6230 group by f03


select * from ODS_PROD_PID_TYPE

select * from S_S62_T6230 

select a.f03,a.f04,b.f02,a.f05,a.f06,a.f08 from S_S62_T6230 a left join S_S62_T6211 b on a.f04 = b.f01

select * from BI_PROD_MODEL

select pname,count(1) from BI_PROD_MODEL group by pname having count(1) > 1

select count(1) from ods_promo_promotion_relation

select count(1) from ods_promo_promotion_uri
select * from ods_promo_promotion_uri

select a.f03 借款标题,a.f04 标的类型,b.bid_type_name 标的名称,a.f05 借款金额,a.f06 年化利率,a.f08 筹款期限(天), a.f09 借款周期,a.f10,a.f11,a.f12,a.f13,a.f14,a.f15,a.f16,a.f17,
a.f18,a.f19,a.f20,a.f21,a.f22,a.f23,a.f24,a.f25,a.f26,a.f27,a.f30,a.f31,a.f32,a.f33,a.f34,a.f35,a.group_id,a.f37,a.f38,a.f39,a.f40,a.f41,a.f42,a.f43,a.f44,a.f45,a.f46,a.f47,
a.f48,a.f49,a.f50,a.f51,a.fresherbase,a.fresherplus,a.f52,a.f53,a.use_lcj,a.ldzred,a.jkrgd,a.zr_company,a.zr_kjt_id,a.show_status,a.yzqr,a.yzwr
from S_S62_T6230 a left join ods_prod_pid_type b on a.f04 = b.bid_type_id

select * from S_S62_T6230 where yzwrht is not null


SELECT a.f01 pid,
  a.f03 bid_name,
  a.f04 bid_type_Id,
  b.bid_type_name,
  b.parent_bid_type_id,
  b.parent_bid_type_name,
  a.f05 product_amt,
  a.f06 year_profit,
  a.f08 raise_limit,
  decode(a.f09,0,0,a.f09) AS monty_borrow_duration,
  decode(a.f09,0,c.f22,0) AS day_borrow_duration ,
  a.f10 HK_TYPE,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f10' AND field_key = a.f10 AND table_name = 'S_S62_T6230'),'找BI') AS HK_TYPE_NAME,
  a.f11 isGuarantee,
  a.f12 guarantee_plan,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f12' AND field_key = a.f12 AND table_name = 'S_S62_T6230' ),'找BI') AS guarantee_plan_name,
  a.f13 ismortgage,
  a.f14 isseeing,
  a.f15 isautoFK,
  a.f16 isallowfail,
  a.f17 interest_type,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f17' AND field_key = a.f17 AND table_name   = 'S_S62_T6230'),'找BI') AS interest_type_name,
  a.f18 interest_time,
  a.f19 interest_days,
  a.f20 status,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f20' AND field_key    = a.f20 AND table_name   = 'S_S62_T6230'),'找BI') AS status_name,
  a.f21 pic_code,
  a.f22 issue_time,
  a.f23 credit_level,
  a.f24 req_time,
  a.f25 bidno,
  a.f26 interest_amt,
  a.f27 isoffline_creditor,
  a.f30 offcontractno,
  a.f31 graranteeno,
  a.f32 creditor_debt_contract,
  a.f33 creditor_debt_contract_no,
  a.f34 creditor_debt_bill,
  a.f35 creditor_a_contract,
  a.f36 contract_bill,
  a.group_id,
  a.f37 down_invest,
  a.f38 up_invest,
  a.f39 increase,
  a.f40 bill_org,
  a.f41 bill_no,
  a.f42 bill_amt,
  a.f43 zdfk,
  a.f44 single_limit_invest,
  a.f45 company_name,
  a.f46 debt_company_name,
  a.f47 contract_time,
  a.f48 contract_name,
  a.f49 offline_amt,
  a.f50 off_begin_time,
  a.f51 off_end_time,
  a.fresherbase,
  a.fresherplus,
  a.f52 dispush,
  a.f53 pro_duration,
  a.use_lcj,
  a.ldzred,
  a.jkrgd,
  a.zr_company,
  a.zr_kjt_id,
  a.show_status,
  a.jjfe,
  a.ptjz,
  a.zxjz,
  a.dqjz,
  a.qcjz,
  a.yzqr,
  a.yzwr
FROM S_S62_T6230 a
LEFT JOIN ods_prod_pid_type b
ON a.f04 = b.bid_type_id
LEFT JOIN S_S62_T6231 c
ON a.f01 = c.f01
ORDER BY req_time DESC
--where (ISMORTGAGE not in ('S','F') OR ISSEEING NOT IN ('S','F') OR ISAUTOFK NOT IN ('S','F') OR ISALLOWFAIL NOT IN ('S','F') OR USE_LCJ NOT IN ('S','F'))
--isguarantee not in ('S','F')
--day_borrow_duration != 0 and month_borrow_duration != 0

--(HK_TYPE_NAME = '找BI' or guarantee_plan_name = '找BI' or interest_type_name = '找BI' or status_name = '找BI')



kjt_id
f08 -- 筹款期限
--f10付息方式  f09还款方式  f17付息方式 f12担保方案  f20状态    要配置
-- 投资期限

select T1.member_id 会员ID,T1.default_login_name 登录名,T1.true_name 实名, T2.verify_id from  MEMBER.TR_PERSONAL_MEMBER@KJTDB T1 left join member.TR_VERIFY_REF@kjtdb T2 on T1.member_id=T2.member_id where to_char(t1.create_time,'yyyy-MM-dd')='2016-11-01';























