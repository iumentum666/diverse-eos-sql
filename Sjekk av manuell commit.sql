USE IFSFSMPROD
SELECT t.task_id as Oppgavenummer,
	t.request_id as Arbeidsordre,
	r.place_id as TTP,
	r.cross_reference as Eksterntordrenummer,
	r.req_type as TypeOrdre,
	r.req_class as TypeFeil,
	r.sales_grp_d as Avdeling,
	t.task_type as Oppgavetype,
	te.user_def1 as Melding,
    te.event_type as StatusEndretTil,
    convert(datetime2(0), te.event_dttm) as DatoForCommit,
    te.description as Commited,
    te.modified_by as HvemCommited
     
  FROM task t
  left join request r on t.request_id = r.request_id
  cross apply (
	Select top 1 
		user_def1, 
		event_type,
		event_dttm,
		description,
		modified_by
		From task_event 
		where task_event.task_id = t.task_id and event_type = 'DISPATCHED'
		order by event_sequence desc
	) te
	where not task_type in ('ENRICH AND ASSIGN', 'PRE DOC', 'INVOICING', 'DOCUMENTATION')
	    and te.event_dttm > '2020-05-01'
	order by t.task_id desc