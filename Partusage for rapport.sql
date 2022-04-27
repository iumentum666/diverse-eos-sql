SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.req_status                                       as 'Intern status',
       r.user_def2                                        as 'Telenorstatus',
	   a.county_id                                        as 'Fylke',
       r.sales_grp_d                                      as 'Avdeling',
       r.req_class                                        as 'Ordretype',
       r.place_id                                         as 'TTP',
       rc.user_def2										  as 'CDK-kundenummer',
       r.cust_prob_descr								  as 'Beskrivelse',
	   CONVERT(DATETIME2(0), r.created_dttm)			  as 'Opprettet',
       CONVERT(DATETIME2(0), re.required_end_date)        as 'Rettefrist',
       CONVERT(DATETIME2(0), re.orig_req_end_date)        as 'Opprinnelig rettefrist',
	   CASE WHEN r.req_class in ('Telia FWA', 'AEG') then CONVERT(DATETIME2(0), ordre.[Ordre fullført])
			ELSE CONVERT(DATETIME2(0), mwf.dato_for_ok)	END	as 'Rettetstatus satt',
	   CONVERT(DATETIME2(0), ua.[UA dato])				  as 'UA dato',
	   CONVERT(DATETIME2(0), vk.[VK dato])				  as 'VK dato',
	   CONVERT(DATETIME2(0), travel.[Reise startet])	  as 'Reise startet',
	   CONVERT(DATETIME2(0), labor.[Arbeid startet])	  as 'Arbeid startet',   
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
	   CASE WHEN CAST(mw.log_created_dttm-r.modified_dttm as DATETIMEOFFSET) BETWEEN '1899-12-31 23:59:59'
           AND '1900-01-01 00:00:01'
           AND mw.last_event_dttm IS NULL
       THEN 'ENDRING' ELSE NULL END as 'Endring',
	   re.cdk_close_reason_faulthandling				  as 'CDK f-kode',
	   pu.part_id										  as 'Artikkelnummer',
	   pu.user_def4										  as 'Artikkelnavn',
	   pu.quantity										  as 'Antall',
	   pu.unit_price									  as 'Pris per',
	   pu.unit_price * pu.quantity						  as 'Totalt per linje',
	   psummert.total									  as 'Total pr ordre'


FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id
		 OUTER APPLY (SELECT top 1 ISNULL(last_event_dttm, log_created_dttm) as dato_for_ok from mwf_log where request_id = r.request_id and (external_status in ('RT', 'RM', 'OK', 'TRD', 'EXE', 'RU', 'IU', 'CAN', 'UF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Lukkemelding sendt', 'OK')) ) mwf
		 OUTER APPLY (select top 1 re.event_dttm as 'Ordre fullført', re.request_id as 'Ordre',	re.note as 'Note' from request_event re	where event_type in ('COMPLT','CANCEL') and re.note is null and r.request_id = re.request_id and r.req_status in ('COMPLETE', 'CANCELED', 'CLOSED')	order by re.sequence desc) ordre 
		 OUTER APPLY (SELECT TOP 1 last_event_dttm as 'UA dato' from mwf_log where request_id = r.request_id and external_status in ('UA', 'WST') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) ua
         OUTER APPLY (Select top 1 work_dt as 'Reise startet' from non_part_usage where request_id = r.request_id and line_code = 'TRAVEL') travel
		 OUTER APPLY (Select top 1 work_dt as 'Arbeid startet' from non_part_usage where request_id = r.request_id and line_code = 'LABOR') labor
		 LEFT JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         LEFT JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def2, user_def3, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
         OUTER APPLY (SELECT TOP 1 last_event_dttm as 'VK dato' from mwf_log where request_id = r.request_id and external_status in ('VK', 'PCF') and note in ('E305 Operasjon vellykket.', 'Ok', 'OK - Status Changed', 'Statusendring sendt') and last_event_dttm is not null) vk
         OUTER APPLY (SELECT TOP 1 person_id FROM task WHERE task.request_id = r.request_id AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN') ORDER BY task_id DESC) t
         LEFT JOIN person t_owner on t.person_id = t_owner.person_id
		 left join part_usage pu on pu.request_id = r.request_id
		 OUTER APPLY (
			SELECT 
				psum.request_id, 
				sum(psum.unit_price * psum.quantity) as total 
				from part_usage psum 
			where r.request_id = psum.request_id 
			group by psum.request_id
		) psummert

WHERE r.req_status IN ('COMPLETE', 'CANCELED', 'CLOSED')
  AND r.created_dttm > DateAdd(d, -60, GetDate())