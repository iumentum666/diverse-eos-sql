SELECT
r.request_id as 'Ordrenummer',
CAST(re.event_dttm as date) as 'Status endret',
r.req_class as 'Ordrertype',
r.sales_grp_d as 'Avdeling på ordre',
re.created_by as 'Person sendt KA',
p.first_name as 'Fornavn',
p.last_name as 'Etternavn',
p.user_def12 as 'Avdeling på person',
re.note,
CASE
	WHEN left(re.note, 24) like '%KA%'  THEN 'KA'
	WHEN left(re.note, 24) like '%ER%'  THEN 'ER'
	WHEN left(re.note, 24) like '%EL%'  THEN 'EL'
	WHEN left(re.note, 24) like '%APP%'  THEN 'APP'
	WHEN left(re.note, 24) like '%NCC%'  THEN 'NCC'
	WHEN left(re.note, 24) like '%CAN%'  THEN 'CAN'
	WHEN left(re.note, 24) like '%EXE%'  THEN 'EXE'
	WHEN left(re.note, 24) like '%OK%'  THEN 'OK'
	WHEN left(re.note, 24) like '%VK%'  THEN 'VK'
	WHEN left(re.note, 24) like '%UA%'  THEN 'UA'
	WHEN left(re.note, 24) like '%CPO%'  THEN 'CPO'
	WHEN left(re.note, 24) like '%PCR%'  THEN 'PCR'
	WHEN left(re.note, 24) like '%UF%'  THEN 'UF'
	WHEN left(re.note, 24) like '%TD%'  THEN 'TD'
	WHEN left(re.note, 24) like '%RT%'  THEN 'RT'
	WHEN left(re.note, 24) like '%MO%'  THEN 'MO'
	WHEN left(re.note, 24) like '%RU%'  THEN 'RU'
	WHEN left(re.note, 24) like '%RR%'  THEN 'RR'
	WHEN left(re.note, 24) like '%RM%'  THEN 'RM'
	WHEN left(re.note, 24) like '%TRD%'  THEN 'TRD'
	WHEN left(re.note, 24) like '%PCS%'  THEN 'PCS'
	WHEN left(re.note, 24) like '%PCC%'  THEN 'PCC'
	WHEN left(re.note, 24) like '%MM%'  THEN 'MM'
	WHEN left(re.note, 24) like '%VD%'  THEN 'VD'
	WHEN left(re.note, 24) like '%ASS%'  THEN 'ASS'
	WHEN left(re.note, 24) like '%ENP%'  THEN 'ENP'
	WHEN left(re.note, 24) like '%IPO%'  THEN 'IPO'
	WHEN left(re.note, 24) like '%IU%'  THEN 'IU'
	WHEN left(re.note, 24) like '%PCF%'  THEN 'PCF'
	WHEN left(re.note, 24) like '%PFC%'  THEN 'PFC'
	WHEN left(re.note, 24) like '%WST%'  THEN 'WST'
	WHEN left(re.note, 24) like '%TNC%'  THEN 'TNC'
	WHEN left(re.note, 24) like '% TU %'  THEN 'TU'
	WHEN left(re.note, 24) like '%UV%'  THEN 'UV'
	WHEN left(re.note, 24) like 'Status endret til  av%' THEN 'Blank status'
	WHEN left(re.note, 24) like 'Status endret til  og%' THEN 'Blank status'
	WHEN left(re.note, 24) like 'Status endret til Full%' THEN 'Fullført'
	ELSE re.note END as 'Status sendt'

from request_event re
inner join person p on re.created_by = p.person_id
inner join request r on re.request_id = r.request_id
where re.note like 'Status endret til%'
and re.event_dttm >= '2022-01-01' and p.user_def12 = '20139'
order by re.created_dttm, p.person_id asc