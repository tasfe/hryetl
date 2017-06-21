insert into K_CHANNEL.DIM_FUND_CHANNEL_EXT_D
select
s0.*
,sysdate dw_create_time
,sysdate dw_modified_time
from cmf.tm_fund_channel_ext@kjtdb s0
;
commit;

select
*
from K_CHANNEL.DIM_FUND_CHANNEL_EXT_D
;