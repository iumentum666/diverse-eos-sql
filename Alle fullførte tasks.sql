/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	t.task_id as Oppgave,
	t.task_status as Oppgavestatus,
	CONVERT(DATETIME2(0), t.created_dttm) as 'Oppgave opprettet',
	CONVERT(DATETIME2(0),isnull(re.completed_dttm, r.user_def_dttm5)) AS 'Ordre fullført', 
	t.person_id as Oppgaveeier,
	CONCAT(owner.first_name, ' ', owner.last_name)     as 'Ordre eier navn',
	r.req_class as Ordretype,
	t.task_type as Oppgavetype,
	t.user_def14 as Fullføringsgrunn,
	t.user_def16 as 'Detaljert fullføringsgrunn',
	t.user_def15 as Beskrivelse,
	r.sales_grp_d as 'Avdeling',
	a.county_id                                 AS 'Fylke',
	r.place_id as TTP

FROM task t
left join request r on t.request_id = r.request_id
left join request_ext re on r.request_id = re.request_id
left join place_address p on p.place_id = ISNULL(r.user_def11, r.place_id) AND p.address_type = 'DEFAULT'
LEFT JOIN address a ON a.address_id = p.address_id
LEFT JOIN person owner on owner.person_id = t.person_id

   where t.task_status = 'COMPLETED'
   and t.created_dttm >= '2020-01-01'
   
  group by t.task_id, t.task_status, t.created_dttm, t.person_id, owner.first_name, owner.last_name, re.completed_dttm, r.user_def_dttm5,r.req_class,t.task_type, t.user_def14, t.user_def16, t.user_def15, r.sales_grp_d, a.county_id, r.place_id