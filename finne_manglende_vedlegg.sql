SELECT
r.request_id,
ra.attachment_id,
ra.user_def1,
ra.user_def4,
t.task_id

from request r
inner join request_attachment ra on r.request_id = ra.request_id
inner join task t on r.request_id = t.request_id
left join task_attachment ta on t.task_id = ta.task_id AND ra.attachment_id = ta.attachment_id

where r.req_status not in ('COMPLETE','CANCELED','CLOSED') and ta.attachment_id IS NULL



WITH task_attachment
	as (SELECT
ra.attachment_id as ra_attachment_id,
t.task_id as ttask_id

from request r
inner join request_attachment ra on r.request_id = ra.request_id
inner join task t on r.request_id = t.request_id
left join task_attachment ta on t.task_id = ta.task_id AND ra.attachment_id = ta.attachment_id

where r.req_status not in ('COMPLETE','CANCELED','CLOSED') and ta.attachment_id IS NULL and r.request_id = '65305')

UPDATE task_attachment
SET
	task_id = ttask_id,
	attachment_id = ra_attachment_id,
	user_def2 = 'Y'