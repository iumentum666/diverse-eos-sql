select
count(request_id) as 'Antall ordre',
req_class as 'Ordrertype',
sales_grp_d as 'Avdeling',
CAST(created_dttm as Date) as 'Dato'

from request r where created_dttm >= '2022-01-01'
group by CAST(created_dttm as Date), req_class, sales_grp_d
order by CAST(created_dttm as Date), sales_grp_d asc