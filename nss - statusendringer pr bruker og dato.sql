SELECT
CAST(re.event_dttm as date) as 'Status endret',
r.req_class as 'Ordrertype',
r.sales_grp_d as 'Avdeling på ordre',
re.created_by as 'Person sendt KA',
p.first_name as 'Fornavn',
p.last_name as 'Etternavn',
p.user_def12 as 'Avdeling på person',

CASE
	WHEN re.note like '%KA%'  THEN 'KA'
	WHEN re.note like '%ER%'  THEN 'ER'
	WHEN re.note like '%EL%'  THEN 'EL'
	WHEN re.note like '%APP%'  THEN 'APP'
	WHEN re.note like '%NCC%'  THEN 'NCC'
	WHEN re.note like '%CAN%'  THEN 'CAN'
	WHEN re.note like '%EXE%'  THEN 'EXE'
	WHEN re.note like '%OK%'  THEN 'OK'
	WHEN re.note like '%VK%'  THEN 'VK'
	WHEN re.note like '%UA%'  THEN 'UA'
	WHEN re.note like '%CPO%'  THEN 'CPO'
	WHEN re.note like '%PCR%'  THEN 'PCR'
	WHEN re.note like '%UF%'  THEN 'UF'
	WHEN re.note like '%TD%'  THEN 'TD'
	WHEN re.note like '%RT%'  THEN 'RT'
	WHEN re.note like '%MO%'  THEN 'MO'
	ELSE re.note END as 'Status sendt'

from request_event re
inner join person p on re.created_by = p.person_id
inner join request r on re.request_id = r.request_id
where re.note like 'Status endret til%'
and re.event_dttm >= '2022-01-01' and p.user_def12 = '20139'
order by re.created_dttm, p.person_id asc