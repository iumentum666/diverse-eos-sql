with datoendringer AS ((SELECT
r.request_id,
'KA' AS 'status',
CASE WHEN r.req_class = 'CWM' THEN CAST(cwm_ka.[KA-dato] as date) ELSE cast(ka.[KA dato] as date) END as 'dato'

FROM request r

OUTER APPLY
	(
		select
		ml.last_event_dttm as 'KA dato'
		from mwf_log ml
		where ml.request_id = r.request_id
		and ml.external_status in ('KA', 'APP')
		and ml.note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt')
		and ml.last_event_dttm is not null
	) ka
OUTER APPLY
	(
		select
		re.created_dttm as 'KA-dato'
		from request_event re
		where re.request_id = r.request_id and re.event_type='MANUAL' and (re.note like ('%Status endret til APPOINTMENT, APPOINTED%') OR re.note like ('%Status endret til APPOINTMENT, POSTPONED%'))
	) cwm_ka

where r.created_dttm > '2023-01-01' and (cwm_ka.[KA-dato] is not null OR ka.[KA dato] is not null))

UNION

(SELECT
r.request_id,
'VK' AS 'status',
CASE WHEN r.req_class = 'CWM' THEN CAST(cwm_vk.[VK-dato] as date) ELSE CAST(vk.[VK dato] as date) END as 'dato'

FROM request r

OUTER APPLY
	(
		SELECT last_event_dttm as 'VK dato'
		from mwf_log
		where request_id = r.request_id
		and external_status in ('VK', 'PCF')
		and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt')
		and last_event_dttm is not null
	) vk
OUTER APPLY
	(
		SELECT
		re.created_dttm as 'VK-dato'
		from request_event re
		where re.request_id = r.request_id
		and re.event_type='MANUAL'
		and re.note like ('%Status endret til ON_HOLD, WAITING_CUSTOMER%')
	) cwm_vk

where r.created_dttm > '2023-01-01' and (cwm_vk.[VK-dato] is not null OR vk.[VK dato] is not null))

UNION

(SELECT
r.request_id,
'EL' AS 'status',
CASE WHEN r.req_class = 'CWM' THEN CAST(cwm_el.[EL dato] as date) ELSE CAST(el.[EL dato] as date) END as 'dato'

FROM request r

OUTER APPLY
	(
		SELECT
		last_event_dttm as 'EL dato'
		from mwf_log
		where request_id = r.request_id
		and external_status in ('EL')
		and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt')
		and last_event_dttm is not null
	) el

OUTER APPLY
	(
		select
		re.created_dttm as 'EL dato'
		from request_event re
		where re.request_id = r.request_id
		and re.event_type='MANUAL'
		and re.note like ('%Status endret til APPOINTMENT, DELAYED%')
	) cwm_el

where r.created_dttm > '2023-01-01' and (cwm_el.[EL dato] is not null OR el.[EL dato] is not null)))

SELECT
de.request_id				as 'EOS ordre',
de.status					as 'Status sendt',
de.dato						as 'Dato for endring',
r.cross_reference           as 'Eksternt ordrenummer',
r.req_status                as 'Intern status',
r.user_def2                 as 'Telenorstatus',
r.severity                  AS 'Prioritet',
a.county_id                 as 'Fylke',
r.sales_grp_d               as 'Avdeling',
r.req_type                  as 'Arbeidsordretype',
r.req_category              as 'Arbeidsordrekategori',
r.req_class                 as 'Ordretype',
re.ccm_purchasearea			as 'Avtaletype',
re.ccm_detailedpurchasearea	as 'Detaljert avtaletype',
r.req_group                 as 'Foresp.gruppe',
re.businesstype             as 'Forretningsområde',
r.place_id                  as 'TTP',
r.cust_prob_descr			as 'Beskrivelse',
CONVERT(DATETIME2(0), r.created_dttm)			  as 'Opprettet',
CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist'

from datoendringer de
inner join request r on r.request_id = de.request_id
LEFT JOIN request_ext re on de.request_id = re.request_id
LEFT JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
LEFT JOIN address a on pa.address_id = a.address_id
