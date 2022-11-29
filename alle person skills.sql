SELECT p.person_id,
	p.last_name,
	p.first_name,
	p.phone,
	p.email_address,
	p.status,
	p.metrix_user_type as 'Lisenstype',
	p.threesixty_resource as 'PSO ressurs',
	p.user_def12 as 'Avdeling',
	ad1.county_id as 'Fylke',
	ad1.address as 'Adresse arbeidet starter fra',
	ad1.zippost as 'Postnummer arbeidet starter fra',
	ad1.city as 'Poststed arbeidet starter fra',
	ad2.address as 'Adresse arbeidet ender på',
	ad1.zippost as 'Postnummer arbeidet ender på',
	ad1.city as 'Poststed arbeidet ender på',
	ps.skill as 'Ferdighet',
	ps.active as 'Ferdighet aktiv/ikke aktiv'

  FROM person p

  left join person_skill ps on p.person_id = ps.person_id
left join person_place ppf on p.person_id = ppf.person_id and ppf.place_relationship = 'STARTS_WORK_FROM'
inner join place_address pl1 on ppf.place_id = pl1.place_id
inner join address ad1 on pl1.address_id = ad1.address_id
left join person_place ppt on p.person_id = ppt.person_id and ppt.place_relationship = 'ENDS_WORK_AT'
inner join place_address pl2 on ppt.place_id = pl2.place_id
inner join address ad2 on pl2.address_id = ad2.address_id

where p.status = '01'