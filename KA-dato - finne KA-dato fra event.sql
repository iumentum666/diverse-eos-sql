Select
request_id,
event_dttm,
note,
substring(note, patindex('%sluttdato%', note)+10, patindex('%.%', note) - (patindex('%sluttdato%', note)+10)) AS 'KA-dato før konvertering',

CASE
	WHEN
		isdate(substring(note, patindex('%sluttdato%', note)+10, patindex('%.%', note) - (patindex('%sluttdato%', note)+10))) = 1
		THEN
			CAST(substring(note, patindex('%sluttdato%', note)+10, patindex('%.%', note) - (patindex('%sluttdato%', note)+10)) as DATETIME2)
		ELSE
			''
	END as 'KA-dato'
from request_event where note like ('Status endret til KA%')
and event_dttm > '2022-04-01'