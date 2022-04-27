SELECT 
	re.request_id,
    re.event_type,
	CONVERT(DATETIME2(0),re.event_dttm) as 'Dato for endring',
	CONVERT(DATETIME2(0),r.orig_req_end_date) as 'Opprinnelig rettetid',
    re.description,
    re.note,
	CONVERT(DATETIME2(0),
		CASE WHEN len(REPLACE(REPLACE(re.note, ' Endret av METRIX', ''), 'Rettetid endret: Ny rettetid ', '')) > 21 THEN 
				substring(
					REPLACE(re.note, 'Rettetid endret: Ny rettetid ', ''),1, 
						(PATINDEX('% Endret av %', REPLACE(re.note, 'Rettetid endret: Ny rettetid ', ''))
						)
					)
			ELSE REPLACE(REPLACE(re.note, ' Endret av METRIX', ''), 'Rettetid endret: Ny rettetid ', '')
		END
	) 
	AS 'Ny rettetid'

  FROM request_event re
  left join request_ext r on re.request_id = r.request_id

 where re.description = 'RETTETID'
and re.event_dttm >= '2021-08-01'
 and re.note not like ('Rettetid lagt til.%')
 and r.request_id like [1]