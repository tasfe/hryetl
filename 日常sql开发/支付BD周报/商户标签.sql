select 
t0.member_id,
t0.member_name,
decode(substr(t0.merchant_property,0,2),'01','海尔生态','02','社会化','03','项目实施','04','待定项目','未归类') 一级标签,
decode(substr(t0.merchant_property,0,4),'0101','集团内','0102','集团外','0201','代理户','0202','直营商户','0203','集团外','0301','测试户','0401','待定项目','未归类') 二级标签,
t1.name 三级标签
from BASIS.TB_MERCHANT_INFO@kjtdb t0
left join BASIS.SG_MERCHANT_PROPERTIES@kjtdb t1
on t0.merchant_property = t1.code
where t0.merchant_property is not null
order by t0.update_time desc
;


select 
*
from BASIS.SG_MERCHANT_PROPERTIES@kjtdb t0
;

select 
distinct(operator)
from BASIS.TB_MERCHANT_INFO@kjtdb t0
;