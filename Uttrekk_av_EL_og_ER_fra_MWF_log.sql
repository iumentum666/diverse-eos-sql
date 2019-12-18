SELECT request_id, external_status, last_event_dttm, note

  FROM mwf_log

 WHERE  (note = 'changeExpectedSolvedTime' OR external_status IN ('ER', 'EL'))
   AND request_id IN
       (
	   '48124',
'48128',
'48150',
'48175',
'48230',
'48233',
'48235',
'48282',
'48291',
'48310',
'48319',
'48349',
'48401',
'48407',
'48484',
'48494',
'48503',
'48516',
'48518',
'48529',
'48546',
'48552',
'48553',
'48556',
'48565',
'48582',
'48596',
'48631',
'48632',
'48655',
'48677',
'48703',
'48708',
'48712',
'48722',
'48723',
'48724',
'48726',
'48733',
'48742',
'48755',
'48780',
'48788',
'48794',
'48796',
'48799',
'48802',
'48804',
'48806',
'48811',
'48818',
'48823',
'48824',
'48825',
'48852',
'48860',
'48863',
'48866',
'48874',
'48881',
'48887',
'48889',
'48890',
'48893',
'48920',
'48924',
'48925',
'48927',
'48932',
'48933',
'48939',
'48943',
'48945',
'48948',
'48956',
'48961',
'48964',
'48965',
'48974',
'48976',
'48992',
'48993',
'49006',
'49010',
'49012',
'49015',
'49016',
'49018',
'49020',
'49021',
'49056',
'49092',
'49098',
'49104',
'49115',
'49125',
'49135',
'49156',
'49160',
'49181',
'49185',
'49186',
'49191',
'49194',
'49198',
'49199',
'49201',
'49202',
'49207',
'49209',
'49231',
'49251',
'49266',
'49280',
'49284',
'49310',
'49312',
'49334',
'49364',
'49377',
'49378',
'49379',
'49380',
'49381',
'49382',
'49401',
'49409',
'49415',
'49420',
'49424',
'49428',
'49432',
'49442',
'49451',
'49455',
'49456',
'49457',
'49459',
'49460',
'49462',
'49463',
'49490',
'49510',
'49512',
'49523',
'49526',
'49527',
'49541',
'49545',
'49550',
'49551',
'49552',
'49554',
'49556',
'49563',
'49598',
'49599',
'49600',
'49613',
'49620',
'49623',
'49632',
'49637',
'49640',
'49654',
'49655',
'49659',
'49661',
'49662',
'49668',
'49672',
'49682',
'49690',
'49699',
'49707',
'49709',
'49711',
'49716',
'49721',
'49722',
'49730',
'49731',
'49733',
'49741',
'49743',
'49746',
'49747',
'49749',
'49750',
'49751',
'49753',
'49755',
'49757',
'49759',
'49760',
'49761',
'49765',
'49766',
'49767',
'49768',
'49773',
'49774',
'49776',
'49777',
'49778',
'49781',
'49784',
'49787',
'49788',
'49789',
'49790',
'49793',
'49797',
'49798',
'49799',
'49800',
'49803',
'49806',
'49807',
'49808',
'49813',
'49814',
'49816',
'49818',
'49821',
'49822',
'49824',
'49827',
'49828',
'49829',
'49833',
'49834',
'49835',
'49836',
'49842',
'49848',
'49849',
'49850',
'49851',
'49852',
'49853',
'49855',
'49856',
'49857',
'49860',
'49862',
'49863',
'49864',
'49865',
'49869',
'49870',
'49871',
'49872',
'49873',
'49875',
'49877',
'49878',
'49880',
'49882',
'49885',
'49886',
'49887',
'49888',
'49889',
'49890',
'49892',
'49894',
'49895',
'49897',
'49902',
'49904',
'49906',
'49907',
'49909',
'49910',
'49911',
'49912',
'49914',
'49915',
'49916',
'49917',
'49922',
'49923',
'49925',
'49931',
'49936',
'49937',
'49938',
'49939',
'49944',
'49945',
'49946',
'49947',
'49948',
'49952',
'49954',
'49955',
'49956',
'49959',
'49965',
'49966',
'49967',
'49968',
'49969',
'49970',
'49971',
'49973',
'49974',
'49975',
'49977',
'49979',
'49985',
'49988',
'49990',
'49999',
'50000',
'50001',
'50005',
'50007',
'50012',
'50027',
'50029',
'50035',
'50044',
'50069',
'50091',
'50093',
'50098',
'50105',
'50121',
'50124',
'50127',
'50133',
'50137',
'50144',
'50146',
'50150',
'50152',
'50159',
'50170',
'50172',
'50179',
'50180',
'50184',
'50188',
'50189',
'50191',
'50193',
'50196',
'50199',
'50202',
'50207',
'50209',
'50210',
'50212',
'50217',
'50218',
'50220',
'50221',
'50222',
'50223',
'50224',
'50226',
'50229',
'50230',
'50231',
'50232',
'50235',
'50237',
'50246',
'50247',
'50248',
'50249',
'50250',
'50251',
'50255',
'50259',
'50260',
'50261',
'50263',
'50264',
'50265',
'50266',
'50270',
'50271',
'50272',
'50273',
'50274',
'50275',
'50276',
'50280',
'50281',
'50282',
'50283',
'50284',
'50298',
'50302',
'50306',
'50314',
'50328',
'50332',
'50333',
'50335',
'50348',
'50349',
'50362',
'50371',
'50377',
'50380',
'50384',
'50397',
'50408',
'50421',
'50426',
'50427',
'50431',
'50435',
'50441',
'50442',
'50443',
'50447',
'50448',
'50453',
'50457',
'50458',
'50479',
'50482',
'50483',
'50486',
'50487',
'50495',
'50499',
'50502',
'50508',
'50513',
'50523',
'50539',
'50541',
'50547',
'50551',
'50555',
'50560',
'50564',
'50566',
'50582',
'50583',
'50587',
'50601',
'50613',
'50614',
'50615',
'50616',
'50619',
'50622',
'50625',
'50626',
'50627',
'50633',
'50638',
'50639',
'50641',
'50643',
'50648',
'50653',
'50655',
'50658',
'50659',
'50662',
'50663',
'50665',
'50666',
'50668',
'50670',
'50678',
'50681',
'50683',
'50684',
'50686',
'50691',
'50693',
'50694',
'50695',
'50697',
'50698',
'50700',
'50701',
'50702',
'50704',
'50706',
'50713',
'50716',
'50717',
'50719',
'50739',
'50740',
'50741',
'50749',
'50757',
'50761',
'50765',
'50771',
'50780',
'50813',
'50823',
'50831',
'50837',
'50842',
'50850',
'50858',
'50869',
'50874',
'50882',
'50903',
'50905',
'50907',
'50918',
'50921',
'50946',
'50960',
'50961',
'50963',
'50964',
'50966',
'50970',
'50973',
'50984',
'50986',
'50988',
'50990',
'50995',
'51000',
'51024',
'51038',
'51045',
'51046',
'51050',
'51051',
'51052',
'51058',
'51059',
'51060',
'51066',
'51067',
'51069',
'51077',
'51087',
'51090',
'51091',
'51093',
'51095',
'51096',
'51097',
'51100',
'51101',
'51106',
'51107',
'51109',
'51110',
'51114',
'51116',
'51120',
'51121',
'51127',
'51129',
'51130',
'51134',
'51139',
'51140',
'51141',
'51142',
'51144',
'51155',
'51166',
'51168',
'51169',
'51172',
'51176',
'51181',
'51183',
'51185',
'51197',
'51202',
'51204',
'51207',
'51217',
'51218',
'51223',
'51228',
'51248',
'51250',
'51251',
'51254',
'51257',
'51261',
'51264',
'51267',
'51268',
'51276',
'51277',
'51289',
'51296',
'51299',
'51300',
'51314',
'51315',
'51320',
'51333',
'51342',
'51343',
'51348',
'51359',
'51365',
'51366',
'51367',
'51384',
'51389',
'51400',
'51401',
'51406',
'51413',
'51419',
'51422',
'51426',
'51428',
'51434',
'51438',
'51439',
'51440',
'51446',
'51463',
'51467',
'51472',
'51474',
'51476',
'51486',
'51487',
'51488',
'51490',
'51491',
'51492',
'51493',
'51494',
'51495',
'51497',
'51500',
'51502',
'51537',
'51539',
'51543',
'51545',
'51551',
'51558',
'51561',
'51563',
'51564',
'51567',
'51569',
'51570',
'51571',
'51572',
'51573',
'51574',
'51575',
'51578',
'51582',
'51585',
'51587',
'51602',
'51603',
'51606',
'51609',
'51612',
'51613',
'51614',
'51615',
'51619',
'51621',
'51626',
'51629',
'51642',
'51645',
'51648',
'51673',
'51674',
'51685',
'51705',
'51726',
'51755',
'51760',
'51774',
'51793',
'51800',
'51805',
'51809',
'51812',
'51815',
'51828',
'51829',
'51831',
'51832',
'51836',
'51839',
'51845',
'51852',
'51853',
'51859',
'51864',
'51881',
'51882',
'51887',
'51897',
'51898',
'51900',
'51903',
'51909',
'51920',
'51922',
'51927',
'51935',
'51944',
'51953',
'51959',
'51963',
'51972',
'51973',
'51977',
'51988',
'51995',
'51997',
'52003',
'52005',
'52029',
'52032',
'52033',
'52040',
'52045',
'52048',
'52050',
'52053',
'52054',
'52058',
'52059',
'52062',
'52066',
'52067',
'52068',
'52069',
'52072',
'52074',
'52075',
'52078',
'52092',
'52101',
'52109',
'52113',
'52120',
'52140',
'52147',
'52149',
'52150',
'52155',
'52159',
'52161',
'52164',
'52166',
'52167',
'52169',
'52176',
'52181',
'52186',
'52196',
'52201',
'52204',
'52206',
'52217',
'52231',
'52279',
'52286',
'52291',
'52301',
'52316',
'52321',
'52322',
'52342',
'52346',
'52353',
'52356',
'52360',
'52364',
'52368',
'52374',
'52380',
'52381',
'52382',
'52383',
'52387',
'52392',
'52395',
'52410',
'52412',
'52413',
'52414',
'52415',
'52417',
'52421',
'52423',
'52427',
'52429',
'52431',
'52435',
'52436',
'52440',
'52441',
'52443',
'52445',
'52446',
'52447',
'52448',
'52452',
'52454',
'52456',
'52457',
'52458',
'52463',
'52466',
'52468',
'52472',
'52474',
'52502',
'52504',
'52540',
'52542',
'52579',
'52580',
'52582',
'52602',
'52613',
'52624',
'52629',
'52630',
'52633',
'52636',
'52637',
'52638',
'52644',
'52652',
'52656',
'52657',
'52658',
'52669',
'52671',
'52673',
'52677',
'52684',
'52685',
'52687',
'52692',
'52707',
'52743',
'52745',
'52748',
'52764',
'52774',
'52790',
'52796',
'52805',
'52806',
'52810',
'52812',
'52813',
'52816',
'52819',
'52822',
'52824',
'52833',
'52844',
'52846',
'52847',
'52852',
'52855',
'52858',
'52862',
'52866',
'52867',
'52879',
'52881',
'52882',
'52883',
'52887',
'52895',
'52898',
'52901',
'52902',
'52905',
'52913',
'52918',
'52919',
'52953',
'52955',
'52957',
'52959',
'52961',
'52966',
'52974',
'52996',
'53003',
'53005',
'53015',
'53027',
'53032',
'53036',
'53044',
'53052',
'53053',
'53060',
'53068',
'53075',
'53091',
'53099',
'53118',
'53123',
'53128',
'53131',
'53138',
'53145',
'53163',
'53166',
'53168',
'53169',
'53170',
'53192',
'53198',
'53203',
'53209',
'53214',
'53224',
'53225',
'53232',
'53239',
'53241',
'53251',
'53252',
'53257',
'53259',
'53280',
'53284',
'53285',
'53291',
'53293',
'53295',
'53296',
'53300',
'53301',
'53303',
'53307',
'53310',
'53311',
'53313',
'53317',
'53320',
'53321',
'53325',
'53326',
'53329',
'53332',
'53336',
'53338',
'53340',
'53345',
'53348',
'53358',
'53363',
'53369',
'53378',
'53381',
'53390',
'53393',
'53396',
'53397',
'53400',
'53401',
'53403',
'53404',
'53405',
'53423',
'53427',
'53432',
'53443',
'53447',
'53463',
'53473',
'53477',
'53479',
'53483',
'53513',
'53521',
'53534',
'53549',
'53550',
'53551',
'53558',
'53559',
'53560',
'53562',
'53569',
'53572',
'53588',
'53595',
'53599',
'53605',
'53606',
'53624',
'53629',
'53640',
'53642',
'53650',
'53654',
'53655',
'53658',
'53661',
'53669',
'53678',
'53682',
'53685',
'53687',
'53688',
'53693',
'53696',
'53697',
'53698',
'53699',
'53705',
'53706',
'53708',
'53710',
'53713',
'53717',
'53720',
'53721',
'53723',
'53724',
'53725',
'53726',
'53730',
'53733',
'53735',
'53737',
'53738',
'53747',
'53749',
'53750',
'53752',
'53753',
'53754',
'53757',
'53758',
'53760',
'53764',
'53769',
'53770',
'53771',
'53775',
'53778',
'53784',
'53786',
'53813',
'53814',
'53815',
'53819',
'53823',
'53824',
'53826',
'53828',
'53830',
'53831',
'53833',
'53834',
'53835',
'53836',
'53839',
'53842',
'53845',
'53846',
'53847',
'53848',
'53854',
'53855',
'53856',
'53857',
'53858',
'53860',
'53861',
'53862',
'53865',
'53872',
'53878',
'53879',
'53882',
'53886',
'53890',
'53891',
'53894',
'53897',
'53898',
'53903',
'53906',
'53910',
'53911',
'53912',
'53914',
'53920',
'53921',
'53922',
'53923',
'53925',
'53927',
'53928',
'53948',
'53949',
'53961',
'53964',
'53977',
'53987',
'53990',
'53997',
'53999',
'54013',
'54014',
'54018',
'54027',
'54030',
'54033',
'54035',
'54037',
'54039',
'54049',
'54053',
'54063',
'54085',
'54093',
'54094',
'54096',
'54099',
'54105',
'54109',
'54127',
'54137',
'54139',
'54151',
'54152',
'54163',
'54168',
'54170',
'54178',
'54186',
'54198',
'54210',
'54216',
'54227',
'54237',
'54243',
'54245',
'54248',
'54261',
'54264',
'54271',
'54279',
'54282',
'54286',
'54289',
'54291',
'54297',
'54298',
'54302',
'54333',
'54344',
'54353',
'54365',
'54375',
'54393',
'54397',
'54406',
'54434',
'54436',
'54444',
'54451',
'54473',
'54477',
'54483',
'54499',
'54511',
'54528',
'54543',
'54556',
'54565',
'54566',
'54581',
'54589',
'54591',
'54597',
'54602',
'54605',
'54609',
'54616',
'54633',
'54636',
'54644',
'54645',
'54652',
'54654',
'54658',
'54664',
'54667',
'54669',
'54686',
'54687',
'54688',
'54691',
'54693',
'54694',
'54701',
'54702',
'54706',
'54711',
'54718',
'54720',
'54721',
'54725',
'54728',
'54730',
'54744',
'54745',
'54747',
'54750',
'54751',
'54752',
'54753',
'54759',
'54762',
'54777',
'54780',
'54801',
'54823',
'54828',
'54832',
'54855',
'54860',
'54862',
'54863',
'54866',
'54878',
'54884',
'54889',
'54894',
'54898',
'54904',
'54915',
'54920',
'54933',
'54938',
'54943',
'54976',
'54983',
'55001',
'55002',
'55022',
'55037',
'55038',
'55049',
'55054',
'55061',
'55064',
'55065',
'55067',
'55068',
'55069',
'55073',
'55074',
'55084',
'55086',
'55094',
'55095',
'55097',
'55104',
'55105',
'55110',
'55113',
'55129',
'55196',
'55209',
'55215',
'55228',
'55244',
'55272',
'55274',
'55285',
'55289',
'55294',
'55310',
'55323',
'55331',
'55337',
'55345',
'55350',
'55351',
'55356',
'55363',
'55366',
'55367',
'55376',
'55379',
'55381',
'55385',
'55386',
'55388',
'55390',
'55392',
'55398',
'55402',
'55406',
'55413',
'55417',
'55424',
'55426',
'55428',
'55430',
'55433',
'55434',
'55447',
'55452',
'55465',
'55471',
'55474',
'55485',
'55486',
'55488',
'55492',
'55525',
'55534',
'55544',
'55546',
'55589',
'55601',
'55628',
'55631',
'55645',
'55647',
'55671',
'55677',
'55683',
'55691',
'55693',
'55700',
'55704',
'55709',
'55711',
'55712',
'55718',
'55720',
'55723',
'55730',
'55733',
'55735',
'55737',
'55738',
'55743',
'55751',
'55752',
'55753',
'55759',
'55761',
'55762',
'55763',
'55768',
'55773',
'55775',
'55789',
'55794',
'55799',
'55801',
'55802',
'55804',
'55809',
'55815',
'55816',
'55818',
'55819',
'55822',
'55826',
'55827',
'55828',
'55837',
'55842',
'55858',
'55861',
'55864',
'55865',
'55870',
'55873',
'55875',
'55877',
'55880',
'55881',
'55882',
'55883',
'55887',
'55891',
'55894',
'55900',
'55902',
'55905',
'55910',
'55912',
'55946',
'55947',
'55953',
'55965',
'55972',
'56068',
'56081',
'56096',
'56103',
'56106',
'56116',
'56120',
'56122',
'56132',
'56135',
'56144',
'56153',
'56157',
'56160',
'56167',
'56170',
'56182',
'56183',
'56195',
'56201',
'56207',
'56242',
'56249',
'56256',
'56257',
'56279',
'56280',
'56288',
'56295',
'56308',
'56309',
'56313',
'56316',
'56317',
'56328',
'56330',
'56342',
'56345',
'56353',
'56356',
'56359',
'56360',
'56362',
'56364',
'56367',
'56372',
'56374',
'56381',
'56382',
'56389',
'56392',
'56397',
'56403',
'56405',
'56407',
'56408',
'56410',
'56412',
'56420',
'56421',
'56422',
'56423',
'56426',
'56427',
'56428',
'56431',
'56433',
'56434',
'56435',
'56440',
'56441',
'56442',
'56446',
'56448',
'56451',
'56452',
'56453',
'56455',
'56456',
'56458',
'56463',
'56464',
'56493',
'56507',
'56519',
'56533',
'56571',
'56579',
'56586',
'56598',
'56603',
'56604',
'56630',
'56637',
'56639',
'56642',
'56647',
'56653',
'56659',
'56660',
'56678',
'56679',
'56685',
'56690',
'56695',
'56711',
'56712',
'56721',
'56727',
'56744',
'56759',
'56767',
'56768',
'56772',
'56773',
'56776',
'56780',
'56781',
'56797',
'56802',
'56803',
'56815',
'56821',
'56828',
'56830',
'56832',
'56842',
'56847',
'56849',
'56851',
'56856',
'56866',
'56868',
'56872',
'56873',
'56874',
'56878',
'56880',
'56882',
'56884',
'56885',
'56886',
'56888',
'56889',
'56890',
'56893',
'56898',
'56899',
'56901',
'56909',
'56916',
'56927',
'56932',
'56933',
'56934',
'56948',
'56966',
'56974',
'56991',
'57008',
'57010',
'57011',
'57024',
'57043',
'57048',
'57061',
'57068',
'57071',
'57113',
'57118',
'57119',
'57125',
'57132',
'57161',
'57166',
'57197',
'57214',
'57220',
'57223',
'57227',
'57232',
'57233',
'57236',
'57238',
'57242',
'57246',
'57249',
'57251',
'57267',
'57271',
'57272',
'57275',
'57279',
'57280',
'57282',
'57283',
'57285',
'57287',
'57293',
'57296',
'57298',
'57299',
'57300',
'57307',
'57308',
'57309',
'57310',
'57317',
'57326',
'57327',
'57329',
'57372',
'57380',
'57387',
'57395',
'57429',
'57431',
'57433',
'57439',
'57443',
'57455',
'57457',
'57476',
'57488',
'57491',
'57513',
'57514',
'57518',
'57539',
'57552',
'57560',
'57580',
'57585',
'57603',
'57604',
'57605',
'57619',
'57622',
'57625',
'57626',
'57630',
'57632',
'57651',
'57654',
'57664',
'57668',
'57671',
'57672',
'57676',
'57681',
'57691',
'57693',
'57694',
'57703',
'57704',
'57706',
'57713',
'57729',
'57730',
'57732',
'57735',
'57738',
'57742',
'57743',
'57744',
'57745',
'57749',
'57753',
'57788',
'57825',
'57826',
'57837',
'57845',
'57869',
'57871',
'57878',
'57914',
'57931',
'57934',
'57945',
'57959',
'57963',
'57975',
'57997',
'58010',
'58014',
'58017',
'58018',
'58025',
'58027',
'58038',
'58047',
'58052',
'58054',
'58063',
'58067',
'58069',
'58075',
'58076',
'58080',
'58083',
'58084',
'58086',
'58087',
'58088',
'58093',
'58096',
'58098',
'58100',
'58101',
'58102',
'58105',
'58106',
'58112',
'58115',
'58117',
'58118',
'58119',
'58124',
'58144',
'58145',
'58148',
'58157',
'58205',
'58208',
'58221',
'58224',
'58226',
'58235',
'58254',
'58274',
'58293',
'58308',
'58332',
'58338',
'58340',
'58343',
'58353',
'58354',
'58362',
'58367',
'58368',
'58371',
'58375',
'58385',
'58392',
'58399',
'58400',
'58405',
'58406',
'58408',
'58416',
'58418',
'58419',
'58425',
'58427',
'58428',
'58434',
'58435',
'58438',
'58462',
'58465',
'58466',
'58474',
'58477',
'58481',
'58482',
'58484',
'58486',
'58487',
'58511',
'58512',
'58538',
'58540',
'58584',
'58596',
'58621',
'58636',
'58646',
'58660',
'58665',
'58679',
'58684',
'58686',
'58689',
'58693',
'58703',
'58705',
'58709',
'58713',
'58720',
'58730',
'58745',
'58771',
'58780',
'58787',
'58790',
'58792',
'58793',
'58794',
'58801',
'58813',
'58814',
'58820',
'58824',
'58825',
'58827',
'58832',
'58834',
'58859',
'58860',
'58866',
'58868',
'58917',
'58924',
'58927',
'58944',
'58952',
'58954',
'58960',
'58969',
'58972',
'58977',
'58982',
'59010',
'59019',
'59035',
'59037',
'59051',
'59053',
'59057',
'59058',
'59076',
'59081',
'59082',
'59083',
'59093',
'59094',
'59102',
'59103',
'59107',
'59120',
'59121',
'59134',
'59144',
'59157',
'59176',
'59198',
'59200',
'59213',
'59216',
'59225',
'59226',
'59232',
'59247',
'59253',
'59259',
'59264',
'59281',
'59295',
'59356',
'59364',
'59370',
'59381',
'59383',
'59412',
'59415',
'59435',
'59439',
'59441',
'59452',
'59462',
'59494',
'59500',
'59501',
'59532',
'59536',
'59539',
'59546',
'59547',
'59562',
'59574',
'59576',
'59578',
'59581',
'59589',
'59597',
'59601',
'59602',
'59605',
'59612',
'59613',
'59614',
'59615',
'59617',
'59618',
'59619',
'59629',
'59636',
'59639',
'59641',
'59643',
'59644',
'59646',
'59647',
'59651',
'59655',
'59657',
'59679',
'59681',
'59686',
'59687',
'59688',
'59689',
'59691',
'59692',
'59693',
'59694',
'59696',
'59699',
'59701',
'59704',
'59707',
'59711',
'59714',
'59715',
'59716',
'59759',
'59763',
'59772',
'59776',
'59785',
'59792',
'59795',
'59796',
'59800',
'59804',
'59810',
'59811',
'59812',
'59843',
'59859',
'59872',
'59885',
'59895',
'59904',
'59911',
'59912',
'59918',
'59931',
'59934',
'59938',
'59941',
'59947',
'59949',
'59981',
'59986',
'59996',
'59997',
'60002',
'60010',
'60014',
'60015',
'60025',
'60040',
'60043',
'60051',
'60056',
'60057',
'60061',
'60068',
'60070',
'60073',
'60077',
'60079',
'60080',
'60083',
'60084',
'60095',
'60097',
'60099',
'60101',
'60102',
'60104',
'60113',
'60114',
'60116',
'60118',
'60119',
'60129',
'60130',
'60132',
'60137',
'60157',
'60166',
'60170',
'60177',
'60183',
'60209',
'60252',
'60258',
'60294',
'60299',
'60319',
'60339',
'60356',
'60361',
'60362',
'60392',
'60401',
'60405',
'60409',
'60411',
'60412',
'60420',
'60424',
'60432',
'60434',
'60437',
'60438',
'60441',
'60442',
'60443',
'60445',
'60446',
'60451',
'60453',
'60456',
'60458',
'60462',
'60463',
'60467',
'60471',
'60474',
'60477',
'60478',
'60482',
'60492',
'60498',
'60504',
'60506',
'60508',
'60513',
'60515',
'60525',
'60533',
'60538',
'60552',
'60559',
'60564',
'60570',
'60572',
'60595',
'60597',
'60598',
'60609',
'60622',
'60633',
'60654',
'60655',
'60662',
'60682',
'60692',
'60703',
'60723',
'60729',
'60737',
'60738',
'60739',
'60740',
'60742',
'60743',
'60745',
'60746',
'60747',
'60748',
'60752',
'60753',
'60754',
'60755',
'60756',
'60766',
'60801',
'60809',
'60817',
'60821',
'60824',
'60826',
'60831',
'60841',
'60844',
'60851',
'60855',
'60864',
'60866',
'60869',
'60870',
'60904',
'60921',
'60927',
'60935',
'60936',
'60939',
'60943',
'60960',
'60963',
'60964',
'60965',
'60968',
'60970',
'60975',
'60980',
'60999',
'61022',
'61029',
'61034',
'61041',
'61048',
'61073',
'61081',
'61096',
'61097',
'61102',
'61103',
'61118',
'61138',
'61149',
'61154',
'61156',
'61158',
'61159',
'61165',
'61166',
'61174',
'61177',
'61179',
'61180',
'61183',
'61191',
'61196',
'61197',
'61203',
'61217',
'61221',
'61224',
'61228',
'61231',
'61235',
'61236',
'61237',
'61240',
'61245',
'61246',
'61251',
'61253',
'61257',
'61259',
'61260',
'61267',
'61269',
'61271',
'61274',
'61276',
'61280',
'61281',
'61284',
'61287',
'61288',
'61290',
'61293',
'61297',
'61298',
'61300',
'61306',
'61310',
'61318',
'61325',
'61331',
'61335',
'61336',
'61337',
'61339',
'61373',
'61391',
'61406',
'61408',
'61422',
'61427',
'61431',
'61441',
'61457',
'61463',
'61466',
'61473',
'61476',
'61477',
'61482',
'61489',
'61499',
'61502',
'61503',
'61546',
'61548',
'61561',
'61563',
'61564',
'61565',
'61566',
'61568',
'61569',
'61571',
'61583',
'61603',
'61611',
'61614',
'61621',
'61623',
'61625',
'61626',
'61629',
'61644',
'61646',
'61647',
'61650',
'61657',
'61658',
'61659',
'61664',
'61678',
'61680',
'61689',
'61692',
'61694',
'61698',
'61699',
'61702',
'61703',
'61704',
'61711',
'61727',
'61736',
'61750',
'61757',
'61775',
'61776',
'61787',
'61789',
'61790',
'61796',
'61801',
'61802',
'61809',
'61811',
'61816',
'61818',
'61820',
'61827',
'61829',
'61834',
'61866',
'61895',
'61911',
'61921',
'61926',
'61927',
'61930',
'61940',
'61943',
'61949',
'61950',
'61973',
'61976',
'61979',
'61980',
'61987',
'61990',
'61999',
'62001',
'62002',
'62005',
'62008',
'62010',
'62011',
'62012',
'62014',
'62020',
'62026',
'62045',
'62048',
'62050',
'62073',
'62076',
'62089',
'62094',
'62116',
'62123',
'62134',
'62160',
'62174',
'62178',
'62182',
'62190',
'62196',
'62204',
'62230',
'62258',
'62270',
'62279',
'62280',
'62291',
'62302',
'62311',
'62317',
'62318',
'62326',
'62327',
'62328',
'62329',
'62331',
'62342',
'62346',
'62347',
'62352',
'62355',
'62357',
'62358',
'62360',
'62414',
'62421',
'62436',
'62480',
'62484',
'62499',
'62505',
'62535',
'62539',
'62546',
'62554',
'62556',
'62557',
'62573',
'62580',
'62589',
'62591',
'62593',
'62596',
'62619',
'62634',
'62636',
'62658',
'62665',
'62674',
'62720',
'62730',
'62742',
'62759',
'62793',
'62799',
'62801',
'62829',
'62834',
'62844',
'62845',
'62848',
'62850',
'62869',
'62883',
'62887',
'62892',
'62893',
'62898',
'62902',
'62904',
'62905',
'62908',
'62912',
'62913',
'62914',
'62915',
'62916',
'62917',
'62919',
'62922',
'62924',
'62926',
'62930',
'62943',
'62947',
'62948',
'62949',
'62951',
'62955',
'62960',
'62962',
'62963',
'62967',
'62968',
'62973',
'62980',
'62981',
'62982',
'62984',
'62997',
'63000',
'63004',
'63014',
'63016',
'63021',
'63034',
'63040',
'63059',
'63060',
'63065',
'63077',
'63080',
'63087',
'63090',
'63095',
'63105',
'63122',
'63135',
'63139',
'63145',
'63155',
'63157',
'63165',
'63189',
'63190',
'63197',
'63203',
'63204',
'63211',
'63216',
'63220',
'63224',
'63238',
'63242',
'63268',
'63292',
'63298',
'63299',
'63301',
'63305',
'63316',
'63318',
'63322',
'63324',
'63327',
'63331',
'63332',
'63340',
'63346',
'63348',
'63352',
'63356',
'63357',
'63360',
'63368',
'63379',
'63387',
'63390',
'63391',
'63393',
'63400',
'63407',
'63408',
'63413',
'63426',
'63428',
'63438',
'63442',
'63445',
'63447',
'63455',
'63466',
'63467',
'63474',
'63475',
'63485',
'63486',
'63489',
'63490',
'63491',
'63496',
'63497',
'63499',
'63504',
'63505',
'63509',
'63511',
'63512',
'63514',
'63515',
'63517',
'63522',
'63524',
'63529',
'63530',
'63532',
'63534',
'63541',
'63543',
'63547',
'63558',
'63559',
'63561',
'63563',
'63567',
'63570',
'63573',
'63575',
'63577',
'63580',
'63581',
'63583',
'63584',
'63585',
'63587',
'63590',
'63592',
'63597',
'63640',
'63644',
'63654',
'63655',
'63666',
'63676',
'63677',
'63679',
'63681',
'63689',
'63698',
'63707',
'63711',
'63730',
'63732',
'63756',
'63763',
'63766',
'63771',
'63776',
'63789',
'63815',
'63822',
'63825',
'63827',
'63830',
'63833',
'63835',
'63836',
'63837',
'63839',
'63840',
'63842',
'63844',
'63845',
'63850',
'63857',
'63859',
'63867',
'63890',
'63904',
'63912',
'63914',
'63917',
'63924',
'63926',
'63931',
'63934',
'63938',
'63939',
'63940',
'63945',
'63953',
'63958',
'63959',
'63961',
'63964',
'63972',
'63973',
'63974',
'63981',
'63983',
'63985',
'63987',
'63990',
'63992',
'63994',
'63997',
'63998',
'63999',
'64002',
'64005',
'64009',
'64010',
'64011',
'64012',
'64015',
'64019',
'64024',
'64052',
'64076',
'64077',
'64095',
'64100',
'64101',
'64114',
'64147',
'64157',
'64159',
'64164',
'64170',
'64174',
'64180',
'64191',
'64192',
'64199',
'64204',
'64205',
'64209',
'64214',
'64234',
'64239',
'64259',
'64263',
'64265',
'64266',
'64283',
'64288',
'64309',
'64311',
'64317',
'64318',
'64335',
'64337',
'64340',
'64345',
'64349',
'64350',
'64351',
'64352',
'64354',
'64356',
'64359',
'64369',
'64371',
'64372',
'64373',
'64377',
'64382',
'64393',
'64394',
'64395',
'64399',
'64401',
'64402',
'64406',
'64479',
'64497',
'64503',
'64504',
'64506',
'64519',
'64546',
'64549',
'64553',
'64555',
'64565',
'64569',
'64572',
'64575',
'64585',
'64610',
'64637',
'64638',
'64640',
'64644',
'64650',
'64671',
'64672',
'64680',
'64684',
'64687',
'64722',
'64723',
'64739',
'64744',
'64748',
'64769',
'64772',
'64773',
'64778',
'64790',
'64793',
'64794',
'64798',
'64806',
'64808',
'64810',
'64813',
'64814',
'64826',
'64845',
'64863',
'64878',
'64882',
'64886',
'64892',
'64919',
'64928',
'64936',
'64941',
'64946',
'64964',
'64972',
'64990',
'65027',
'65030',
'65039',
'65040',
'65045',
'65052',
'65055',
'65063',
'65066',
'65078',
'65095',
'65096',
'65097',
'65107',
'65112',
'65114',
'65115',
'65117',
'65122',
'65129',
'65136',
'65154',
'65157',
'65158',
'65164',
'65171',
'65173',
'65174',
'65176',
'65182',
'65184',
'65185',
'65191',
'65203',
'65207',
'65220',
'65231',
'65237',
'65250',
'65251',
'65269',
'65302',
'65317',
'65331',
'65360',
'65368',
'65372',
'65394',
'65418',
'65422',
'65454',
'65457',
'65464',
'65482',
'65503',
'65506',
'65538',
'65562',
'65581',
'65584',
'65629',
'65642',
'65655',
'65675',
'65684',
'65732',
'65747',
'65755',
'65761',
'65777',
'65786',
'65789',
'65790',
'65793',
'65797',
'65798',
'65799',
'65802',
'65849',
'65855',
'65872',
'65873',
'65881',
'65890',
'65908',
'65910',
'65915',
'65918',
'65927',
'65928',
'65930',
'65953',
'65966',
'65967',
'65993',
'66022',
'66062',
'66072',
'66081',
'66100',
'66102',
'66110',
'66114',
'66115',
'66121',
'66124',
'66135',
'66148',
'66153',
'66161',
'66165',
'66168',
'66192',
'66233',
'66242',
'66248',
'66272',
'66276',
'66282',
'66312',
'66314',
'66359',
'66364',
'66374',
'66377',
'66387',
'66402',
'66411',
'66421',
'66426',
'66427',
'66429',
'66438',
'66441',
'66446',
'66461',
'66466',
'66472',
'66488',
'66490',
'66492',
'66501',
'66506',
'66510',
'66515',
'66521',
'66549',
'66556',
'66570',
'66599',
'66600',
'66683',
'66685',
'66689',
'66693',
'66699',
'66702',
'66708',
'66736',
'66742',
'66801',
'66821',
'66824',
'66828',
'66833',
'66842',
'66864',
'66883',
'66898',
'66924',
'66930',
'66936',
'66947',
'66996',
'66999',
'67004',
'67017',
'67022',
'67034',
'67044',
'67077',
'67097',
'67098',
'67101',
'67104',
'67105',
'67113',
'67115',
'67117',
'67118',
'67120',
'67121',
'67126',
'67127',
'67129',
'67141',
'67142',
'67143',
'67148',
'67151',
'67160',
'67161',
'67173',
'67184',
'67200',
'67240',
'67247',
'67274',
'67307',
'67326',
'67333',
'67336',
'67355',
'67356',
'67366',
'67393',
'67400',
'67404',
'67409',
'67410',
'67423',
'67435',
'67491',
'67499',
'67509',
'67533',
'67540',
'67573',
'67585',
'67610',
'67621',
'67625',
'67630',
'67641',
'67646',
'67656',
'67657',
'67658',
'67666',
'67685',
'67686',
'67691',
'67701',
'67704',
'67706',
'67723',
'67729',
'67742',
'67745',
'67747',
'67750',
'67752',
'67756',
'67759',
'67760',
'67761',
'67771',
'67774',
'67775',
'67778',
'67785',
'67798',
'67814',
'67816',
'67817',
'67820',
'67827',
'67861',
'67907',
'67908',
'67917',
'67921',
'67922',
'67966',
'67972',
'67974',
'67983',
'67998',
'68028',
'68032',
'68060',
'68063',
'68066',
'68095',
'68112',
'68118',
'68145',
'68152',
'68158',
'68164',
'68170',
'68198',
'68221',
'68229',
'68230',
'68233',
'68243',
'68289',
'68293',
'68297',
'68344',
'68378',
'68503',
'68526',
'68529',
'68548',
'68550',
'68557',
'68558',
'68570',
'68594',
'68604',
'68610',
'68637',
'68648',
'68677',
'68680',
'68682',
'68684',
'68708',
'68743',
'68757',
'68788',
'68811',
'68815',
'68819',
'68828',
'68851',
'68852',
'68853',
'68856',
'68860',
'68863',
'68901',
'68904',
'68909',
'68984',
'69026',
'69033',
'69039',
'69078',
'69107',
'69158',
'69206',
'69229',
'69230',
'69233',
'69250',
'69256',
'69264',
'69265',
'69273',
'69275',
'69281',
'69287',
'69291',
'69300',
'69308',
'69329',
'69388',
'69410',
'69414',
'69433',
'69439',
'69441',
'69452',
'69471',
'69474',
'69476',
'69506',
'69507',
'69594',
'69622',
'69626',
'69642',
'69643',
'69685',
'69704',
'69743',
'69748',
'69757',
'69778',
'69780',
'69781',
'69782',
'69806',
'69808',
'69809',
'69827',
'69850',
'69868',
'69877',
'69997',
'70005',
'70013',
'70047',
'70051',
'70060',
'70073',
'70078',
'70120',
'70151',
'70176',
'70195',
'70223',
'70237',
'70246',
'70255',
'70326',
'70328',
'70341',
'70382',
'70407',
'70439',
'70458',
'70484',
'70488',
'70503',
'70508',
'70597',
'70624',
'70702',
'70703',
'70719',
'70796',
'70819',
'70886',
'70930',
'71062',
'71095',
'71105',
'71112',
'71120',
'71123',
'71133',
'71140',
'71151',
'71196',
'71207',
'71211',
'71246',
'71257',
'71272',
'71283',
'71289',
'71295',
'71306',
'71343',
'71365',
'71393',
'71413',
'71431',
'71453',
'71460',
'71461',
'71464',
'71465',
'71467',
'71469',
'71472',
'71479',
'71484',
'71496',
'71507',
'71509',
'71510',
'71525',
'71530',
'71551',
'71555',
'71622',
'71737',
'71875',
'71948',
'71952',
'71975',
'71992',
'72016',
'72036',
'72049',
'72116'
	   
	   )
