--------- 快捷通 区分 集团内外
select 
count(*)
from member.tr_personal_member@kjtdb t2
where t2.create_time BETWEEN to_date(20170123,'yyyymmdd') and TO_DATE(20170207,'yyyymmdd')
;

select 
t0.SOURCE_TAG,
decode(t2.channel_amount,'0','未认证','已认证') ver_tag,
count(*)
from v_kjt_personal_source_tag t0
left join member.tr_personal_member@kjtdb t2
on t0.member_id=t2.member_id
--where t0.CREATE_TIME BETWEEN to_date(20170123,'yyyymmdd') and TO_DATE(20170207,'yyyymmdd')
where t0.CREATE_TIME < TO_DATE(20170101,'yyyymmdd')
group by t0.SOURCE_TAG,decode(t2.channel_amount,'0','未认证','已认证')
;

select
count(*)
from member.tr_personal_member@kjtdb t2
where t2.CREATE_TIME < TO_DATE(20170101,'yyyymmdd')


--------- 海融易区分 集团内外
select 
decode(t2.f04,'TG','通过','BTG','不通过','未认证') ver,
---decode(nvl(t1.KJTID,0),0,'未绑定快捷通','已绑定快捷通') flag,
count(t0.HRYID)
from v_hry_staff t0
left join s_s61_t6110 t1
on t0.hryid=t1.f01
left join s_s61_t6141 t2
on t0.HRYID=t2.F01
where t1.created_time BETWEEN to_date(20170123,'yyyymmdd') and TO_DATE(20170207,'yyyymmdd')
group by decode(t2.f04,'TG','通过','BTG','不通过','未认证')
--decode(nvl(t1.KJTID,0),0,'未绑定快捷通','已绑定快捷通')
;

select 
decode(t2.f04,'TG','通过','BTG','不通过','未认证') ver,
count(*)
from  s_s61_t6110 t1
left join s_s61_t6141 t2
on t1.F01=t2.F01
where t1.created_time BETWEEN to_date(20170123,'yyyymmdd') and TO_DATE(20170207,'yyyymmdd')
group by decode(t2.f04,'TG','通过','BTG','不通过','未认证') 

;

select 
* 
from s_s61_t6110 t0
where t0.f01='426'
;


select 
count(distinct(t0.HRYID))
from v_hry_staff t0
;

select 
T.认证状态,
count(*)
from (
select
t0.hryid 还容易ID,
t0.STAFF_PHONE 员工手机号,
decode(t1.f04,'TG','通过','BTG','不通过','未认证') 认证状态
from v_hry_staff t0
left join s_s61_t6141 t1
on t0.HRYID=t1.F01
order by decode(t1.f04,'TG','通过','BTG','不通过','未认证')
) T
group by T.认证状态
;

----- 未注册海融易
select
*
from wdh.ls_sjhm@kjtdb t1
where t1.sjhm not in (
select staff_phone from v_hry_staff
)
;

select sum(TT.amt) from (
----- 交易用户统计
select 
T.hryid,
T.staff_phone,
sum(T.amount) amt
from (
select 
t0.hryid,
t0.staff_phone ,
t2.F05 amount,
t2.f06 invest_time,
'P2P' AS invest_flag
from v_hry_staff t0
left join S_S62_T6250 t2
on t0.hryid=t2.f03
where t2.F07='F' 
UNION ALL

select
t0.hryid,
t0.staff_phone ,
t1.amt amount,
t1.update_time invest_time,
'FUND' AS invest_flag
from v_hry_staff t0
left join (
select
t1.f01 hryid,
t1.kjtid,
t2.trans_amt/100 amt,
t2.update_time
from s_s61_t6110 t1
left join funduser.t_fund_share_order@FDB t2
on t1.kjtid=t2.kjt_cust_id
where t2.status=5 and t2.trans_type='I'
) t1
on t0.hryid=t1.hryid
) T
where T.amount >0 
and T.invest_time between to_date(20170123,'yyyymmdd') and to_date(20170208,'yyyymmdd')
--and T.invest_flag='P2P'
group by T.hryid,T.staff_phone
ORDER BY T.staff_phone
) TT;






----- 已实名 但未发生 P2P 或者 基金交易的用户
select
t0.hryid 海融易ID,
t0.STAFF_PHONE 员工手机号
from v_hry_staff t0
left join (
select 
t0.f01 hryid,
t0.kjtid,
t2.f04 ver
from s_s61_t6110 t0
left join s_s61_t6141 t2
on t0.f01=t2.f01
) t1
on t0.HRYID=t1.hryid
where t1.ver='TG'
and t0.HRYID not in (select distinct(f03) from S_S62_T6250 where f07='F')
and t1.kjtid not in (
select distinct(t.kjt_cust_id) from funduser.t_fund_share_order@FDB t where t.status=5 and t.trans_type='I'
)
;


----
select
t0.RPTDT,
t0.AMOUNT
from bi_aum_dt t0
where FLAG='天天聚可用余额'
order by RPTDT
;
select
t0.RPTDT,
t0.AMOUNT
from bi_aum_dt t0
where FLAG='p2p投标中'
order by RPTDT
;
