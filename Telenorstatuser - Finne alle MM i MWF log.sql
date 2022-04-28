select
ml.external_status,
ml.log_created_by,
ml.owner,
ml.req_status,
ml.request_id,
CONVERT(DATETIME2(0), ml.created_dttm) as 'Logg opprettet dato',
ml.log_note,
r.req_class,
r.req_type,
CONVERT(DATETIME2(0), r.created_dttm) as 'Ordre opprettet dato'


from mwf_log ml
left join request r on r.request_id = ml.request_id
where  external_status = 'MM'
and ml.created_dttm >= '2022-04-18'