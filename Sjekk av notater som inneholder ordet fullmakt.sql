/****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct rt.request_id

      ,rt.text_line_code
      ,replace(replace(Text, char(10), ' '), char(13), ' ')  as Notat

      ,rt.user_def2
      ,rt.user_def4
  



      ,rt.created_by
      ,CONVERT(DATETIME2(0), rt.created_dttm) as Created_date
	  ,t.task_class
	  ,t.task_id
	  ,t.person_id
	  ,p.user_def12 as Avdelingsnummer
  FROM request_text rt
  left join task t on t.request_id = rt.request_id
  left join person p on t.person_id = p.person_id


  where rt.text like ('%fullmakt%') and rt.text_line_code not in ('NOTE', 'STATUSCHANGEREMARK', 'TO TELENOR', 'REJECTIONMESSAGE', 'TO CDK') and rt.created_by = 'METRIX'