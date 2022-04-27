/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
t.task_id,
ts.skill

from task t

left join task_skill ts on ts.task_id = t.task_id
where t.task_status = 'Open'