SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.req_status                                       as 'Intern status',
       r.user_def2                                        as 'Telenorstatus',
       a.county_id                                        as 'Fylke',
       r.sales_grp_d                                      as 'Avdeling',
       r.req_class                                        as 'Ordretype',
       r.place_id                                         as 'TTP',
       r.cust_prob_descr								  as 'Beskrivelse',
       CONVERT(DATETIME2(0), r.created_dttm)              as 'Opprettet',
       CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
       CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist',
	   CONVERT(DATETIME2(0), mwf.dato_for_ok)             as 'Rettetstatus satt',
	   CONVERT(DATETIME2(0), ua.[UA dato])				  as 'UA dato',
	   CONVERT(DATETIME2(0), vk.[VK dato])				  as 'VK dato',
	   CONVERT(DATETIME2(0), ka.[KA dato])				  as 'KA dato',
	   CONVERT(DATETIME2(0), kad.[KA-dato])				  as 'Ny KA dato satt',
	   CONVERT(DATETIME2(0), travel.[Reise startet])	  as 'Reise startet',
	   CONVERT(DATETIME2(0), labor.[Arbeid startet])	  as 'Arbeid startet',
       r.severity                                         as 'Prioritet',
       t.person_id                                        as 'Oppgave ansvarlig',
       CONCAT(t_owner.first_name, ' ', t_owner.last_name) as 'Oppgave ansvarlig navn',
       rc.user_def3                                       as 'Kundenavn',
       rc.user_def24                                      as 'Kundeaddresse',
       rc.user_def14                                      as 'Postnummer',
       rc.user_def22                                      as 'Poststed',
       rc.mobile_phone                                    as 'Mobiltelefon',
       r.user_def17                                       as 'Ordre Eier',
       CONCAT(owner.first_name, ' ', owner.last_name)     as 'Ordre eier navn',
       ru.model_id                                        as 'Hovedprodukt',
       r.user_def6                                        AS 'IFS Nummer',
       r.req_type                                         as 'Type',
	   CASE
		WHEN ka.[KA dato] is null
			THEN CASE
				WHEN  re.orig_req_end_date > mwf.dato_for_ok
					THEN 1
					ELSE 0
				END
			ELSE CASE
				WHEN ka.[KA dato] > mwf.dato_for_ok
					THEN 1
					ELSE 0
			END
	   END												  as 'Leveringspresisjon',
	   antall_el.[Antall EL]							  as 'Antall EL',
	   CASE
		WHEN antall_el.[Antall EL] > 0
			THEN 1
			ELSE antall_el.[Antall EL]
	   END												  as 'Ordre med datoflytting',
	   CASE
		WHEN mwf.dato_for_ok is null
			THEN 0
			ELSE 1
	   END												  as 'Ordre levert'


FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id

         INNER JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         INNER JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def2, user_def3, user_def22, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (SELECT TOP 1 person_id FROM task WHERE task.request_id = r.request_id AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN', 'DOCUMENTATION') AND task_template_id not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN', 'DOCUMENTATION') ORDER BY task_id DESC) t
         LEFT JOIN person t_owner on t.person_id = t_owner.person_id
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
		 OUTER APPLY (SELECT top 1 ISNULL(last_event_dttm, log_created_dttm) as dato_for_ok from mwf_log where request_id = r.request_id and (external_status in ('RT', 'RM', 'OK', 'TRD', 'EXE', 'RU', 'IU', 'CAN', 'UF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Lukkemelding sendt', 'OK', 'Statusendring sendt')) order by mwf_log.sequence) mwf
		 OUTER APPLY (SELECT TOP 1 last_event_dttm as 'UA dato' from mwf_log where request_id = r.request_id and external_status in ('UA', 'WST') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) ua
         OUTER APPLY (SELECT TOP 1 last_event_dttm as 'VK dato' from mwf_log where request_id = r.request_id and external_status in ('VK', 'PCF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) vk
		 OUTER APPLY (SELECT TOP 1 last_event_dttm as 'KA dato' from mwf_log where request_id = r.request_id and external_status in ('KA', 'APP') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) ka
		 OUTER APPLY (Select top 1 work_dt as 'Reise startet' from non_part_usage where request_id = r.request_id and line_code = 'TRAVEL') travel
		 OUTER APPLY (Select top 1 work_dt as 'Arbeid startet' from non_part_usage where request_id = r.request_id and line_code = 'LABOR') labor
		 OUTER APPLY (SELECT count(last_event_dttm) as 'Antall EL' from mwf_log where request_id = r.request_id and external_status in ('EL') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) antall_el
		 OUTER APPLY (Select top 1 substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10)) AS 'KA-dato før konvertering',
				CASE
					WHEN
						isdate(substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10))) = 1
						THEN
							CAST(substring(rev.note, patindex('%sluttdato%', rev.note)+10, patindex('%.%', rev.note) - (patindex('%sluttdato%', rev.note)+10)) as DATETIME2)
						ELSE
							''
					END as 'KA-dato'
				from request_event rev where rev.note like ('Status endret til KA%') and rev.request_id = r.request_id ORDER by rev.event_dttm DESC) kad

WHERE r.req_class = 'MARIUS'
 AND r.created_dttm > '2022-03-01'