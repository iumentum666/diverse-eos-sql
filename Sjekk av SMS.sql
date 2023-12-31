use IFSFSMPROD
SELECT 
  convert(varchar, cl.[created_dttm] , 104) as SMSSendt,
  t.request_id as RequestID,
  t.task_id as Oppgavenummer,
  r.cross_reference as Eksterntordrenummer,
  cl.phone,
  cl.message_sent,
  cl.message_received,
  cl.communication_log_id
    
  FROM communication_log cl

  left join task t on cl.foreign_key_num1 = t.task_ID
  left join request r on t.request_id = r.request_id
  where cl.communication_log_id > 137 and cl.created_dttm >= '2021-01-01'


	group by t.request_id, t.task_id, phone, cl.created_dttm, r.cross_reference, message_sent, message_received, cl.communication_log_id
