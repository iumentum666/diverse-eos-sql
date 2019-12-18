SELECT r.request_id,
       r.cross_reference,
       r.req_status,
       r.user_def2 as 'Ekstern status',
       re.current_fix_dttm  AS 'Gjeldnede rettetid',
       re.required_end_date AS 'Påkrevd sluttdato',

       tf_pso.task_id as 'First PSO task',
       tf_in.dttm as 'First PSO task IN Process',
       tf_com.dtmm as 'First PSO task Completion',
       tf_pso.created_dttm as 'First PSO task creation',

       tl_pso.task_id as 'Last PSO task',
       tl_in.dttm as 'Last PSO task IN Process',
       tl_com.dtmm as 'Last PSO task Completion',
       tl_pso.created_dttm as 'Last PSO task creation',

       tf_enr.task_id as 'First E&A task',
       tf_in_enr.dttm as 'First E&A task IN Process',
       tf_com_enr.dtmm as 'First E&A task Completion',
       tf_enr.created_dttm as 'First E&A task creation',

       tl_enr.task_id as 'Last E&A task',
       tl_in_enr.dttm as 'Last E&A task IN Process',
       tl_com_enr.dtmm as 'Last E&A task Completion',
       tl_enr.created_dttm as 'Last E&A task creation'




  FROM request r
       INNER JOIN request_ext re ON re.request_id = r.request_id

       CROSS APPLY (SELECT TOP 1 task_id, created_dttm, task_status FROM task WHERE r.request_id = request_id and team_id = 'PSO_ENGINEERS' ORDER BY created_dttm) tf_pso
       OUTER APPLY (SELECT task_id, max(event_dttm) as dttm FROM task_event WHERE event_type = 'IN PROCESS' AND task_id = tf_pso.task_id GROUP BY task_id) tf_in
       OUTER APPLY (SELECT task_id, max(event_dttm) as dtmm FROM task_event WHERE event_type = 'COMPLT' AND task_id = tf_pso.task_id GROUP BY task_id) tf_com

       OUTER APPLY (SELECT TOP 1 task_id, created_dttm, task_status FROM task WHERE r.request_id = request_id and team_id = 'PSO_ENGINEERS' AND task_id != tf_pso.task_id ORDER BY created_dttm DESC) tl_pso
       OUTER APPLY (SELECT task_id, max(event_dttm) as dttm FROM task_event WHERE event_type = 'IN PROCESS' AND task_id = tl_pso.task_id GROUP BY task_id) tl_in
       OUTER APPLY (SELECT task_id, max(event_dttm) as dtmm FROM task_event WHERE event_type = 'COMPLT' AND task_id = tl_pso.task_id GROUP BY task_id) tl_com


       OUTER APPLY (SELECT TOP 1 task_id, created_dttm, task_status FROM task WHERE r.request_id = request_id and task_type = 'ENRICH AND ASSIGN' ORDER BY created_dttm) tf_enr
       OUTER APPLY (SELECT task_id, max(event_dttm) as dttm FROM task_event WHERE event_type = 'IN PROCESS' AND task_id = tf_enr.task_id GROUP BY task_id) tf_in_enr
       OUTER APPLY (SELECT task_id, max(event_dttm) as dtmm FROM task_event WHERE event_type = 'COMPLT' AND task_id = tf_enr.task_id GROUP BY task_id) tf_com_enr

       OUTER APPLY (SELECT TOP 1 task_id, created_dttm, task_status FROM task WHERE r.request_id = request_id and task_type = 'ENRICH AND ASSIGN' AND task_id != tf_enr.task_id ORDER BY created_dttm DESC) tl_enr
       OUTER APPLY (SELECT task_id, max(event_dttm) as dttm FROM task_event WHERE event_type = 'IN PROCESS' AND task_id = tl_enr.task_id GROUP BY task_id) tl_in_enr
       OUTER APPLY (SELECT task_id, max(event_dttm) as dtmm FROM task_event WHERE event_type = 'COMPLT' AND task_id = tl_enr.task_id GROUP BY task_id) tl_com_enr

WHERE r.created_dttm > '2019-03-11 18:00' AND (r.request_id >= '46809' OR r.request_id = '46803')
