with TMP_PHONE_USER AS (新入职同事 添加邮件组
select
t0.phone,
t1.PROVINCE,
t1.CITY,
t2.HRYID,
t2.AUTHENT_STATUS_NAME
from TMP_STAFF_PHONE  t0
left join bidim.obj_phone t1
on t0.PHONE_PREFIX=t1.phone
LEFT join DIM_USER_HRY_USERS t2
on t0.phone=t2.MOBILE),
TMP_INVEST AS (
select
t0.f03 hryid,
count(*) bill_cout,
sum(t0.f05) invest_amount
from bidata.s_s62_t6250 t0
where t0.f07='F'
group by t0.f03
)
select
t0.phone 手机号,
t0.PROVINCE 省,
t0.CITY 市,
t0.hryid 海融易ID,
(case 
when t1.bill_cout>0 then '投资'
when t0.AUTHENT_STATUS_NAME='已认证' then '实名'
when t0.hryid is not null then '注册'
else '未注册'
end) 状态,
t1.bill_cout 投资次数,
t1.invest_amount 投资金额
from TMP_PHONE_USER t0
left join TMP_INVEST t1
on t0.HRYID=t1.hryid
;