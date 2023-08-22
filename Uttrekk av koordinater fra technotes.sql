select

r.request_id							as 'Arbeidsordre',
r.req_status							as 'Ordrestatus',
CONVERT(DATETIME2(0),r.created_dttm)	as 'Opprettet',
SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+13, 23) as Koordinater,

CONCAT('https://maps.google.com/?q=',
TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+15, 2) AS numeric) + (TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+18, 2) AS numeric) / 60) + ((TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+21, 2) AS numeric) / 60) / 60),
',',
TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+26, 3) AS numeric) + (TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+30, 2) AS numeric) / 60) + ((TRY_CAST(SUBSTRING(rt.text, PATINDEX('%Koordinater%', rt.text)+33, 2) AS numeric) / 60) / 60),
'&z=16') as 'Googlelink'

from request r
left join request_text rt on r.request_id = rt.request_id

  where r.created_dttm > '2023-01-01' and rt.text like '%Koordinater%' and rt.text_line_code = 'TECHNICALDATA' and r.req_status not in ('COMPLETE', 'CANCELED', 'CLOSED')