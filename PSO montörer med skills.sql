Select 
p.person_id				as 'Bruker',
p.first_name			as 'Fornavn',
p.last_name				as 'Etternavn',
p.job_title				as 'Tittel',
p.user_def12			as 'Avdeling på bruker',
CASE
	when p.metrix_user_type = 'NAMED' then 'Backoffice'
	when p.metrix_user_type = 'MOBILE' then 'Mobil'
	else p.metrix_user_type
	end
	as 'Type tilgang',
tr.resource_id			as 'PSO bruker',
ps.skill				as 'Skill'

from person p
left join threesixty_resource tr on p.person_id = tr.parent_key
left join person_skill ps on p.person_id = ps.person_id
where tr.resource_id is not null and ps.skill is not null