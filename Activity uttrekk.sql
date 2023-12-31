/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
	r.request_id,
    r.place_id as TTP,
    r.req_type as Feiltype,
    r.req_class as Ordretype,
    r.req_category,
    r.severity,
	re.master_model_id as Hovedprodukt,
	convert(date, r.created_dttm) as Request_opprettet,
    convert(date, re.orig_req_end_date) as RTL,
	convert(date, t.actual_end_dttm) as OppgaveLukket,
	t.task_id,
	t.task_template_id,
	t.plan_task_dur_min,
	t.schedule_value,
	t.address_id,
	t.person_id as Oppgaveeier,
	a.geocode_lat,
	a.geocode_long,
	--- Slår sammen alle skills i en streng for innlesing i wise
	Skills = JSON_VALUE(
   REPLACE(
     (SELECT _ = ts.Skill FROM task_skill ts WHERE ts.task_id = t.task_id FOR JSON PATH)
    ,'"},{"_":"',';'),'$[0]._'
	) 

  FROM request r
  left join task t on t.request_id = r.request_id
  left join address a on t.address_id = a.address_id
  left join request_ext re on re.request_id = r.request_id
    where r.request_id >= '100000' AND NOT t.task_template_id = 'ENRICH AND ASSIGN' AND NOT t.task_template_id = 'ENRICH TASK WRONGLY COMPLETED' AND NOT t.task_template_id = 'PRE_DOC' AND NOT t.task_template_id = 'INVOICING' and NOT t.task_template_id = 'DOCUMENTATION' AND NOT r.req_class = 'DMF' and t.actual_end_dttm >= '2020-02-10' and t.actual_end_dttm < '2020-02-11'