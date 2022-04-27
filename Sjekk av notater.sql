/****** Script for SelectTopNRows command from SSMS  ******/
SELECT rt.request_id,
      rt.text_line_code,
      replace(replace(rt.Text, char(10), ' '), char(13), ' ')  as Notat,
      rt.user_def2,
      rt.user_def3,
      rt.user_def4,
      rt.user_def_dttm1,
      rt.modified_by,
      rt.modified_dttm,
	  rt.created_by,
      rt.created_dttm,
	  concat(p.first_name, ' ',p.last_name)
  FROM request_text rt
  left join person p on rt.created_by = p.person_id

  where rt.text_line_code = 'TELENOR' and rt.created_by != 'METRIX'