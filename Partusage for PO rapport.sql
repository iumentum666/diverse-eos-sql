SELECT [pu_id] as PartUsageID
      ,p.request_id as Requestnummer
	  ,r.user_def6 as IfsNummer
      ,p.part_id as Materialnummer
      ,p.part_line_code as Fakturastatus
      ,p.unit_price as Pris
      ,p.user_def2 as PO
      ,p.user_def5 as FaktureringGodkjent
      ,p.user_def9 as CRN
      ,p.user_def_num2 as CRLN
  FROM [IFSFSMPROD].[dbo].[part_usage] p
  LEFT JOIN [IFSFSMPROD].[dbo].[request] r on p.request_id = r.request_id
  where r.created_dttm >= '2021-01-01' and p.user_def2 is null
