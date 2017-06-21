select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HBindPhoneAndAuthNameScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

--绑定银行卡
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HBindBankCardScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 设置支付密码
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HSetPayPwdScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 天天聚开通
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HOpenTTJScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 转入金额录入
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HTTJSwitchToScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 收银台订单确认
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene = 'HReactNativeScene-cashier'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 收银台验证
select * from bi_data_pv a left join bi_data_com b on a.com_id = b.id
inner join bi_data_event c on a.sessionid = c.sessionid
where a.scene = 'HReactNativeScene-cashier' and b.app_ver like '2.0.9%' and c.key = 'fund_019'

-- 商品详情
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HProductDetailScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- 投资结果
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HBuyResultScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

-- HPayResultScene-结果详情
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HPayResultScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');

--HTTJRollOutScene
select to_char(logtime,'yyyymmdd'),scene,count(1) from bi_data_pv where scene like 'HTTJRollOutScene%'
group by scene,to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd');


select * from bi_mobile_funnel_data where rptdt = '20170112' and rpt_id = 1 and app_type = 'iOS'

select count(distinct(a.sessionid)) from bi_data_pv a left join  bi_data_com b on a.com_id = b.id 
INNER JOIN BI_DATA_event C ON a.sessionid = c.sessionid
where to_char(a.logtime,'yyyymmdd') = 20170112
and sys_name = 'iOS' and key = 'register_002' and a.scene = 'HBindPhoneAndAuthNameScene-实名认证'

select * from bi_data_event where key = 'register_002' and to_char(logtime,'yyyymmdd') = 20170112

select to_char(logtime,'yyyymmdd'),count(1) from bi_data_pv where prescene = '注册'
and scene = 'HBindPhoneAndAuthNameScene-实名认证'
group by to_char(logtime,'yyyymmdd')
order by to_char(logtime,'yyyymmdd')

select * from bi_data_event where sessionid in (
  select sessionid from bi_data_pv where sessionid in (
    select sessionid from bi_data_pv where sessionid in (
        select sessionid from bi_data_pv where sessionid in (
          select sessionid from bi_data_pv where sessionid in  (
            select sessionid from bi_data_event where key = 'register_002' and to_char(logtime,'yyyymmdd') = 20170112
              and com_id = '601a5c46d43ac45afbcf9d109b7df37a'
          ) and scene = 'HBindPhoneAndAuthNameScene-实名认证'
            and prescene = '注册'
        ) and prescene = 'HBindPhoneAndAuthNameScene-实名认证'
        and scene in ('HBindBankCardScene','HBindBankCardScene-绑定银行卡')
    ) and prescene in ('HBindBankCardScene','HBindBankCardScene-绑定银行卡')
      and scene in ('HSetPayPwdScene','HSetPayPwdScene-设置支付密码')
  ) and prescene in ('HSetPayPwdScene','HSetPayPwdScene-设置支付密码')
  and scene = 
  'HSetGesturepwdScene-设置手势密码'
)
and key = 'register_011'

select * from bi_data_pv a inner join bi_data_event b on a.sessionid = b.sessionid
where a.sessionid = '1484219793628'
AND a.com_id = '601a5c46d43ac45afbcf9d109b7df37a'
and key = 'register_002'


