select
p.part_id as 'Produktkode',
p.internal_descriptn as 'Navn',
isnull(tid.description, 0) as Tidsberegning

from part p
outer apply (
	select
	m.code_value,
	m.description
	from global_code_table m
	where p.part_id = m.code_value and m.code_name ='PRODUKTTID'
	) tid

where p.part_type = 'SERVICE'