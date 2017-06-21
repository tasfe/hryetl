select 
t0.BUSINESS,
count(*) business_count
from TMP_BUSINESS_TAG t0
group by t0.BUSINESS
HAVING count(*)>1
;
select 
t0.business login_name,
t1.member_id,
t0.b_name,
t0.member_type,
t0.ecology_type,
t0.group_type,
t0.B_PROJECT
from TMP_BUSINESS_TAG t0
left join member.tm_member_identity@kjtdb t1
on t0.BUSINESS=t1.identity
where t0.business in 
('1037422341@qq.com','cfb49@sina.com','kuaijietong18@sina.com',
'shanghaislang@163.com','zbbsvvs@kjtpay.com.cn','yaodeyou@9utong.com',
'haomenpay@163.com','huili_maoyi@sina.com','kuaijiet@sina.com',
'a9908468@163.com','cclycjmy@163.com','shanghaislang@163.com',
'kuaijietong888@tom.com','hqsma@kjtpay.com.cn','szsykjt123@sina.com',
'3196010@kjtpay.com.cn','sdeq772@163.com')
order by t0.business
;

