SELECT * FROM DbIp_Lookup_Educa;


DELETE FROM DbIp_Lookup_Educa WHERE ipv6 = 1;


ALTER TABLE DbIp_Lookup_Educa
ADD COLUMN ip_start_num bigint;

ALTER TABLE DbIp_Lookup_Educa
ADD COLUMN ip_end_num bigint;




# template
SELECT LOCATE('.', look.ip_start),
       LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1),
       LOCATE('.', look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1),
       look.id
FROM DbIp_Lookup_Educa AS look
         LIMIT 500;


#template 2 🤢
SELECT LEFT(look.ip_start, LOCATE('.', look.ip_start) - 1),
       LEFT(MID(look.ip_start, LOCATE('.', look.ip_start) + 1), LOCATE('.', MID(look.ip_start, LOCATE('.', look.ip_start) + 1)) - 1),
       LEFT(MID(look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1), LOCATE('.', MID(look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1)) - 1),
       MID(look.ip_start,LOCATE('.', look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1) + 1)
FROM DbIp_Lookup_Educa AS look
LIMIT 500;


SELECT LEFT(look.ip_start, LOCATE('.', look.ip_start) - 1) * POWER(10, 9) +
       LEFT(MID(look.ip_start, LOCATE('.', look.ip_start) + 1), LOCATE('.', MID(look.ip_start, LOCATE('.', look.ip_start) + 1)) - 1) * POWER(10, 6) +
       LEFT(MID(look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1), LOCATE('.', MID(look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1)) - 1) * POWER(10,3) +
       CAST(MID(look.ip_start,LOCATE('.', look.ip_start, LOCATE('.', look.ip_start, LOCATE('.', look.ip_start) + 1) + 1) + 1) AS INT )
FROM DbIp_Lookup_Educa AS look;



UPDATE DbIp_Lookup_Educa
SET ip_start_num = LEFT(DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) - 1) * POWER(10, 9) +
                   LEFT(MID(DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) + 1), LOCATE('.', MID(DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) + 1)) - 1) * POWER(10, 6) +
                   LEFT(MID(DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) + 1) + 1), LOCATE('.', MID(DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) + 1) + 1)) - 1) * POWER(10,3) +
                   CAST(MID(DbIp_Lookup_Educa.ip_start,LOCATE('.', DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start, LOCATE('.', DbIp_Lookup_Educa.ip_start) + 1) + 1) + 1) AS INT );

UPDATE DbIp_Lookup_Educa
SET ip_end_num = LEFT(DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) - 1) * POWER(10, 9) +
                   LEFT(MID(DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) + 1), LOCATE('.', MID(DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) + 1)) - 1) * POWER(10, 6) +
                   LEFT(MID(DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) + 1) + 1), LOCATE('.', MID(DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) + 1) + 1)) - 1) * POWER(10,3) +
                   CAST(MID(DbIp_Lookup_Educa.ip_end,LOCATE('.', DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end, LOCATE('.', DbIp_Lookup_Educa.ip_end) + 1) + 1) + 1) AS INT );



CREATE INDEX ip
ON DbIp_Lookup_Educa (ip_start_num);

CREATE INDEX ipEnd
ON DbIp_Lookup_Educa (ip_end_num);


#finalni dotaz ~160 ms
SELECT country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_start_num < 1000000020 AND ip_end_num > 1000000020;



SELECT country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_start_num < 223183188027 AND ip_end_num > 223183188027;


SELECT country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_start_num < 30040026007 AND ip_end_num > 30040026007;


# prej 2 query jsou rychlejsi nez 1
SELECT id, country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_start_num < 30040026007 ORDER BY ip_start_num DESC LIMIT 1;
SELECT id, country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_end_num > 30040026007 ORDER BY ip_end_num ASC LIMIT 1;


#nejfinalnejsi dotaz
SELECT country, city, stateprov, ip_end_num FROM DbIp_Lookup_Educa
WHERE ip_start_num <= 223183188027 ORDER BY ip_start_num DESC LIMIT 1;


#nejfinalnejsi dotaz
SELECT country, city, stateprov, ip_end_num FROM DbIp_Lookup_Educa
WHERE ip_start_num <= 30145037080 ORDER BY ip_start_num DESC LIMIT 1;


SELECT country, city, stateprov FROM DbIp_Lookup_Educa
WHERE ip_start_num < 30145037080 AND ip_end_num > 30145037080;


