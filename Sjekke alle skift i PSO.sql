SELECT 

      [resource_id]
      ,CONVERT(DATETIME2(0), start_datetime) as start_datetime
      ,CONVERT(DATETIME2(0), end_datetime) as end_datetime
      ,[overtime_period]
       ,[manual_scheduling_only]
      ,[travel_cost_model_id]

  FROM [PSOScheduling].[dbo].[Shift]
  where delete_flag = 0 and start_datetime > '2022-01-12' and start_datetime < '2022-01-13'
 order by resource_id, start_datetime asc 
 