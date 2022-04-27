/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [request_id]

      ,[text_line_code]
      ,replace(replace(Text, char(10), ' '), char(13), ' ')  as Notat

      ,[user_def2]
      ,[user_def3]
      ,[user_def4]
  
      ,[user_def_dttm1]

      ,[modified_by]
      ,[modified_dttm]
      ,[created_by]
      ,[created_dttm]
  FROM [IFSFSMPROD].[dbo].[request_text]

  where text like ('%plugg%') /****and text_line_code in ('NOTE', 'STATUS_CHANGE_REMARK') */