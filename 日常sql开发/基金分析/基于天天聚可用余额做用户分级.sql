select 
    tt.f01 海融易id,
    ttt.member_name 姓名,
    tt.f04 手机号,
    t.avl_share/100 天天聚可用余额,
    decode(greatest(t.avl_share/100,9999),9999,'<1w',
      decode(greatest(t.avl_share/100,49999),49999,'1w-5w',
        decode(greatest(t.avl_share/100,99999),99999,'5-10w',
          decode(greatest(t.avl_share/100,499999),499999,'10w-50w',
          '>50w')))) 分级,
    decode(tt.f06,'ZRR','自然人','FZRR','非自然人') 账户类型
  from  
    funduser.t_fund_share_info@fdb t
  left join s_s61_t6110 tt
    on t.kjt_cust_id=tt.kjtid
  left join member.tm_member@kjtdb ttt
    on t.kjt_cust_id=ttt.member_id
 where tt.f01 is not null and t.avl_share/100>0
 order by t.avl_share desc;
 ------
 
 
 ------
 select 
    tt.f01 海融易id,
    ttt.member_name 姓名,
    tt.f04 手机号,
    t.avl_share/100 天天聚可用余额,
    decode(greatest(t.avl_share/100,9999),9999,'<1w',
      decode(greatest(t.avl_share/100,49999),49999,'1w-5w',
        decode(greatest(t.avl_share/100,99999),99999,'5-10w',
          decode(greatest(t.avl_share/100,499999),499999,'10w-50w',
          '>50w')))) money,
    decode(tt.f06,'ZRR','自然人','FZRR','非自然人') 账户类型
  from  
    funduser.t_fund_share_info@fdb t
  left join s_s61_t6110 tt
    on t.kjt_cust_id=tt.kjtid
  left join member.tm_member@kjtdb ttt
    on t.kjt_cust_id=ttt.member_id
 where tt.f01 is not null and t.avl_share/100>0 and tt.f01 not in (select t0.f03 from s_s62_T6250 t0 where t0.f06 > to_date('2017-01-02','yyyy-MM-dd'))
 order by t.avl_share desc;
 
 