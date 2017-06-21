select
*
from TBL_REPORT_ROLE t0
order by t0.CREATE_DATE desc
;

------- 报表角色关系
select
t0.*,
t1.role_code,
t1.ROLE_NAME,
t1.DESCRIPTION,
t2.report_code,
t2.REPORT_NAME,
t2.CLASS_NAME
from tbl_role_report t0
inner join TBL_REPORT_ROLE t1
on t0.role_id=t1.role_id
inner join (select
t0.REPORT_ID,
t0.REPORT_CODE,
t0.REPORT_NAME,
t1.CLASS_NAME
from tbl_report t0 
left join TBL_REPORT_CLASS t1 
on t0.class_id=t1.CLASS_ID) t2
on t0.report_id=t2.report_id
ORDER BY  t0.ROLE_ID,t2.CLASS_NAME,t2.REPORT_ID
;


------- 用户角色关系
select
t0.*,
t1.USER_NAME,
t1.user_code,
t1.POSITION,
t1.USER_MAIL,
decode(t1.ENABLED,1,'正常',0,'禁用','其他') 用户状态,
t2.ROLE_CODE,
t2.ROLE_NAME
from tbl_report_user_role t0
inner join sys_user t1
on t0.USER_ID=t1.USER_ID
inner JOIN TBL_REPORT_ROLE t2
on t0.ROLE_ID=t2.ROLE_ID
where t1.ENABLED=1
ORDER BY t0.ROLE_ID,t0.USER_ID asc
;
