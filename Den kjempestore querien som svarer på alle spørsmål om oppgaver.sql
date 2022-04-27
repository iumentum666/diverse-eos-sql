SELECT 
	t.task_id										AS Oppgavenummer,
	t.task_template_id								AS Oppgavetype,
	re.master_model_id								AS Hovedprodukt,
	pt.internal_descriptn							AS Produktnavn,
	r.req_class										AS TypeFeil,
	r.sales_grp_d									AS 'Avdeling',
	t.person_id										AS Oppgaveeier,
	CONCAT (
		p.first_name
		,' '
		,p.last_name
		)											AS 'Navn',
	p.user_def12									AS 'Avdeling på person',
	iif(isnumeric(p.user_def12)=0 and p.user_def12 not in ('20075 - FTTB', '20075 - FTTH'),'UE','Intern') as 'Intern/UE',
	CONVERT(DATETIME2(0), t.created_dttm)			AS 'Oppgave opprettet',
	CONVERT(DATETIME2(0), isnull(t.actual_end_dttm, t.created_dttm)) AS 'Oppgave fullført',
	a.zippost										AS Postnummer,
	t.user_def2										AS 'Fullføringsgrunn',
	t.user_def15									AS 'Beskrivelse',
	r.req_status									AS 'Arbeidsordrestatus',
	r.user_def2										AS 'TN Status',
	CONVERT(DATETIME2(0), rt.[TN-fullførtstatus])   as 'Rettetstatus satt',
	rt.[Person sendt fullførstatus]					as 'Person som sendte rettestatus',
	CONVERT(DATETIME2(0), ua.[UA dato])				as 'UA dato',
	ua.[Person sendt UA]							as 'Person sendt UA',
	CONVERT(DATETIME2(0), vk.[VK dato])				as 'VK dato',
	vk.[Person sendt VK]							as 'Person sendt VK',
	CONVERT(DATETIME2(0), ka.[KA dato])				as 'KA dato',
	ka.[Person sendt KA]							as 'Person sendt KA',
	CONVERT(DATETIME2(0), tildelt.Tildelttidspunkt) as 'Commited-tidspunkt',
	tildelt.Tildeltperson							as 'Person commited',
	CONVERT(DATETIME2(0), lukket.Lukketidspunkt)	as 'Lukket oppgaven-tidspunkt',
	lukket.Lukkeperson								as 'Person lukket oppgaven',
	isnull(travel.Lengde, 0)						as Reise,
	travel.Reise_person								as 'Person Reise',
	isnull(labor.lengde, 0)							as Arbeid,
	labor.Arbeid_Person								as 'Person arbeid',
	IIF(re.master_model_id IN (
			'DT01'
			,'DT01K'
			,'DT01S'
			,'DT02'
			,'DS05'
			,'DS99'
			,'DS100'
			,'DM03A'
			,'DM03B'
			,'DM03E'
			,'DM03F'
			,'DM04A'
			,'DM04B'
			,'DM04D'
			,'DT62'
			,'DT63'
			,'DT65A'
			,'DT65B'
			,'DS37'
			,'DS32A'
			,'DS32B'
			,'DS38'
			,'DT12'
			,'DT05'
			,'DT03'
			,'DT05S'
			,'DT05X'
			,'DT06'
			,'DT07'
			,'DT09'
			,'DT10'
			,'DT10A'
			,'DT10B'
			,'DT15'
			,'DT16'
			,'DT17'
			,'DS07'
			,'DS17'
			,'DM03D'
			,'DM03C'
			,'DM04C'
			,'DT21'
			)
		OR re.master_model_id LIKE 'DT5%'
		OR re.master_model_id LIKE 'DP%'
		OR re.master_model_id LIKE 'DT23%'
		OR re.master_model_id LIKE 'DT21%'
		OR re.master_model_id LIKE 'DT13%'
		OR re.master_model_id LIKE 'DT40%', 'Ja', 'Nei') AS 'Unntatt produkt',
	IIF((
			t.user_def2 IN (
				'IFBERIK'
				,'IFFAKT'
				)
			OR
				r.req_status IN ('CANCELED')
		)
			AND (
				isnull(travel.Lengde, 0) <= '0,02'
				AND isnull(Labor.Lengde, 0) <= '0,02'
				)
			
		, 'Ja', 'Nei') AS 'Unntatt ikke utført'
