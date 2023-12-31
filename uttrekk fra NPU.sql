/****** Script for SelectTopNRows command from SSMS  ******/
use IFSFSMPROD
SELECT 
	  t.request_id		as Arbeidsordrenummer
	  ,n.task_id		as Oppgavenummer
	  ,t.task_type		as Oppgavetype
	  ,n.npu_id			as 'Part usage nummer'
      ,n.person_id		as Person
      ,n.line_code		as 'Type arbeid'
      ,cast(format(n.quantity, 'N', 'de-de') as varchar(20)) as Lengde
      ,CONVERT(DATETIME2(0), n.work_dt) as 'Dato registrert'

	  
  FROM non_part_usage n
  INNER JOIN task t on n.task_id = t.task_id

  WHERE line_code = 'LABOR' or line_code = 'TRAVEL'
  and n.created_dttm >= '2020-01-01'
