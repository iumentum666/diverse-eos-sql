select * 
from person_mobile 
where last_sync_dttm < CONVERT(DATETIME, CONVERT(DATE, GETDATE())) -14 