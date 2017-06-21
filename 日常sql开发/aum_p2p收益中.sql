select
*
from BIDATA.BI_AUM_DT t0
where t0.RPTDT > 20170213 and t0.FLAG='p2p收益中'
order by t0.RPTDT
;