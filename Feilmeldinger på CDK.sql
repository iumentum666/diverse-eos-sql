SELECT a.county_id                               AS 'Fylke',
       r.sales_grp_d                             AS 'Avdeling',
       r.request_id                              AS 'Ordre ID',
       r.req_class                               AS 'Ordre type',
       r.severity                                AS 'Prioritet',
       r.user_def17                              AS 'Ordre eier',
       r.cross_reference                         AS 'Ekstern ID',
       r.user_def2                               AS 'TN Status',

       l.note                                    AS 'Melding',
       CONVERT(DATETIME2(0), l.log_created_dttm) AS 'Timestamp'

FROM request r

     CROSS APPLY (SELECT TOP 1
           external_status,
           note,
           log_created_dttm,
           last_event_dttm,
		   in_out,
           sequence

                      FROM mwf_log mw
                     WHERE mw.request_id = r.request_id

                     ORDER BY mw.sequence DESC) l
       INNER JOIN place_address pa ON r.place_id = pa.place_id AND pa.address_type = 'DEFAULT'
       LEFT JOIN address a ON pa.address_id = a.address_id

 WHERE r.req_class in ('CRI', 'NRI', 'WRI', 'OPN', 'CLS')
 AND l.note NOT in ('OK - Status Changed', 'OK', 'Annulert av Telenor', 'Annulert av Telenor OK')
 AND l.note NOT LIKE ('% from state Closed')
 AND l.note NOT LIKE 'Oppdatert av EOS OPS %'
 AND l.in_out = 'IN'