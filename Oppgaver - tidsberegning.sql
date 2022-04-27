use IFSFSMPROD

select
r.request_id,

r.req_class,
ru.model_id as 'Produkt',
ru.quantity as 'Antall',
ru.user_def_num1 as 'Tidsberegning produkt',
re.forventet_tidsbruk as 'Totaltid ordre'

from request r
left join request_unit ru on r.request_id = ru.request_id
left join request_ext re on r.request_id = re.request_id
where r.created_dttm > '2022-04-01' 
order by r.request_id asc