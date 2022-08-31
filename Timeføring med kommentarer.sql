select
npu.npu_id,
npu.request_id,
npu.comments,
npu.description,
npu.person_id,
npu.task_id,
npu.quantity,
npu.work_dt
from non_part_usage npu
where npu.comments is not null
and npu.work_dt > '2022-01-01'