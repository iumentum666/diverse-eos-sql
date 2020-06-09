SELECT 
	t.task_id as Oppgave,
	--CONVERT(DATETIME2(0), t.actual_start_dttm) as Starttidspunkt,
	--CONVERT(DATETIME2(0), t.actual_end_dttm) as Sluttidspunkt,
	CONVERT(DATETIME2(0), te.event_dttm) as ReiseStartet,
	t.person_id as Oppgaveeier,
	r.req_class as Ordretype,
	r.sales_grp_d as Avdelingsnummer,
	r.place_id as TTP,
	a.geocode_lat as Latitud,
	a.geocode_long as Longitude

 
   
FROM task t
left join request r on t.request_id = r.request_id
left join place_address p on r.place_id = p.place_id
left join address a on p.address_id = a.address_id
left join task_event te on t.task_id = te.task_id

   where sales_grp_d = 20061 
   --and not t.actual_start_dttm = ''
   AND event_type = 'traveling'
   AND  a.address_type = 'DEFAULT'
  group by t.task_id, --t.actual_start_dttm, t.actual_end_dttm, 
  t.person_id, te.event_dttm, r.req_class, r.sales_grp_d, r.place_id, a.geocode_lat, a.geocode_long