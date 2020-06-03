SELECT p.npu_id as PartUsageId,
      p.request_id as AOnr,
      p.task_id as Oppgavenr,
      p.person_id as Person,
      p.quantity as Antall,
      CONVERT(DATETIME2(0), p.work_dt) as Dato,
      p.duration as Lengde,
	  r.req_class as Ordretype,
	  re.master_model_id as Hovedprodukt,
	  r.place_id as TTP,
	  r.zippost as Postnummer,
	  a.county_id as Fylkesnummer,
	  a.user_def13 as Prisregion,
	  r.sales_grp_d as Avdelingsnummer


  FROM [IFSFSMPROD].[dbo].[non_part_usage] p
  LEFT JOIN [IFSFSMPROD].[dbo].[request] r on p.request_id = r.request_id
  LEFT JOIN [IFSFSMPROD].[dbo].[request_ext] re on p.request_id = re.request_id

  INNER JOIN place_address pa ON r.place_id = pa.place_id AND pa.address_type = 'DEFAULT'
  LEFT JOIN address a ON pa.address_id = a.address_id

  where p.line_code = 'TRAVEL'