SELECT p.person_id,
	p.last_name,
	p.first_name,
	p.phone,
	p.email_address,
	p.status,
	p.metrix_user_type as 'Lisenstype',
	p.threesixty_resource as 'PSO ressurs',
	p.user_def12 as 'Avdeling',
	ps.skill as 'Ferdighet'
 
  FROM person p

  left join person_skill ps on p.person_id = ps.person_id

  where p.status = '01'