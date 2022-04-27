/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
		[task_id] as Oppgavenummer
		,[request_id] as Arbeidsordrenummer
      ,[description] as Oppgavetype

      ,[person_id] as Oppgaveeier
		,[task_status] as Oppgavestatus

 

      ,[modified_by] as 'Modifisert av'
      ,CONVERT(DATETIME2(0),modified_dttm) as 'Endret dato'
      ,[created_by] as 'Opprettet av'
      ,CONVERT(DATETIME2(0),created_dttm) as 'Opprettet dato'
  FROM [IFSFSMPROD].[dbo].[task]
  where task_template_id in ('Enrich and Assign', 'ENRICH TASK WRONGLY COMPLETED') and
task_status not in  ('Completed', 'Closed', 'Canceled') 