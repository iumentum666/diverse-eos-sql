SELECT
	a.county_id                                                          AS 'Fylke'
  , c.description                                                        AS 'Fylke besk.'
  , r.sales_grp_c                                                        AS 'Region'
  , r.sales_grp_d                                                        AS 'Avdeling'
  , r.request_id                                                         AS 'Ordre ID'
  , r.user_def6                                                          AS 'IFS ao'
  , r.cross_reference                                                    AS 'Ekstern ID'
  , r.req_class                                                          AS 'Ordretype'
  , ru.model_id                                                          AS 'Hovedprodukt'
  , ISNULL(r.user_def11, r.place_id)                                     AS 'TTP'
  , r.user_def17                                                         AS 'Eier'
  , pu_summary.produkter                                                 AS 'Sum produktlinjer'
  , pu_summary.reise                                                     AS 'Sum reisetid'
  , antall                                                               AS 'Antall reiser'
  , reisetid                                                             AS 'Reisetid'
  , fakturerbar_sum                                                      AS 'Fakturerbar reisetid'
  , fakturert                                                            AS 'Fakturert'
  , Ufakturert                                                           AS 'Ikke fakturert'
  , arbeidstid                                                           AS 'Arbeidstid'
  , CONVERT(DATETIME2(0), isnull(rev.user_def_dttm1, re.completed_dttm)) AS 'Ordre fullført' -- re = request_ext -- rev = request model unit id???
  , STUFF (
			(
				SELECT DISTINCT
					', ' + cast(person_id AS varchar(10))
				FROM
					task t
				WHERE
					t .request_id = r.request_id
					AND t .task_type NOT IN ('PRE_DOC'
										   , 'DOCUMENTATION'
										   , 'INVOICING'
										   , 'ENRICH AND ASSIGN')
					AND t .task_status        != 'CANCELED'
					AND t .person_id IS NOT NULL FOR XML PATH('')
		   )
		   , 1, 1, '') AS 'Montør'
  , STUFF (
			(
				SELECT DISTINCT
					', ' + p.first_name + ' ' + p.last_name
				FROM
					task t
					LEFT JOIN
						person p
						ON
							t .person_id = p.person_id
				WHERE
					t .request_id = r.request_id
					AND t .task_type NOT IN ('PRE_DOC'
										   , 'DOCUMENTATION'
										   , 'INVOICING'
										   , 'ENRICH AND ASSIGN')
					AND t .task_status        != 'CANCELED'
					AND t .person_id IS NOT NULL FOR XML PATH('')
		   )
		   , 1, 1, '') AS 'Montørnavn'
FROM
	request r
	LEFT JOIN
		(
			SELECT
				request_id
			  , SUM(IIF(line_code = 'TRAVEL', 1, 0))                         AS 'antall'
			  , SUM(IIF(line_code = 'TRAVEL', quantity, 0))                  AS 'reisetid'
			  , SUM(IIF(line_code = 'TRAVEL', CEILING(quantity * 4) / 4, 0)) AS 'fakturerbar_sum'
			  , SUM(IIF(line_code = 'LABOR', quantity, 0))                   AS 'arbeidstid'
			FROM
				non_part_usage npu
			WHERE
				(
					npu.line_code    = 'TRAVEL'
					OR npu.line_code = 'LABOR'
				)
				AND npu.created_dttm >= '2020-01-01'
			GROUP BY
				request_id
		)
		sum_s
		ON
			r.request_id = sum_s.request_id OUTER APPLY
			(
				SELECT
					SUM(IIF(ppu.user_def9 IS NOT NULL, ppu.quantity, 0)) AS fakturert
				  , SUM(IIF(ppu.user_def9     IS NULL, ppu.quantity, 0)) AS Ufakturert
				FROM
					part_usage ppu
				WHERE
					r.request_id = ppu.request_id
					AND part_id IN ('DR01'
								  , 'LR01')
					AND part_line_code IN ('IN'
										 , 'INV')
			)
			pp
	LEFT JOIN
		place_address pa
		ON
			pa.place_id      = r.place_id
			AND address_type = 'DEFAULT'
	LEFT JOIN
		address a
		ON
			a.address_id = pa.address_id
	LEFT JOIN
		county_id c
		ON
			a.county_id = c.county_id
	LEFT JOIN
		request_ext re
		ON
			r.request_id = re.request_id OUTER APPLY
			(
				SELECT
					TOP 1 user_def_dttm1
				FROM
					request_event rre
				WHERE
					r.request_id             = rre.request_id
					AND user_def13 IS NOT NULL
				ORDER BY
					event_dttm DESC
			)
			rev OUTER APPLY
			(
				SELECT
					TOP 1 model_id
				FROM
					request_unit
				WHERE
					r.request_id = request_unit.request_id
			)
			ru OUTER APPLY
			(
				SELECT
					SUM(IIF(part_id IN ('LR01'
									  , 'DR01'), user_def_num5, 0)) AS reise
				  , SUM(IIF(part_id NOT IN ('LR01'
										  , 'DR01'), user_def_num5, 0)) AS produkter
				FROM
					part_usage pu2
				WHERE
					pu2.request_id = r.request_id
					AND pu2.part_line_code IN ('IN'
											 , 'INV')
					AND pu2.part_id IN
					(
						SELECT
							model_id
						FROM
							model
					)
			)
			pu_summary
WHERE
	r.user_def2 IN ('RT'
				  , 'OK')
	AND re.external_date_event >= '2020-01-01'
	AND ru.model_id IN ('DS01'
					  , 'DS03'
					  , 'DT01'
					  , 'DT01S'
					  , 'DT02'
					  , 'DT05S'
					  , 'DT05X'
					  , 'DT12'
					  , 'DT14a'
					  , 'DT14b'
					  , 'DT14c'
					  , 'DT14f'
					  , 'DT21'
					  , 'DT21a'
					  , 'DT21b'
					  , 'DT22a'
					  , 'DT22b'
					  , 'ULP012'
					  , 'ULP022'
					  , 'ULP032'
					  , 'ULP012a'
					  , 'ULP022a'
					  , 'ULP032a'
					  , 'LV01G'
					  , 'LV01K'
					  , 'LV01M'
					  , 'LV02C'
					  , 'LV06A'
					  , 'LV06B'
					  , 'LV07A'
					  , 'LV09E'
					  , 'LV16'
					  , 'LV20A'
					  , 'LV20B'
					  , 'LV24A'
					  , 'LV24B'
					  , 'LV24C'
					  , 'LV26'
					  , 'LV31A'
					  , 'LV31B'
					  , 'LV72C'
					  , 'LV77B'
					  , 'LV77C'
					  , 'LVH1A'
					  , 'LVH1B'
					  , 'LV65A'
					  , 'LV65B')