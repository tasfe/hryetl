create table k_channel.dim_bank_fund_channel_d
as 
select 
tt.FUND_CHANNEL_CODE
,tt.NAME fund_channel_name
,tt.DESCRIPTION fund_channel_des
,tt.INST_CODE fund_channel_inst_code
,tt.BIZ_TYPE
,tt.PAY_MODE  fund_channel_pay_mode
,tt.SIGNED_CROP
,so.TARGET_INST_CODE fund_channel_target_inst_code
,(case when tt.inst_code=so.TARGET_INST_CODE then '直连' when tt.inst_code in('SDB','SZPAB') AND SO.TARGET_INST_CODE='SDB/SZPAB' THEN '直连'
ELSE '间连' END) connecttype 
,(case when tt.PAY_MODE='ONLINE_BANK' and tt.name like '%B2B%'  then 'B2B'
  when tt.PAY_MODE='ONLINE_BANK' then 'B2C'
  else '?'
  end) channel_B2BorB2C_type
,decode(tx.fund_channel_code,NULL,'业务交易','内部调拨') is_bfj
,sysdate dw_create_time
,sysdate dw_modified_time
from K_CHANNEL.DWD_BANK_FUND_CHANNEL_D tt 
left join (select RRR.FUND_CHANNEL_CODE,listagg(rrr.TARGET_INST_CODE,'/') within group (order by  RRR.FUND_CHANNEL_CODE) as TARGET_INST_CODE from K_CHANNEL.DWD_FC_TARGET_INST_RELATION_D rrr group by RRR.FUND_CHANNEL_CODE) so 
on tt.fund_channel_code=so.FUND_CHANNEL_CODE
left join (
SELECT
*
from k_channel.dwd_bank_fund_channel_ext_d tx
WHERE tx.attr_key='businessType' and tx.attr_value='BFJ' and tx.match_type='in' and tx.need_match='Y'
ORDER BY tx.FUND_CHANNEL_CODE
) tx
on tt.fund_channel_code=tx.fund_channel_code
ORDER BY tt.FUND_CHANNEL_CODE
;