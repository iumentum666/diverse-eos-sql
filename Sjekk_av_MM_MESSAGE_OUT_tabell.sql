SELECT *  FROM MM_MESSAGE_OUT t WHERE t.device_sequence IN (SELECT  p.sequence FROM PERSON_MOBILE p
                       WHERE  p.last_sync_dttm < CONVERT(DATETIME, CONVERT(DATE, GETDATE())) -14)
