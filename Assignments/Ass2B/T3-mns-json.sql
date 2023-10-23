--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID: 25348914
--Student Name: Zecan Liu
--Unit Code: FIT2094
--Applied Class No: Applied04

/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer

SET PAGESIZE 300

SELECT
        JSON_OBJECT(
            '_id' VALUE a.appt_no,
                    'datetime' VALUE to_char(appt_datetime, 'dd-Mon-yyyy hh:mi:ss AM'
                    ),
                    'provider_code' VALUE a.provider_code,
                    'provider_name' VALUE TRIM(nvl(provider_title, '')
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
                                               || nvl(provider_lname, '')),
                    'item_totalcost' VALUE apptserv_itemcost,
                    'no_of_items' VALUE COUNT(*),
                    'items' VALUE JSON_ARRAYAGG(
                JSON_OBJECT(
                    'id' VALUE s.item_id,
                    'desc' VALUE item_desc,
                    'standardcost' VALUE item_stdcost,
                    'quantity' VALUE as_item_quantity
                )
            )
        FORMAT JSON)
        || ','
FROM
         mns.appointment a
    JOIN mns.provider         p
    ON a.provider_code = p.provider_code
    JOIN (
        SELECT
            appt_no,
            SUM(nvl(apptserv_itemcost, 0)) AS apptserv_itemcost
        FROM
            mns.appt_serv
        GROUP BY
            appt_no
    )                    item_totalcost
    ON a.appt_no = item_totalcost.appt_no
    JOIN mns.apptservice_item s
    ON a.appt_no = s.appt_no
    JOIN mns.item             i
    ON s.item_id = i.item_id
GROUP BY
    a.appt_no,
    appt_datetime,
    a.provider_code,
    provider_title,
    provider_fname,
    provider_lname,
    apptserv_itemcost
ORDER BY
    a.appt_no;