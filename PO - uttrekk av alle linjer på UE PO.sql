SELECT
r.request_id                                        AS 'EOS ordre',
r.cross_reference	                                AS 'Eksternt ordrenummer',
r.user_def6											AS 'IFS Nummer',
a.county_id                                         AS 'Fylke',
r.sales_grp_d                                       AS 'Avdeling',
r.req_class                                         AS 'Ordretype',
rc.user_def3                                        AS 'Kundenavn',
rc.user_def24                                       AS 'Kundeaddresse',
rc.user_def14                                       AS 'Postnummer',
rc.user_def22									    AS 'Poststed',
pu.part_id			                                AS 'Produkt/material',
CONVERT(decimal(38, 2), pu.quantity)                AS 'Antall',
pu.person_id                                        AS 'Person som lagde fakturalinje',
pu.note                                             AS 'Notat på fakturalinje',
CONVERT(DATETIME2(0), pu.created_dttm)              AS 'Fakturalinje opprettet',
pue.subcon                                          AS 'UE Navn',
pue.subcon_approver                                 AS 'Person som godkjente linje hos UE',
pue.subcon_po                                       AS 'UE sitt POnr',
pu.unit_price                                       AS 'Pris per',
pu.unit_price * pu.quantity                         AS 'Totalt per linje',
subcon_price.price							        AS 'UE pris',
subcon_price.price * pu.quantity			        AS 'UE totalpris per linje'

FROM part_usage pu

INNER JOIN part_usage_ext pue ON pu.pu_id = pue.pu_id

INNER JOIN request r ON pu.request_id = r.request_id

OUTER APPLY (SELECT TOP 1 user_def3, user_def24, user_def14, user_def22 FROM request_contact WHERE request_contact.request_id = r.request_id) rc

LEFT OUTER JOIN subcon_price ON subcon_price.part_id = pu.part_id --WHERE request_id = pue.related_request_id

INNER JOIN place_address pa on r.place_id = pa.place_id and pa.address_type = 'DEFAULT'
INNER JOIN address a on pa.address_id = a.address_id

where pue.subcon is not null
order by r.request_id asc