FROM task t

LEFT JOIN (
	SELECT top 1 
	t.task_id AS oppgavenummer,
	np.created_by as Reise_person
		,cast(format(sum(np.quantity), 'N', 'de-de') AS VARCHAR(20)) AS Lengde
	FROM task t
	LEFT JOIN non_part_usage np ON t.task_id = np.task_id
	WHERE np.line_code = 'TRAVEL'
	GROUP BY t.task_id, np.created_by
	) travel ON t.task_id = travel.oppgavenummer

LEFT JOIN (
	SELECT top 1
	t.task_id AS oppgavenummer,
	np.created_by as Arbeid_Person
		,cast(format(sum(np.quantity), 'N', 'de-de') AS VARCHAR(20)) AS Lengde
	FROM task t
	LEFT JOIN non_part_usage np ON t.task_id = np.task_id
	WHERE np.line_code = 'LABOR'
	GROUP BY t.task_id, np.created_by
	) labor ON t.task_id = labor.oppgavenummer

LEFT JOIN request r ON t.request_id = r.request_id
LEFT JOIN request_ext re ON t.request_id = re.request_id
LEFT JOIN person p ON p.person_id = t.person_id
LEFT JOIN place_address pa ON r.place_id = pa.place_id
	AND pa.address_type = 'DEFAULT'
LEFT JOIN address a ON pa.address_id = a.address_id
LEFT JOIN part pt ON pt.part_id = re.master_model_id

outer apply (
	select top 1 
	te.event_dttm as 'Lukketidspunkt',
	te.created_by as 'Lukkeperson'
	from task_event te where te.task_id = t.task_id and event_type = 'COMPLT'
	order by te.event_sequence asc
) lukket

outer apply (
	select top 1 
	te.event_dttm as 'Tildelttidspunkt',
	te.created_by as 'Tildeltperson'
	from task_event te where te.task_id = t.task_id and event_type = 'COMMITTED'
	order by te.event_sequence asc
) tildelt

OUTER APPLY (
	SELECT top 1
	event_dttm as 'TN-fullførtstatus',
	created_by as 'Person sendt fullførstatus'
	from request_event
	where request_id = r.request_id and (note like 'Status endret til OK av%' or note like 'Status endret til EXE av%' or note like 'Status endret til RT av%' or note like 'Status endret til UF av%' or note like 'Status endret til RU av%' or note like 'Status endret til IU av%' or note like 'Status endret til CAN av%')
	order by sequence desc
	) rt

OUTER APPLY (
	SELECT top 1
	event_dttm as 'UA dato',
	created_by as 'Person sendt UA'
	from request_event
	where request_id = r.request_id and (note like 'Status endret til UA av%' or note like 'Status endret til WST av%')
	order by sequence desc
	) ua

OUTER APPLY (
	SELECT top 1
	event_dttm as 'VK dato',
	created_by as 'Person sendt VK'
	from request_event
	where request_id = r.request_id and (note like 'Status endret til VK av%' or note like 'Status endret til PCF av%')
	order by sequence desc
	) vk

OUTER APPLY (
	SELECT top 1
	event_dttm as 'KA dato',
	created_by as 'Person sendt KA'
	from request_event
	where request_id = r.request_id and (note like 'Status endret til KA av%' or note like 'Status endret til APP av%')
	order by sequence desc
	) ka

WHERE t.created_dttm >= '2021-09-01'
	AND NOT t.task_template_id IN (
		'ENRICH AND ASSIGN'
		,'CABLE PLANNING'
		,'DOCUMENTATION'
		,'INVOICING'
		,'ENRICH TASK WRONGLY COMPLETED'
		,'ENRICH_AND_ASSIGN_TECH'
		,'PRE_DOC'
		,'FELLESFØRING'
		,'ORDER DIGGING OR LIFT'
		,'DIGGING NEEDED'
		)
	AND t.task_status = 'COMPLETED'

ORDER BY t.created_dttm ASC