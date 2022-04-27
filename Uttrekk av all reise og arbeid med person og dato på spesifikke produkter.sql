SELECT a.county_id                                              AS 'Fylke',
       r.sales_grp_d                                            AS 'Avdeling',
       r.request_id                                            AS 'Ordre ID',
       r.user_def6                                              AS 'IFS Nummer',
       r.user_def17                                             AS 'Ordre eier',
       r.req_status                                             AS 'Ordre status',
       r.user_def2                                              AS 'Ekstern status',
       r.req_class                                              AS 'Ordre type',
       pu.USER_DEF1                                             AS 'Signatur',
	   pu.created_by											AS 'Opprettet av',
	   pu.person_id												AS 'Person ID',
	   ru.model_id												as Hovedprodukt,
       pu.part_id                                               AS 'Artikkelnr',
       SUM(quantity)                                            AS 'Antall',
	   t.task_id												AS 'Oppgavenummer',
	   t.task_type												as 'Oppgavetype',
	   isnull(travel.Lengde, 0)									as 'Reise på oppgave',
	   travel.Person											as 'Reise registrert av',
	   CONVERT(DATETIME2(0), travel.Dato)						as 'Reise registrert dato',
	   isnull(labor.lengde, 0)									as 'Arbeid på oppgave',
	   labor.Person												as 'Arbeid registrert av',
	   CONVERT(DATETIME2(0), labor.Dato)						as 'Arbeid registrert dato'

  FROM request r
  
       left JOIN part_usage pu ON pu.request_id = r.request_id
       LEFT JOIN place_address pa ON r.place_id = pa.place_id AND pa.address_type = 'DEFAULT'
       LEFT JOIN address a ON pa.address_id = a.address_id
	   left join task t on r.request_id = t.request_id
	   CROSS APPLY (
			SELECT top 1 model_id
			FROM request_unit requ
			WHERE requ.request_id = r.request_id
		) ru
left join (
	select
	t.task_id			as oppgavenummer,
	np.person_id		as Person,
	np.work_dt			as Dato,
	cast(format(sum(np.quantity), 'N', 'de-de') as varchar(20)) as Lengde
	from task t
	left join non_part_usage np on t.task_id = np.task_id
	where np.line_code = 'TRAVEL'
group by t.task_id, np.person_id, np.work_dt) travel on t.task_id = travel.oppgavenummer

left join (
	select
	t.task_id			as oppgavenummer,
	np.person_id		as Person,
	np.work_dt			as Dato,
	cast(format(sum(np.quantity), 'N', 'de-de') as varchar(20)) as Lengde
	from task t
	left join non_part_usage np on t.task_id = np.task_id
	where np.line_code = 'LABOR'
group by t.task_id, np.person_id, np.work_dt) labor on t.task_id = labor.oppgavenummer

 WHERE r.created_dttm >= '2021-09-01' --and (pu.part_id in ('LVA1%', 'LVM2%') or ru.model_id in ('LVA1%', 'LVM2%'))

 GROUP BY a.county_id,
          r.sales_grp_d,
          r.request_id,
          r.user_def6,
          pu.unit_price,
          pu.part_line_code,
          pu.user_def2,	
          pu.user_def9,
          r.user_def17,
          r.req_status,
          r.user_def2,
          r.req_class,
          pu.USER_DEF1,
		  pu.created_by,
		  pu.person_id,
		  ru.model_id,
		  pu.part_id,
          pu.user_def_dttm1,
		  t.task_id,
		t.task_type,
	   travel.Lengde,
	 labor.lengde,
	 travel.Person,
	   travel.Dato,
	   labor.Person,
	   labor.Dato	