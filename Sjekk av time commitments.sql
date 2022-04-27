/****** Script for SelectTopNRows command from SSMS  ******/
SELECT tc.tc_id,
	tc.task_id,
	t.task_status,
	r.request_id,
	r.req_status,
      tc.response_code,
      tc.response_type,
      tc.description,
      tc.status,
      
      CONVERT(DATETIME2(0), tc.start_dttm) as Start,
      CONVERT(DATETIME2(0), tc.commit_dttm) as 'Commit',
      tc.apply_cust_calendar,
      tc.calendar_id,
      tc.commit_interval,
      tc.commit_units,
      tc.end_of_day,
      tc.modified_by,
      CONVERT(DATETIME2(0), tc.modified_dttm) as Modified,
      tc.created_by,
      CONVERT(DATETIME2(0), tc.created_dttm) as Created
  FROm time_commit tc
  left join task t on tc.task_id = t.task_id
  left join request r on r.request_id = t.request_id
  where tc.status = 'ACTIVE' and not task_status in ('COMPLETED', 'CLOSED', 'CANCELED')
  order by tc_id desc