/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      np.request_id as Arbeidsordre,
      np.task_id as Oppgavenummer,
	  r.sales_grp_d as Avdeling,
	  t.task_template_id as Oppgavetype,
      np.person_id as Person,
      np.description as Status,
      cast(format(np.quantity, 'N', 'de-de') as varchar(20)) as 'Lengde i desimaler',
      CONVERT(DATETIME2(0), np.work_dt) as Arbeidsdato,
      --np.duration as 'Lengde i minutter',
      np.modified_by as 'Endret av',
      np.modified_dttm as 'Endret dato',
      np.created_by as 'Opprettet av',
      np.created_dttm as 'Opprettet dato',
	  Iif(np.quantity<=0.03,'Ja','Nei') as '<= 1 minutt',
	  Iif(np.quantity<=0.1,'Ja','Nei') as '<= 6 minutt',
	  Iif(np.quantity<=0.18,'Ja','Nei') as '<= 10 minutt',
	  Iif(np.quantity>7.5,'Ja','Nei') as '> 7,5 t'
  FROM non_part_usage np
  left join request r on np.request_id = r.request_id
  left join task t on np.task_id = t.task_id
  where np.description in ('Travel', 'Labor')
  and np.created_dttm >= '2020-05-01'
  and np.team_id = 'PSO_ENGINEERS'
  and not t.task_template_id in ('ENRICH AND ASSIGN', 'CABLE PLANNING', 'DOCUMENTATION')