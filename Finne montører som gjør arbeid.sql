use IFSFSMPROD

select 

p.person_id,
p.last_name,
p.first_name,
p.job_title,
p.dispatchable,
p.mobile_user,
p.threesixty_resource,
pr.user_role,
p.metrix_user_type,
p.status,
t.task_id

from person p

left join person_role pr on p.person_id = pr.person_id
CROSS APPLY (select top 1
ta.task_id
from task ta where ta.person_id = p.person_id and
ta.created_dttm > '2020-08-01 00:00:00.000') t

where (p.metrix_user_type = 'MOBILE' OR pr.user_role = 'DMF/NRI TECHNICIAN') and p.status = '01'