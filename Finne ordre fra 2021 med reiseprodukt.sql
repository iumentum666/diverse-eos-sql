use IFSFSMPROD

select
a.county_id										AS 'Fylke',
r.sales_grp_d									AS 'Avdeling',
r.request_id									as Ordrenummer,
r.cross_reference								as 'TN ordrenummer',
r.req_class										as Ordretype,
re.master_model_id								as Hovedprodukt,
CONVERT(DATETIME2(0), re.orig_req_end_date)		as RTL,
CONVERT(DATETIME2(0), r.created_dttm)			as Opprettet,
rp.reiseprodukt									as reiseprodukt

from request r
left join request_ext re on r.request_id = re.request_id
INNER JOIN place_address pa ON r.place_id = pa.place_id AND pa.address_type = 'DEFAULT'
LEFT JOIN address a ON pa.address_id = a.address_id


left join
	(select
	pu.part_id						as reiseprodukt,
	pu.request_id					as ordre
	from part_usage pu
	where pu.part_id Like ('DR71%')	or pu.part_id like ('DR74%') or pu.part_id like ('LR02%') or pu.part_id in ('DR01', 'LR01')
	) rp on r.request_id = rp.ordre

where r.created_dttm >= '2021-01-01' and re.master_model_id not in ('LVR03') -- LVR03 er garanti, og skal ikke ha reiseprodukt