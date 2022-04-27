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
			ELSE	a.county_id END								AS 'Fylke',
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
 WHERE pu.part_id in ('CDLVT1','CDLVT2','CDLVT2A','DM03','DM03A','DM03B','DM03C','DM03D','DM03E','DM03F','DP3E6','DR01','DR71','DR71K','DT01','DT01H','DT01K','DT01S','DT02','DT03','DT05','DT05H','DT05S','DT05X','DT06','DT07','DT09','DT10','DT10A','DT10B','DT10H','DT12','DT13','DT13A','DT13B','DT13D','DT13E','DT13H','DT13I','DT13J','DT13L','DT13V','DT14','DT14A','DT14B','DT14C','DT15','DT16','DT17','DT21','DT21A','DT21B','DT22','DT22A','DT22B','DT23','DT23A','DT23B','DT24A','DT24B','DT40','DT40A','DT40B','DT40C','DT51','DT51H','DT51K','DT51S','DT52','DT61','DT61A','DT61B','DT62','DT63','DT65A','DT65B','DT70','DT71','DT71K','DT71S','DT79','EL_FIBER_BEDRIFT','EL_FIBER_PRIVAT','EL_TEK_RYDD','EL_TEKTIME','LB79','LB80','LR01','LR02C','LV09H','LV20A','LV20B','LV20C','LV20D','LV22A','LV22F','LV24A','LV24B','LV26','LV35A','LV35B','LV35C','LV35D','LV63','LV63A','LV63B','LV68A','LV68B','LV76A','LV76B','LV76C','LV76D','LV76E','LV80A','LV80B','LV81A','LV81B','LV82A','LV82B','LV83','LV83B','LV84','LV86A','LV86B','LV87A','LV87B','LVA1C','LVK4A','LVK4B','LVK8','LVM1E','LVM1F','LVM2E','LVM2F','LVT1A','LVT1B','LVT1C','LVT1D','LVT1E','LVT1O1','LVT1O2','LVT1O3','LVT1O4','LVT2A','LVT2B','LVT2C','LVT2D','LVT2E','LVT2F','LVTO1','LVTO2','LVTO3','LVTO4','LVXX','TFWA02','UI01','UI02','UI03','UI04','UI05','UI06','UMR60') and pu.user_def_dttm1 > '2021-01-01'


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