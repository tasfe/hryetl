insert into K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D

select
s0.*
,sysdate dw_create_time
,sysdate dw_modified_time
from cmf.tr_fc_target_inst_relation@kjtdb


commit;

select 
*
from K_CHANNEL.DIM_FC_TARGET_INST_RELATION_D
;