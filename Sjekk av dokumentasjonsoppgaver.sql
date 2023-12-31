
SELECT 
task_id,
description,
person_id,
task_status,
CONVERT(DATETIME2(0),actual_start_dttm) as 'Actual Start',
CONVERT(DATETIME2(0),actual_end_dttm) as 'Actual End',
task_template_id,
task_type,
team_id,
request_unit_id,
user_def5,
user_def6,
user_def7,
user_def9,
modified_by,
CONVERT(DATETIME2(0),modified_dttm) as 'Modified dttm',
created_by,
CONVERT(DATETIME2(0),created_dttm) as 'Created dttm'
from task

where task_template_id = 'DOCUMENTATION'