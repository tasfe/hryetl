SELECT a.f01 bid,
  a.f03 bid_name, --标名称
  nvl(d.label_id,0) label_id,
  decode(d.label_id,1,'是','否') is_new_user_p,
  a.f04 bid_type_Id, -- 标id
  b.bid_type_name,
  b.parent_bid_type_id,
  b.parent_bid_type_name,
  a.f05 product_amt,
  round(a.f06*100,2) year_profit,
  decode(greatest(a.f06,0.06),0.06,'6%以下',decode(greatest(a.f06,0.08),0.08,'6%-8%',decode(greatest(a.f06,0.1),0.1,'8%-10%','10%以上'))) year_profit_scope,
  a.f08 raise_limit,
  decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22) day_borrow_duration,
  round(decode(c.f22,0,a.f09, c.f22/365*12),1) monty_borrow_duration,
  round(decode(c.f22,0,a.f09/12,c.f22/365),2) year_borrow_duration,
  decode(greatest(decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22),29),29,'小于30',
                             decode(greatest(decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22),90),90,'30-90',
                             decode(greatest(decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22),180),180,'90-180',
                             decode(greatest(decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22),365),365,'180-365','大于365')))) borrow_duration_scope,
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
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f17' AND field_key = a.f17 AND table_name = 'S_S62_T6230'),'找BI') AS interest_type_name,
  a.f19 interest_days,
  a.f20 status,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f20' AND field_key = a.f20 AND table_name = 'S_S62_T6230' and value_mode=2),'找BI') AS status_name_id,
  NVL((SELECT field_value FROM dim_field_metadata WHERE field_name = 'f20' AND field_key = a.f20 AND table_name = 'S_S62_T6230' and value_mode=1),'找BI') AS status_name,
  a.f21 pic_code,
  a.f23 credit_level,
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
  a.f49 offline_amt,
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
  a.yzwr,
  a.f18 interest_time,
  a.f22 issue_time,
  a.f50 off_begin_time,
  a.f51 off_end_time,
  a.f47 contract_time, --基础合同签署时间
  a.f48 contract_name, --基础合同名称
  c.f21 regular_by_day,--是否按天计算
  a.f24 req_time,--申请时间
  c.F10 check_time, --审核时间
  c.F11 full_time, --满标时间
  c.F12 grant_time, --放款时间
  c.F13 settle_time, --结清时间
  c.F14 advance_time, --垫付时间
  c.F15 failure_time,  --流标时间
  c.f12+a.f19 start_time, --起息日期
  c.f12+a.f19+decode(c.f22,0,add_months(c.f12,a.f09) - c.f12,c.f22) end_time --结束日期
FROM S_S62_T6230 a
LEFT JOIN DIM_PROD_PID_TYPE b
ON a.f04 = b.bid_type_id
LEFT JOIN S_S62_T6231 c
ON a.f01 = c.f01
left join (
    select * from s_s62_bid_label where label_id = 1
) d
on a.f01 = d.bid_id
where c.f12 is not null