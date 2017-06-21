select
count(1)
from ODS_USER_HRY_USERS t0
where t0.AUTHENT_TIME BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-01-24','yyyy-MM-dd')

select 
*
from member.tr_personal_member@kjtdb t0

select 
count(1)
from member.tr_verify_entity@kjtdb t0
where t0.VERIFY_TYPE=1 and t0.STATUS=1 and t0.CREATE_TIME  BETWEEN to_date('2017-01-01','yyyy-MM-dd') and to_date('2017-01-24','yyyy-MM-dd')

select 
*
from memeber.tm_meber@kjtdb t0
where t0.VERIFY_LEVEL>0
where 