/****** Script for SelectTopNRows command from SSMS  ******/
SELECT r.request_id as 'EOS Nummer'
      ,cross_reference as 'Eksternt Ordrenummer'
      ,req_class as Ordretype
	  ,re.current_fix_dttm  AS 'Gjeldende rettetid'
      ,re.required_end_date AS 'Påkrevd sluttdato'

  FROM request r
       INNER JOIN request_ext re ON re.request_id = r.request_id