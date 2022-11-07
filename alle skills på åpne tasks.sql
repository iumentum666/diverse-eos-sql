/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
t.task_id,
ts.skill

from task t

left join task_skill ts on ts.task_id = t.task_id
where t.task_status = 'Open'


---
-- Denne under finner alle skills på avdelinger
SELECT
r.sales_grp_d,
t.task_template_id,
ts.skill


from task t
left join request r on t.request_id = r.request_id

left join task_skill ts on ts.task_id = t.task_id
where t.task_status = 'Open' and t.created_dttm > '2022-08-01'
and t.task_template_id not in ('INVOICING', 'NSS_BOOKING')

group by r.sales_grp_d, t.task_template_id, ts.skill
order by sales_grp_d, task_template_id