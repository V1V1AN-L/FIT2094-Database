--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-select.sql

--Student ID: 25348914
--Student Name: Zecan Liu
--Unit Code: FIT2094
--Applied Class No: Applied04

/* Comments for your marker:




*/


/*2(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    item_id,
    item_desc,
    item_stdcost,
    item_stock
FROM
    mns.item
WHERE
        item_stock >= 50
    AND upper(item_desc) LIKE upper('%composite%')
ORDER BY
    item_stock DESC,
    item_id; 


/*2(b)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    provider_code,
    TRIM(nvl(provider_title, '') --trim remove leading and trailing blanks
         ||
         CASE
             WHEN provider_title IS NOT NULL THEN
                 '. '
             ELSE
                 ''
         END
         || nvl(provider_fname, '')
         ||
         CASE
             WHEN provider_fname IS NOT NULL THEN
                 ' '
             ELSE
                 ''
         END
         || nvl(provider_lname, '')) AS provider_name
FROM
         mns.provider p
    JOIN mns.specialisation s
    ON p.spec_id = s.spec_id
WHERE
    upper(spec_name) = upper('PAEDIATRIC DENTISTRY')
ORDER BY
    provider_lname,
    provider_fname,
    provider_code;


/*2(c)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    service_code,
    service_desc,
    lpad(to_char(service_stdfee, '$999990.00'),
         12) AS standard_fee
FROM
    mns.service
WHERE
    service_stdfee > (
        SELECT
            AVG(service_stdfee)
        FROM
            mns.service
    )
ORDER BY
    standard_fee DESC,
    service_code;
    
    
    
    
/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    a.appt_no,
    to_char(a.appt_datetime, 'dd-Mon-yyyy hh:mi:ss AM') AS appt_date_time,
    a.patient_no,
    TRIM(nvl(patient_fname, '')
         || ' '
         || nvl(patient_lname, ''))                          AS patient_fullname,
    lpad(to_char(SUM(nvl(apptserv_fee, 0) + nvl(apptserv_itemcost, 0)),
                 '$999990.00'),
         15)                                            AS appt_total_cost
FROM
         mns.appointment a
    JOIN mns.appt_serv s
    ON a.appt_no = s.appt_no
    JOIN mns.patient   p
    ON a.patient_no = p.patient_no
GROUP BY
    a.appt_no,
    a.appt_datetime,
    a.patient_no,
    TRIM(nvl(patient_fname, '')
         || ' '
         || nvl(patient_lname, ''))
HAVING
    SUM(nvl(apptserv_fee, 0) + nvl(apptserv_itemcost, 0)) = (
        SELECT
            MAX(SUM(nvl(apptserv_fee, 0) + nvl(apptserv_itemcost, 0)))
        FROM
            mns.appt_serv
        GROUP BY
            appt_no
    )
ORDER BY
    a.appt_no;



/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    a.service_code,
    service_desc,
    to_char(service_stdfee, '$999990.00') AS service_standard_fee,
    to_char(AVG(a.apptserv_fee) - service_stdfee,
            '$999990.00')                 AS service_fee_differential
FROM
         mns.appt_serv a
    JOIN mns.service s
    ON a.service_code = s.service_code
GROUP BY
    a.service_code,
    service_desc,
    service_stdfee
ORDER BY
    a.service_code;



/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    p.patient_no,
    TRIM(nvl(patient_fname, '')
         || ' '
         || nvl(patient_lname, ''))                       AS patientname,
    trunc(months_between(sysdate, patient_dob) / 12) AS currentage,
    COUNT(appt_no)                                   AS numappts,
    lpad(to_char(100 *(COUNT(appt_prior_apptno) / COUNT(appt_no)),
                 '990.0')
         || '%',
         9)                                          AS followups
FROM
    mns.patient     p
    LEFT OUTER JOIN mns.appointment a
    ON p.patient_no = a.patient_no
GROUP BY
    p.patient_no,
    TRIM(nvl(patient_fname, '')
         || ' '
         || nvl(patient_lname, '')),
    trunc(months_between(sysdate, patient_dob) / 12)
ORDER BY
    p.patient_no;
    
    
    
/*2(g)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    p.provider_code,
    COUNT(a.provider_code)  AS numberappts,
    lpad(nvl(to_char(SUM(s.apptserv_fee),
                     '$999999.99'),
             '-'),
         12)                AS totalfees,
    SUM(i.as_item_quantity) AS noitems
FROM
    mns.provider         p
    LEFT OUTER JOIN mns.appointment      a
    ON p.provider_code = a.provider_code
    LEFT OUTER JOIN mns.appt_serv        s
    ON a.appt_no = s.appt_no
    LEFT OUTER JOIN mns.apptservice_item i
    ON a.appt_no = i.appt_no
GROUP BY
    p.provider_code;