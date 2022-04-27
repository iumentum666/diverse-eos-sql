USE PSOSystem
SELECT TOP (1000) [user_id]
      ,[organisation_id]
      ,[failed_logons]
	  ,CONVERT(DATETIME2(0), last_failure) as 'Last failure'
     
      ,[logons]
	  ,CONVERT(DATETIME2(0), last_logon) as 'Last logon'
	  ,CONVERT(DATETIME2(0), last_update) as 'Last update'

  FROM [PSOSystem].[dbo].[User_Activity]