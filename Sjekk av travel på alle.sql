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
	  r.sales_grp_d as Avdelingsnummer


  FROM [IFSFSMPROD].[dbo].[non_part_usage] p
  LEFT JOIN [IFSFSMPROD].[dbo].[request] r on p.request_id = r.request_id
  LEFT JOIN [IFSFSMPROD].[dbo].[request_ext] re on p.request_id = re.request_id
  where line_code = 'TRAVEL'