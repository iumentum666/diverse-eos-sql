SELECT 
	CASE	
		WHEN a.county_id  = 	'01'	THEN	'Østfold'
		WHEN a.county_id  = 	'02'	THEN	'Akershus'
		WHEN a.county_id  = 	'03'	THEN	'Oslo'
		WHEN a.county_id  = 	'04'	THEN	'Hedmark'
		WHEN a.county_id  = 	'05'	THEN	'Oppland'
		WHEN a.county_id  = 	'06'	THEN	'Buskerud'
		WHEN a.county_id  = 	'07'	THEN	'Vestfold'
		WHEN a.county_id  = 	'08'	THEN	'Telemark'
		WHEN a.county_id  = 	'09'	THEN	'Aust-Agder'
		WHEN a.county_id  = 	'10'	THEN	'Vest-Agder'
		WHEN a.county_id  = 	'11'	THEN	'Rogaland'
		WHEN a.county_id  = 	'12'	THEN	'Hordaland'
		WHEN a.county_id  = 	'14'	THEN	'Sogn og Fjordane'
		WHEN a.county_id  = 	'15'	THEN	'Møre og Romsdal'
		WHEN a.county_id  = 	'18'	THEN	'Nordland'
		WHEN a.county_id  = 	'19'	THEN	'Troms'
		WHEN a.county_id  = 	'20'	THEN	'Finnmark'
		WHEN a.county_id  = 	'30'	THEN	'Viken'
		WHEN a.county_id  = 	'34'	THEN	'Innlandet'
		WHEN a.county_id  = 	'38'	THEN	'Vestfold og Telemark'
		WHEN a.county_id  = 	'42'	THEN	'Agder'
		WHEN a.county_id  = 	'46'	THEN	'Vestland'
		WHEN a.county_id  = 	'50'	THEN	'Trøndelag'
		WHEN a.county_id  = 	'54'	THEN	'Troms og Finnmark'
			ELSE	a.county_id END								AS fylke,
       r.sales_grp_d                                            AS 'Avdeling',
       pu.request_id                                            AS 'Ordre ID',
       r.user_def6                                              AS 'IFS Nummer',
       r.user_def17                                             AS 'Ordre eier',
       r.req_status                                             AS 'Ordre status',
       r.user_def2                                              AS 'Ekstern status',
       r.req_class                                              AS 'Ordre type',
       pu.USER_DEF1                                             AS 'Signatur',
	   pu.created_by											AS 'Opprettet av',
	   pu.person_id												AS 'Person ID',
	   pu.user_def5												as 'Status',
       CASE WHEN part_line_code = 'IN'  THEN 'Fakturerbar'
            WHEN part_line_code = 'INV' THEN 'Fakturert'
                                        ELSE part_line_code END AS 'Fakturastatus',
	   pu.user_def2												AS 'PO',
	   pu.user_def9												AS 'CREF',
	   pu.user_def_num2											AS 'CRLN',
       pu.part_id                                               AS 'Artikkelnr',
       SUM(pu.quantity)                                          AS 'Antall',
       pu.unit_price                                            AS 'Enhetspris',
       SUM(pu.user_def_num5)                                    AS 'Pris',
       CONVERT(DATE, pu.user_def_dttm1)                         AS 'Faktureringsdato',
	   pu.user_def7												as 'Notat'
  FROM part_usage pu
       INNER JOIN request r ON r.request_id = pu.request_id
	   LEFT JOIN request_ext re on r.request_id = re.request_id
       LEFT JOIN place_address pa ON r.place_id = pa.place_id AND pa.address_type = 'DEFAULT'
       LEFT JOIN address a ON pa.address_id = a.address_id
 WHERE pu.request_id in
(Select part.request_id from part_usage part where part.part_id in ('LVA1A','LVA1B','LVA1C') and pu.user_def_dttm1 > '2021-01-01')


 GROUP BY a.county_id,
          r.sales_grp_d,
          pu.request_id,
          r.user_def6,
          pu.unit_price,
		  pu.user_def5,
          pu.part_line_code,
          pu.user_def2,	
		  pu.user_def_num2,
          pu.user_def9,
          r.user_def17,
          r.req_status,
          r.user_def2,
          r.req_class,
          pu.USER_DEF1,
		  pu.created_by,
		  pu.person_id,
		  pu.part_id,
          pu.user_def_dttm1,
		  pu.user_def7