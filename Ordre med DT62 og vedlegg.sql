select
r.request_id                                       as 'Ordre ID',
r.cross_reference                                  as 'Eksternt ordrenummer',
r.req_status                                       as 'Intern status',
r.user_def2                                        as 'Telenorstatus',
r.severity                                         AS 'Prioritet',
r.sales_grp_d                                      as 'Avdeling',
r.req_class                                        as 'Ordretype',
r.place_id                                         as 'TTP',
r.cust_prob_descr								  as 'Beskrivelse',
CONVERT(DATETIME2(0), r.created_dttm)			  as 'Opprettet',
pu.part_id										  as 'Artikkelnummer',
pu.user_def4										  as 'Artikkelnavn',
at.attachment_id,
at.attachment_name,
at.attachment_description,
at.file_extension

from request r

outer apply (
select pu.part_id, pu.user_def4
from part_usage pu where r.request_id = pu.request_id group by pu.part_id, pu.user_def4) pu

outer apply (
	select
		attach.attachment_id,
		attach.attachment_name,
		attach.attachment_description,
		attach.file_extension
		from attachment attach
		inner join request_attachment at on at.attachment_id = attach.attachment_id
		where attach.file_extension not in ('xml', 'xlsx', 'txt', 'pdf', '.xlsx', '.pdf')
		and attach.attachment_description not in ('Kundens signatur', 'Customer Signature', 'egenkontrollskjema')
		and at.request_id = r.request_id) at

WHERE pu.part_id = 'DT62'
  AND r.created_dttm > '2022-01-01' --and  r.sales_grp_d in ('20059', '20061')