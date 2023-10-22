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
    nvl(provider_title, '')
    || '.'
    || nvl(provider_fname, '')
    || ' '
    || nvl(provider_lname, '') AS provider_name --name  probably needs to be changed
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
    to_char(service_stdfee, '$999990.99') AS service_stdfee     --999?990?
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
    service_stdfee DESC,
    service_code;
    
    
    
    
/*2(d)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    a.appt_no,
    to_char(a.appt_datetime, 'dd-Mon-yyyy') AS appt_datetime,
    a.patient_no,
    nvl(patient_fname, '')
    || ' '
    || nvl(patient_lname, '')               AS patient_fullname,
    to_char(SUM(nvl(apptserv_fee, 0) + nvl(apptserv_itemcost, 0)),
            '$999999.99')                   AS appt_totalcost
FROM
         mns.appointment a
    JOIN mns.appt_serv s
    ON a.appt_no = s.appt_no
    JOIN mns.patient   p
    ON a.patient_no = p.patient_no
GROUP BY
    a.appt_no,
    to_char(a.appt_datetime, 'dd-Mon-yyyy'),
    a.patient_no,
    nvl(patient_fname, '')
    || ' '
    || nvl(patient_lname, '')
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
    appt_no;

--nvl usage??

/*2(e)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SELECT
    s.service_code,
    s.service_desc,
    s.service_stdfee AS "standard fee",
    CASE
        WHEN AVG(a.apptserv_fee) - s.service_stdfee > 0 THEN
            lpad('+'
                 || to_char(AVG(a.apptserv_fee) - s.service_stdfee,
                            '$999999.99'),
                 12)
        ELSE
            lpad(to_char(AVG(a.apptserv_fee) - s.service_stdfee,
                         '$999999.99'),
                 12)
    END              AS "differential"
FROM
         mns.appt_serv a
    JOIN mns.service s
    ON a.service_code = s.service_code
GROUP BY
    s.service_code,
    s.service_desc,
    s.service_stdfee
ORDER BY
    s.service_code;


--change the format later



/*2(f)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT FOR THIS PART HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
SELECT
    p.patient_no,
    p.patient_fname
    || ' '
    || p.patient_lname                                 AS patientname,
    trunc(months_between(sysdate, p.patient_dob) / 12) AS currentage,
    nvl(ap.total_appointments, 0)                      AS numappts,
    CASE
        WHEN nvl(100 *(ap.followup_appointments / ap.total_appointments), 0) = 0 THEN
            lpad('0.0%', 9)
        ELSE
            lpad(to_char(nvl(100 *(ap.followup_appointments / ap.total_appointments),
            0),
                         '999.9')
                 || '%',
                 9)
    END                                                AS followups
FROM
    mns.patient p
    LEFT OUTER JOIN (
        SELECT
            a.patient_no,
            COUNT(*) AS total_appointments,
            SUM(
                CASE
                    WHEN a.appt_prior_apptno IS NOT NULL THEN
                        1
                    ELSE
                        0
                END
            )        AS followup_appointments
        FROM
            mns.appointment a
        GROUP BY
            a.patient_no
    )           ap
    ON p.patient_no = ap.patient_no;



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