SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.req_status                                       as 'Intern status',
       r.user_def2                                        as 'Telenorstatus',
       r.severity                                         AS 'Prioritet',
       a.county_id                                        as 'Fylke',
       r.sales_grp_d                                      as 'Avdeling',
       r.req_class                                        as 'Ordretype',
       r.cust_prob_descr								  as 'Beskrivelse',
       CONVERT(DATETIME2(0), r.created_dttm)              as 'Opprettet',
       CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
       CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist',
	   CONVERT(DATETIME2(0), mwf.dato_for_ok)             as 'Rettetstatus satt',
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
	   re.note											  as 'Reason/cause',
	   area_code.description							  as 'KMF Area',
	   det_net.description								  as 'KMF detailed net element',
	   kmf_cause.description							  as 'KMF Cause'

FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id

         INNER JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         INNER JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def2, user_def3, user_def22, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (SELECT TOP 1 person_id FROM task WHERE task.request_id = r.request_id AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN', 'DOCUMENTATION') AND task_template_id not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN', 'DOCUMENTATION', 'KORRIGERING AV FAKTURAGRUNNLAG') ORDER BY task_id DESC) t
         LEFT JOIN person t_owner on t.person_id = t_owner.person_id
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
		 OUTER APPLY (SELECT top 1 ISNULL(last_event_dttm, log_created_dttm) as dato_for_ok from mwf_log where request_id = r.request_id and (external_status in ('RT', 'RM', 'OK', 'TRD', 'EXE', 'RU', 'IU', 'CAN', 'UF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Lukkemelding sendt', 'OK', 'Statusendring sendt')) order by mwf_log.sequence) mwf
		 LEFT JOIN global_code_table area_code on re.kmf_area = area_code.code_value AND area_code.code_name = 'KMF_AREA'
		 LEFT JOIN global_code_table det_net on re.kmf_det_net_el = det_net.code_value AND det_net.code_name = 'KMF_DET_NET_EL'
		 LEFT JOIN global_code_table kmf_cause on re.kmf_cause = kmf_cause.code_value AND kmf_cause.code_name = 'KMF_CAUSE'


WHERE r.created_dttm > '2022-08-01' and ru.model_id = 'DS09' and r.req_class = 'KMF'