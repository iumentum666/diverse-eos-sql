select
npu.npu_id,
npu.request_id,
npu.comments,
npu.description,
npu.person_id,
npu.task_id,
npu.quantity,
npu.work_dt
from non_part_usage npu
where npu.comments is not null
and npu.work_dt > '2022-01-01'


-- Under viser den bare linjer som har predefinerte kommentarer fra fakturateamet
select
npu.request_id				as 'Request ID',
r.sales_grp_d				as 'Avdelingsnummer',
a.county_id					as 'Fylke',
npu.comments				as 'Kommentarer',
npu.quantity				as 'Antall timer',
npu.description				as 'Beskrivelse fra timeføring',
npu.person_id				as 'Person tiden er registrert på',
p.first_name				as 'Fornavn',
p.last_name					as 'Etternavn',
npu.task_id					as 'Oppgaven tiden er registrert på',
CAST(npu.work_dt as Date)	as 'Dato registrert'



from non_part_usage npu
inner join person p on p.person_id = npu.person_id
inner join request r on npu.request_id = r.request_id
left join place_address pa on r.place_id = pa.place_id
left join address a on pa.address_id = a.address_id


where npu.comments in ('Purring oppgave avdeling','Purring telefon montør','Samtale med kunde','Samtale med montør','Arbeid med ordre','Dokumentasjon')
and npu.work_dt > '2022-01-01'