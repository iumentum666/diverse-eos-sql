select
rr.cross_reference,
r.request_id,
r.req_class,
CONVERT(DATE, r.created_dttm) as 'Opprettet dato',
rr.related_request_id,
rr.request_id,
r3.req_class

from related_requests rr
inner join request r on rr.cross_reference = r.cross_reference
inner join request r3 on rr.request_id = r3.request_id