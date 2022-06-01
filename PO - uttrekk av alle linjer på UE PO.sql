select
pu_id,
request_id,
person_id,
part_id,
quantity,
note,
subcon,
subcon_approver,
subcon_po,
endret_dato,
req_type,
req_class,
place_id,
cross_reference,
Navn,
Gate,
Postnummer,
CONVERT(DATETIME2(0), linje_opprettet) as 'Linje opprettet'

from subcon_po_report
where subcon is not null