SELECT
pue.pu_id,
r.request_id,
pu.person_id,
pu.note,
pue.subcon,
pue.subcon_approver,
pue.subcon_po,
CONVERT(DATETIME2(0), pue.endret_dato)				AS 'Endret dato',
r.req_type,
r.req_class,
r.place_id,
r.cross_reference,
rc.user_def3                                             AS 'Kundenavn',
rc.user_def24                                            AS 'Kundeaddresse',
rc.user_def14                                            as 'Postnummer',
rc.user_def22											as 'Poststed',
CONVERT(DATETIME2(0), pu.created_dttm) AS linje_opprettet,
pu.part_id AS part_id,
CONVERT(decimal(38, 2), pu.quantity) AS quantity,
pu.unit_price                             as 'Pris per',
pu.unit_price * pu.quantity               as 'Totalt per linje',
subcon_price.price							as 'UE pris',
subcon_price.price * pu.quantity			as 'UE totalpris per linje'

FROM part_usage pu

INNER JOIN part_usage_ext pue ON pu.pu_id = pue.pu_id

INNER JOIN request r ON pu.request_id = r.request_id

OUTER APPLY (SELECT TOP 1 user_def3, user_def24, user_def14, user_def22 FROM request_contact WHERE request_contact.request_id = r.request_id) rc

LEFT OUTER JOIN subcon_price ON subcon_price.part_id = pu.part_id --WHERE request_id = pue.related_request_id


where pue.subcon is not null
order by r.request_id asc