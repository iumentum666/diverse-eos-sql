/****** Script for SelectTopNRows command from SSMS  ******/
SELECT p.person_id
      ,p.last_name
      ,p.first_name
      ,p.middle_name
      ,p.job_title
      ,p.metrix_user_type as Lisenstype
	  ,pr.user_role
    
      ,p.mobile_user
      ,p.last_logged_in
      ,p.last_logged_out
	  ,pm.last_sync_dttm
      ,p.threesixty_resource
    
      ,p.user_def12 as 'Avdeling i EOS'
  FROM person p

  left join person_role pr on pr.person_id = p.person_id 
  left join  person_mobile pm on pm.person_id = p.person_id
  	

  where status = '01'
