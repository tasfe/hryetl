select
u1.user_name 用户名称,
r1.role_name 角色名称,
T.class_name 报表分类,
T.REPORT_NAME 报表名称
from TBL_REPORT_USER_ROLE r0
left join tbl_report_role r1
on r0.role_id=r1.role_id
left join SYS_USER u1
on r0.USER_ID=u1.USER_ID
left join (select 
t1.REPORT_ID,
t1.ROLE_ID,
t2.REPORT_NAME,
t2.CLASS_NAME
from TBL_ROLE_REPORT t1
left join (select 
tr.REPORT_ID,
tr.REPORT_NAME,
tc.CLASS_NAME
from TBL_REPORT tr
left join TBL_REPORT_CLASS tc
on tr.CLASS_ID = tc.CLASS_ID) t2
on t1.REPORT_ID=t2.REPORT_ID) T
on r0.ROLE_ID=T.ROLE_ID
where u1.ENABLED=1 and u1.IS_DELETED=0 and u1.USER_ID not in (1,6741)
ORDER BY u1.USER_NAME asc
;
----
select 
t3.ROLE_NAME 角色名称,
t2.CLASS_NAME 报表分类,
t2.REPORT_NAME 报表名称
from TBL_ROLE_REPORT t1
left join TBL_REPORT_ROLE t3
on t1.role_id=t3.role_id
left join (select 
tr.REPORT_ID,
tr.REPORT_NAME,
tc.CLASS_NAME
from TBL_REPORT tr
left join TBL_REPORT_CLASS tc
on tr.CLASS_ID = tc.CLASS_ID) t2
on t1.REPORT_ID=t2.REPORT_ID
where t1.ROLE_ID not in (262)
ORDER BY t3.ROLE_NAME,t2.CLASS_NAME
;
