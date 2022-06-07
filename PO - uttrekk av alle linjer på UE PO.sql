select
po.pu_id,
po.request_id,
po.person_id,
po.part_id,
po.quantity,
po.part_id                               as 'Artikkelnummer',
pu.user_def4                                 as 'Artikkelnavn',
po.quantity                              as 'Antall',
pu.unit_price                             as 'Pris per',
pu.unit_price * pu.quantity                  as 'Totalt per linje',
subcon_price.price							as 'UE pris',
subcon_price.price * pu.quantity			as 'UE totalpris per linje',
po.note,
po.subcon,
po.subcon_approver,
po.subcon_po,
po.endret_dato,
po.req_type,
po.req_class,
po.place_id,
po.cross_reference,
po.Navn,
po.Gate,
po.Postnummer,
CONVERT(DATETIME2(0), po.linje_opprettet) as 'Linje opprettet'

from subcon_po_report po
inner join part_usage pu on po.pu_id = pu.pu_id
left join subcon_price ON subcon_price.part_id = pu.part_id

where po.subcon is not null
order by po.request_id asc