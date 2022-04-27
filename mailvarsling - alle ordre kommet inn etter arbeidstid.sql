use IFSFSMPROD

select * from request_text
where --text like ('%Sunrise, erstatter kobberaksess. Følg rutine for problem-adresse Sunrise, erstatter kobberaksess.%')
created_dttm >= '2022-04-20'
and request_id = '343994'
