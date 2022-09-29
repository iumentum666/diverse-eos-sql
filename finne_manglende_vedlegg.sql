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