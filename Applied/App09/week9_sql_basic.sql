/*
Databases Week 9 Applied Class
week9_sql_basic.sql

student id: 25348914
student name: zecan liu
applied class number: applied 04
last modified date:19/09/2023

*/

/* Part A - Retrieving data from a single table */

/* A1*/
SELECT
    *
FROM
    uni.unit
ORDER BY
    unitcode;

/* A2*/

/* A3*/

/* A4*/
SELECT
    stuid,
    stulname,
    stufname,
    stuaddress
FROM
    uni.student
WHERE
    upper(stulname) LIKE 'S%'
    AND lower(stufname) LIKE '%i%'
ORDER BY
    stuid; /*//students who have a surname starting with the letter S and first name which contains the letter i*/

/* A5*/
SELECT
    *
FROM
    uni.unit
WHERE
    upper(unitcode) LIKE 'FIT1%'
ORDER BY
    unitcode;
    
    
/* A6*/
SELECT
    unitcode,
    ofsemester
FROM
    uni.offering
WHERE
    to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    unitcode,
    ofsemester;
    
/* A7
List the year, semester, and unit code for all units that were offered in either semester 2 of
2019 or semester 2 of 2020. Order the output by year and semester then by unit code. To
display the offering year correctly, use the to_char function.*/

SELECT
    *
FROM
    uni.offering
WHERE
    ( to_char(ofyear, 'yyyy') IN ( '2019', '2020' ) )
    AND ofsemester = 2
ORDER BY
    ofyear,
    ofsemester,
    unitcode;

/* A8 List the student id, unit code and mark for those students who have failed any unit in
semester 2 of 2021. Order the output by student id then order by unit code*/
SELECT
    stuid,
    unitcode,
    enrolmark
FROM
    uni.enrolment
WHERE
        enrolmark < 50
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    stuid,
    unitcode;
    
/* A9*/

/* Part B - Retrieving data from multiple tables */

/* B1*/

/* B2*/

/* B3*/

/* B4*/

/* B5*/

/* B6*/

/* B7*/

/* B8*/

/* B9*/

/* B10*/