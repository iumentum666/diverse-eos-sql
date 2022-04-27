use IFSFSMPROD
SELECT
	r.request_id,
    r.place_id as TTP,
    r.req_type as Feiltype,
    r.req_class as Ordretype,
	r.req_status as AO_status,
	r.user_def2 as Ekstern_status,
	r.sales_grp_d as Avdeling,
	r.cross_reference as Eksternt_ordrenummer,
	re.master_model_id as Hovedprodukt,
	convert(date, r.created_dttm) as Request_opprettet,
    convert(date, re.orig_req_end_date) as orginal_RTL_fra_TN,
	convert(date, re.required_end_date) as RTL,
	convert(date, t.actual_end_dttm) as OppgaveLukket,
	t.task_id as Oppgavenummer,
	t.task_template_id as Type_oppgave,
	t.person_id as Oppgaveeier,
	p.first_name as Fornavn,
	p.last_name as Etternavn,
	n.line_code as Type_tid,
    n.quantity as Tid,
    n.work_dt as Tid_registrert_dato,
	n.person_id as Registrert_av


  FROM request r
  left join task t on t.request_id = r.request_id
  left join address a on t.address_id = a.address_id
  left join request_ext re on re.request_id = r.request_id
  left join non_part_usage n on t.task_id = n.task_id
  left join person p on t.person_id = p.person_id
  where re.master_model_id = 'LVM1B' and not t.task_template_id = 'ENRICH AND ASSIGN' and not t.task_template_id = 'ENRICH TASK WRONGLY COMPLETED'