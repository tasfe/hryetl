select
t0.*,
decode(t1.f04,'TG','通过','BTG','不通过','未认证') ver_state
from v_hry_staff t0
left join bidata.S_S61_T6141 t1
on t0.hryid=t1.F01
left join bidata.S_S62_T6250 t2
on t0.HRYID=t1.F03
left join funduser.t_fund_share_order t3
on t0.kjtid=t3.kjt_cust_id
;

select
* 
from (
select 
T.*,
'P2P' AS business
from (
select 
t0.hryid,
t0.kjtid,
t0.sjhm,
t0.ver_state,
t0.created_time,
count(t1.F01) order_count,
sum(t1.f05) invest_amount
from v_hry_staff t0
left join bidata.S_S62_T6250 t1
on t0.HRYID=t1.F03
where t0.created_time<to_date('20170207','yyyymmdd') and t1.F07='F' and t1.f06 < to_date('20170207','yyyymmdd')
group by t0.hryid,t0.kjtid,t0.sjhm,t0.ver_state,t0.created_time
) T
UNION all
select 
T.*,
'FUND' AS business
from (
select 
t0.hryid,
t0.kjtid,
t0.sjhm,
t0.ver_state,
t0.created_time,
count(t1.order_id) order_count,
sum(t1.trans_amt)/100 invest_amount
from v_hry_staff t0
left join funduser.t_fund_share_order@fdb t1
on t0.kjtid=t1.kjt_cust_id
where t0.created_time<to_date('20170207','yyyymmdd') and t1.trans_type='I' and t1.status=5 and t1.update_time < to_date('20170207','yyyymmdd')
group by t0.hryid,t0.kjtid,t0.sjhm,t0.ver_state,t0.created_time
) T
) TT
order by TT.sjhm
;


select
T.*,
T1.p2p_order_count,
T1.p2p_invest_amount,
T2.fund_order_count,
T2.fund_invest_amount
from v_hry_staff T
left join (
select 
t0.hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount
from v_hry_staff t0
left join bidata.S_S62_T6250 t1
on t0.HRYID=t1.F03
where t0.created_time<to_date('20170207','yyyymmdd') and t1.F07='F' and t1.f06 < to_date('20170207','yyyymmdd')
group by t0.hryid ) T1
on T.hryid=T1.hryid
left join (
select
t0.hryid,
count(t1.order_id) fund_order_count,
sum(t1.trans_amt)/100 fund_invest_amount
from V_HRY_STAFF t0
left join funduser.t_fund_share_order@fdb t1
on t0.kjtid=t1.kjt_cust_id
where t0.created_time<to_date('20170207','yyyymmdd') and t1.trans_type='I' and t1.status=5 and t1.update_time < to_date('20170207','yyyymmdd')
group by t0.hryid) T2
on T.hryid=T1.hryid
where T.CREATED_TIME <to_date('20170207','yyyymmdd') 
;


----
select
T0.*,
T1.p2p_order_count,
T1.p2p_invest_amount,
T1.fund_order_count,
T1.fund_invest_amount
from v_hry_staff T0
inner join (
select 
t0.hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount,
count(t2.order_id) fund_order_count,
sum(t2.trans_amt)/100 fund_invest_amount
from v_hry_staff t0
left join bidata.S_S62_T6250 t1
on t0.HRYID=t1.F03
left join funduser.t_fund_share_order@fdb t2
on t0.kjtid=t2.kjt_cust_id
where t0.created_time<to_date('20170207','yyyymmdd') and t1.F07='F' and t1.f06 < to_date('20170207','yyyymmdd') and t2.trans_type='I' and t2.status=5 and t2.update_time < to_date('20170207','yyyymmdd')
group by t0.hryid
) T1
on T0.hryid=T1.hryid
ORDER BY T0.SJHM
;

select
T.hryid 海融易id,
T.KJTID 绑定快捷通id,
T.SJHM 办公手机号码,
T.VER_STATE 认证状态,
to_char(T.created_time, 'yyyymmdd') 用户创建时间,
T1.p2p_order_count P2P投资次数,
T1.p2p_invest_amount P2P投资金额,
T2.fund_order_count 基金投资次数,
T2.fund_invest_amount 基金投资金额
from v_hry_staff T
left join (
select
t1.F03 hryid,
count(t1.F01) p2p_order_count,
sum(t1.f05) p2p_invest_amount
from bidata.S_S62_T6250 t1
where t1.F07='F' and t1.f06 < to_date('20170401','yyyymmdd')
group by t1.F03 ) T1
on T.hryid=T1.hryid
left join (
select
t2.kjt_cust_id kjtid,
count(t2.order_id) fund_order_count,
sum(t2.trans_amt)/100 fund_invest_amount
from funduser.t_fund_share_order@fdb t2
where t2.trans_type='I' 
and t2.status=5 
and t2.create_time < to_date('20170401','yyyymmdd')
group by t2.kjt_cust_id) T2
on T.kjtid=T2.kjtid
where T.created_time < to_date('20170401','yyyymmdd')
;




select
*
from bidata.s_s62_t6250 t0
where t0.F03='66'
;

SELECT * 
from funduser.t_fund_share_order@fdb t2
where t2.trans_type='I' and t2.status=5 and t2.update_time < to_date('20170207','yyyymmdd') and t2.kjt_cust_id='100000050238'
;
