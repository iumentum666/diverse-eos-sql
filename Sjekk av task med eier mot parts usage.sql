/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	  t.request_id AOnummer,
	  t.task_id as Oppgavenummer,
      convert(varchar, t.actual_end_dttm , 104) as Fullførtdato,
      t.description as OppgaveDesc,
      t.person_id as Eier,
      t.task_status as Oppgavestatus,
      t.task_type as Oppgavetype,
      t.team_id as Lag,
	  re.master_model_id as HovedproduktPåOrdre,
      p.part_id as FakturertMateriell,
	  p.quantity as FakturertAntall,
	  p.person_id as FakturertAv

  FROM task t
  left join part_usage p on t.request_id = p.request_id
  left join request_ext re on t.request_id = re.request_id
  where t.task_status = 'COMPLETED' and t.team_id = 'PSO_ENGINEERS' and t.actual_end_dttm > '2020-01-01 00:00' and not t.task_type in ('CRI FAULT COAX', 'CRI FAULT FIBER', 'WRI FAULT FIBER')