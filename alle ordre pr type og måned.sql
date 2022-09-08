select
count(r.request_id) as 'antall ordre',
r.req_class,
r.req_category,
month(r.created_dttm) as 'Måned',
year(r.created_dttm) as 'år'


from request r
group by r.req_class, r.req_category, year(r.created_dttm), month(r.created_dttm)
order by year(r.created_dttm), month(r.created_dttm) asc