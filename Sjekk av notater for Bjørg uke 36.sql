/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
	request_id,
    text_line_code,
    replace(replace(Text, char(10), ' '), char(13), ' ')  as Notat,
	user_def2,
    user_def3,
	user_def4,
	CONVERT(DATETIME2(0), user_def_dttm1),
	modified_by,
	CONVERT(DATETIME2(0), modified_dttm),
	created_by,
	CONVERT(DATETIME2(0), created_dttm)
  FROM [IFSFSMPROD].[dbo].[request_text]

  where text like ('%Telenor feil uke 36, medfører ekstra tillegg arbeid/reise%') /****and text_line_code in ('NOTE', 'STATUS_CHANGE_REMARK') */