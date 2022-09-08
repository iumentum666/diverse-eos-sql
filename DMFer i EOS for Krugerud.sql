SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.req_status                                       as 'Intern status',
       r.user_def2                                        as 'Telenorstatus',
       r.severity                                         AS 'Prioritet',
	   a.county_id                                        as 'Fylke',
       r.sales_grp_d                                      as 'Avdeling',
       r.req_class                                        as 'Ordretype',
	   r.req_category									  as 'Kategoritet',
	   r.req_group										  as 'Gruppe',
	   r.req_type										  as 'Type',
       r.place_id                                         as 'TTP',
       r.cust_prob_descr								  as 'Beskrivelse',
	   CONVERT(DATETIME2(0), r.created_dttm)			  as 'Opprettet',
       CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
       CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist',
	   CASE WHEN r.req_class in ('Telia FWA', 'AEG') then CONVERT(DATETIME2(0), ordre.[Ordre fullført])
			ELSE CONVERT(DATETIME2(0), mwf.dato_for_ok)	END	as 'Rettetstatus satt',
       r.severity                                         as 'Prioritet',
       t.person_id                                        as 'Oppgave ansvarlig',
       CONCAT(t_owner.first_name, ' ', t_owner.last_name) as 'Oppgave ansvarlig navn',
       rc.user_def3                                       as 'Kundenavn',
       rc.user_def24                                      as 'Kundeaddresse',
       rc.user_def14                                      as 'Postnummer',
       rc.mobile_phone                                    as 'Mobiltelefon',
       r.user_def17                                       as 'Ordre Eier',
       CONCAT(owner.first_name, ' ', owner.last_name)     as 'Ordre eier navn',
       ru.model_id                                        as 'Hovedprodukt',
       r.user_def6                                        AS 'IFS Nummer',
       r.req_type                                         as 'Type'



FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id
		 OUTER APPLY (SELECT top 1 ISNULL(last_event_dttm, log_created_dttm) as dato_for_ok from mwf_log where request_id = r.request_id and (external_status in ('RT', 'RM', 'OK', 'TRD', 'EXE', 'RU', 'IU', 'CAN', 'UF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Lukkemelding sendt', 'OK', 'Statusendring sendt')) order by mwf_log.sequence) mwf
		 OUTER APPLY (select top 1 re.event_dttm as 'Ordre fullført', re.request_id as 'Ordre',	re.note as 'Note' from request_event re	where event_type in ('COMPLT','CANCEL') and re.note is null and r.request_id = re.request_id and r.req_status in ('COMPLETE', 'CANCELED', 'CLOSED')	order by re.sequence desc) ordre
		 LEFT JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         LEFT JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def2, user_def3, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
         OUTER APPLY (SELECT TOP 1 person_id FROM task WHERE task.request_id = r.request_id AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN') ORDER BY task_id DESC) t
         LEFT JOIN person t_owner on t.person_id = t_owner.person_id


WHERE r.created_dttm > '2019-01-01' and r.req_class = 'DMF'




SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.req_status                                       as 'Intern status',
       r.user_def2                                        as 'Telenorstatus',
       r.severity                                         AS 'Prioritet',
	   a.county_id                                        as 'Fylke',
       r.sales_grp_d                                      as 'Avdeling',
       r.req_class                                        as 'Ordretype',
	   r.req_category									  as 'Kategoritet',
	   r.req_group										  as 'Gruppe',
	   r.req_type										  as 'Type',
       r.place_id                                         as 'TTP',
       r.cust_prob_descr								  as 'Beskrivelse',
	   CONVERT(DATETIME2(0), r.created_dttm)			  as 'Opprettet',
       CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
       CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist',
	   CASE WHEN r.req_class in ('Telia FWA', 'AEG') then CONVERT(DATETIME2(0), ordre.[Ordre fullført])
			ELSE CONVERT(DATETIME2(0), mwf.dato_for_ok)	END	as 'Rettetstatus satt',
       r.severity                                         as 'Prioritet',
       t.person_id                                        as 'Oppgave ansvarlig',
       CONCAT(t_owner.first_name, ' ', t_owner.last_name) as 'Oppgave ansvarlig navn',
       rc.user_def3                                       as 'Kundenavn',
       rc.user_def24                                      as 'Kundeaddresse',
       rc.user_def14                                      as 'Postnummer',
       rc.mobile_phone                                    as 'Mobiltelefon',
       r.user_def17                                       as 'Ordre Eier',
       CONCAT(owner.first_name, ' ', owner.last_name)     as 'Ordre eier navn',
       ru.model_id                                        as 'Hovedprodukt',
       r.user_def6                                        AS 'IFS Nummer',
       r.req_type                                         as 'Type',
	   pu.part_id										  as 'Artikkelnummer',
	   pu.user_def4										  as 'Artikkelnavn',
	   pu.quantity										  as 'Antall',
	   pu.note                                             AS 'Notat på fakturalinje',
	   pu.USER_DEF1                                             AS 'Signatur',
       CASE WHEN part_line_code = 'IN'  THEN 'Fakturerbar'
            WHEN part_line_code = 'INV' THEN 'Fakturert'
                                        ELSE part_line_code END AS 'Fakturastatus',
	   pu.user_def2												AS 'PO',
	   pu.user_def9												AS 'CREF',
	   CONVERT(DATE, pu.user_def_dttm1)                         AS 'Faktureringsdato'



FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id
		 OUTER APPLY (SELECT top 1 ISNULL(last_event_dttm, log_created_dttm) as dato_for_ok from mwf_log where request_id = r.request_id and (external_status in ('RT', 'RM', 'OK', 'TRD', 'EXE', 'RU', 'IU', 'CAN', 'UF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Lukkemelding sendt', 'OK', 'Statusendring sendt')) order by mwf_log.sequence) mwf
		 OUTER APPLY (select top 1 re.event_dttm as 'Ordre fullført', re.request_id as 'Ordre',	re.note as 'Note' from request_event re	where event_type in ('COMPLT','CANCEL') and re.note is null and r.request_id = re.request_id and r.req_status in ('COMPLETE', 'CANCELED', 'CLOSED')	order by re.sequence desc) ordre
		 LEFT JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         LEFT JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def2, user_def3, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
         OUTER APPLY (SELECT TOP 1 person_id FROM task WHERE task.request_id = r.request_id AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN') ORDER BY task_id DESC) t
         LEFT JOIN person t_owner on t.person_id = t_owner.person_id
		 left join part_usage pu on pu.request_id = r.request_id


WHERE pu.part_id = 'DT62'
  AND r.created_dttm > '2019-01-01'