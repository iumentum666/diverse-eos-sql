select
r.request_id										AS 'Ordre ID',
a.county_id											AS 'Fylke',
r.user_def17										AS 'Ordre eier',
CONCAT(r_owner.first_name, ' ', r_owner.last_name)	AS 'Ordre eier navn',
r.req_status										AS 'Ordre status',
r.user_def2											AS 'Ekstern status',
r.req_class											AS 'Ordretype',
sum(npu.quantity)										AS 'Tid ført på oppgave',
npu.person_id										AS 'PersonID som førte tiden',
CONCAT(p.first_name, ' ', p.last_name)				AS 'Navn som  førte tiden',
p.user_def12										AS 'Avdeling på person som førte tiden'
from non_part_usage npu
left join person p on p.person_id = npu.person_id
left join request r on npu.request_id = r.request_id
         INNER JOIN place_address pa ON pa.place_id = r.place_id AND address_type = 'DEFAULT'
         LEFT JOIN address a ON pa.address_id = a.address_id
         LEFT JOIN person r_owner ON r.user_def17 = r_owner.person_id
where p.user_def12 = '20139' and npu.created_dttm > '2022-01-01'
group by r.request_id, a.county_id, r.user_def17, r_owner.first_name, r_owner.last_name, r.req_status, r.user_def2, r.req_class, npu.person_id, p.first_name, p.last_name, p.user_def12