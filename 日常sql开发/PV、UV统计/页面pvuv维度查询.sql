

select scene,to_char(logtime,'yyyymmdd'),count(1) pv,count(distinct(DIEVICE_ID)) uv from (
select case when instr(scene,'HHomeScene') > 0 then 'HHomeScene'
       when instr(scene,'com.haier.hairy.ui.home.IndexActivity') > 0 then 'com.haier.hairy.ui.home.IndexActivity'
       when instr(scene,'HProductDetailScene') > 0 then 'HProductDetailScene'
       when instr(scene,'com.haier.hairy.ui.test.MainActivity') > 0 then 'com.haier.hairy.ui.test.MainActivity'
       when instr(scene,'HInvestmentScene') > 0 then 'HInvestmentScene'
       when instr(scene,'com.haier.hairy.ui.financial.FinancialGoldActivity') > 0 then 'com.haier.hairy.ui.financial.FinancialGoldActivity'
       end as scene,
       a.logtime,b.dievice_id
from bidata.bi_data_pv a left join bidata.bi_data_com b on a.com_id = b.id 
) where scene in ('HHomeScene','com.haier.hairy.ui.home.IndexActivity','HProductDetailScene','com.haier.hairy.ui.test.MainActivity','HInvestmentScene','com.haier.hairy.ui.financial.FinancialGoldActivity')
and to_char(logtime,'yyyymmdd') between 20161201 and 20170209
group by scene,to_char(logtime,'yyyymmdd')
order by scene,to_char(logtime,'yyyymmdd');