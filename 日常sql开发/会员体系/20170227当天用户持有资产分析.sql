with tmp_p2p_0227_user_level as
(
select
TT.hryid,
decode(greatest(TT.p_aum_0227,49999),49999,'<l_0_5w',
      decode(greatest(TT.p_aum_0227,99999),99999,'l_5w_10w',
        decode(greatest(TT.p_aum_0227,199999),199999,'l_10w_20w',
          decode(greatest(TT.p_aum_0227,499999),499999,'l_20w-50w',
            decode(greatest(TT.p_aum_0227,999999),999999,'l_50w_100w',
              decode(greatest(TT.p_aum_0227,4999999),4999999,'l_100w_500w',
          '>500w')))))) aum_level
from (
select
T.hryid,
nvl((select sum(p0.AMT) from TMP_P2P_PAY_BACK_PLAN p0 where p0.INCOME_DATE < to_date('20170227','yyyymmdd') and p0.TOPAY_DATE>=to_date('20170227','yyyymmdd') and p0.HRYID=T.hryid),0) p_aum_0227
from TMP_P2P_INVESTOR T
) TT
)
select tpul.aum_level,count(*)  from tmp_p2p_0227_user_level tpul
group by tpul.aum_level
;