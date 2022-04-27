SELECT r.request_id                                       as 'Ordre ID',
       r.cross_reference                                  as 'Eksternt ordrenummer',
       r.user_def6                                        AS 'IFS Nummer',
	   r.req_class											as 'Ordretype',
       r.req_status                                       as 'Intern status',
	   r.user_def2											as 'Ekstern status',
	   CONVERT(DATETIME2(0), ordre.[Ordre fullført])	  as 'Ordre fullført',
	   CONVERT(DATETIME2(0), r.created_dttm)				as 'Ordre opprettet',
       a.county_id                                        as 'Fylke',
	   a.zippost										  as 'Postnummer',
	   a.city											  as 'Poststed',
       r.sales_grp_d                                      as 'Avdeling',
       r.cust_prob_descr								  as 'Beskrivelse',
       r.user_def17                                       as 'Ordre Eier',
       CONCAT(owner.first_name, ' ', owner.last_name)     as 'Ordre eier navn',
       ru.model_id                                        as 'Hovedprodukt',
	   pu.part_id										  as 'Produkt',
	   pu.quantity										  as 'Antall'


FROM request r

         LEFT JOIN request_ext re on r.request_id = re.request_id

         INNER JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
         INNER JOIN address a on pa.address_id = a.address_id
         LEFT JOIN person owner on owner.person_id = r.user_def17

         OUTER APPLY (SELECT TOP 1 model_id FROM request_unit WHERE request_unit.request_id = r.request_id) ru
         OUTER APPLY (SELECT TOP 1 user_def3, user_def24, user_def14, mobile_phone FROM request_contact WHERE request_contact.request_id = r.request_id) rc
         OUTER APPLY (
			SELECT TOP 1 
			person_id, 
			task_id, 
			task_type, 
			task_status, 
			user_def2, 
			user_def15 
			FROM task 
			WHERE task.request_id = r.request_id 
			AND task_type not in ('PRE_DOC', 'INVOICING', 'ENRICH AND ASSIGN') 
			ORDER BY task_id DESC
			) t
         OUTER APPLY (
			select top 1 event_type from task_event where task_id = t.task_id and event_type in ('BOOKED','COMMITTED')) te
		 
		 LEFT JOIN person t_owner on t.person_id = t_owner.person_id
         OUTER APPLY (SELECT TOP 1 log_created_dttm, note, last_event_dttm from mwf_log where mwf_log.request_id = r.request_id and in_out = 'IN' order by sequence desc) mw
		 left join part_usage pu on r.request_id = pu.request_id


outer apply (
	select top 1 
	re.event_dttm as 'Ordre fullført',
	re.request_id as 'Ordre',
	re.note as 'Note'
	from request_event re
	where event_type in ('COMPLT','CANCEL') and re.note is null and r.request_id = re.request_id and r.req_status in ('COMPLETE', 'CANCELED')
	order by re.sequence desc
) ordre 



WHERE r.req_class in ('CRI','NRI') and r.created_dttm >= '2021-12-01' and r.created_dttm < '2022-01-01'