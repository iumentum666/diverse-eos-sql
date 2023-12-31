/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	t.task_id as Oppgave,
	--CONVERT(DATETIME2(0), t.actual_start_dttm) as Starttidspunkt,
	--CONVERT(DATETIME2(0), t.actual_end_dttm) as Sluttidspunkt,
	CONVERT(DATETIME2(0),isnull(re.completed_dttm, r.user_def_dttm5)) AS 'Ordre fullført', 
	t.person_id as Oppgaveeier,
	r.req_class as Ordretype,
	t.task_type as Oppgavetype,
	r.sales_grp_d as Avdelingsnummer,
	r.place_id as TTP,
	a.address_id as AdresseID,
	a.geocode_lat as Latitud,
	a.geocode_long as Longitude

 
   
FROM task t
left join request r on t.request_id = r.request_id
left join request_ext re on r.request_id = re.request_id
left join place_address p on r.place_id = p.place_id
left join address a on p.address_id = a.address_id


   where sales_grp_d = 20061 
   --and not t.actual_start_dttm = ''
   -- AND event_type = 'traveling'
   AND  a.address_type = 'DEFAULT'
   AND t.task_type not in ('INVOICING', 'ENRICH AND ASSIGN', 'DOCUMENTATION', 'PRE DOC')
  group by t.task_id, --t.actual_start_dttm, t.actual_end_dttm, 
  t.person_id, re.completed_dttm, r.user_def_dttm5,r.req_class,t.task_type, r.sales_grp_d, r.place_id, a.address_id,a.geocode_lat, a.geocode_long