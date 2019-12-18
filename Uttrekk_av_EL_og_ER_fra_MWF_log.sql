SELECT request_id, external_status, last_event_dttm, note

  FROM mwf_log

 WHERE  (note = 'changeExpectedSolvedTime' OR external_status IN ('ER', 'EL'))
   AND request_id IN
       (
	   
            '72116'
            -- Liste over ordrenummer
	   
	   )
