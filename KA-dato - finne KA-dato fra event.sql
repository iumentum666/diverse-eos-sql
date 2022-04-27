Select
rev.request_id,
rev.event_dttm,
rev.note,
substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10)) AS 'KA-dato før konvertering',

CASE
	WHEN
		isdate(substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10))) = 1
		THEN
			CAST(substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10)) as DATETIME2)
		ELSE
			''
	END as 'KA-dato'
from request_event rev where rev.note like ('Status endret til KA%')
and rev.event_dttm > '2022-04-01'