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

/* B1 List all the unit codes, semesters and name of chief examiners (ie. the staff who is
responsible for the unit) for all the units that are offered in 2021. Order the output by
semester then by unit code.*/

SELECT
    unitcode,
    ofsemester,
    stafffname,
    stafflname
FROM
         uni.offering o
    JOIN uni.staff s
    ON o.staffid = s.staffid
WHERE
    to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    ofsemester,
    unitcode;
    
    
/* B2 List all unit codes, unit names and their year and semester of offering. Order the output by
unit code then by offering year and then semester.*/
SELECT
    u.unitcode,
    unitname,
    to_char(ofyear, 'yyyy'),
    ofsemester
FROM
         uni.offering o
    JOIN uni.unit u
    ON o.unitcode = u.unitcode
ORDER BY
    unitcode,
    ofyear,
    ofsemester;
    
    
/* B3 List the student id, student name (firstname and surname) as one attribute and the unit name
of all enrolments for semester 1 of 2021. Order the output by unit name, within a given unit
name, order by student id.*/

SELECT
    s.stuid,
    stufname
    || ' '
    || stulname AS student_name,
    unitname
FROM
         uni.enrolment e
    JOIN uni.student s
    ON s.stuid = e.stuid
    JOIN uni.unit    u
    ON u.unitcode = e.unitcode
WHERE
        ofsemester = 1
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    unitname,
    stuid;
    
    
/* B4 List the id and full name of all students who have marks in the range of 80 to 100 in FIT9132
semester 2 of 2019. Order the output by full name. If there are more than one student with
the same name, order them based on their id.*/

SELECT
    s.stuid,
    stufname
    || ' '
    || stulname AS student_name
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
        ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2019'
    AND enrolmark BETWEEN 80 AND 100
ORDER BY
    student_name,
    s.stuid;

/* B5 List the unit code, semester, class type (lecture or tutorial), day, time and duration (in
minutes) for all units taught by Windham Ellard in 2021. Sort the list according to the unit
code, within a given unit code, order by offering semester.*/

SELECT
    c.unitcode,
    c.ofsemester,
    c.cltype,
    c.clday,
    c.cltime,
    c.clduration
FROM
         uni.staff s
    JOIN uni.schedclass c
    ON s.staffid = c.staffid
WHERE
        upper(s.stafffname) = 'WINDHAM'
    AND upper(s.stafflname) = 'ELLARD'
    AND to_char(ofyear, 'yyyy') = '2021'
ORDER BY
    ofsemester;

/* B6 Create a study statement for Brier Kilgour. A study statement contains unit code, unit name,
semester and year the study was attempted, the mark and grade. If the mark and/or grade is
unknown, show the mark and/or grade as ‘N/A’. Sort the list by year, then by semester and
unit code.*/

SELECT
    u.unitcode,
    u.unitname,
    ofsemester,
    to_char(ofyear, 'yyyy') as year,
    nvl(to_char(e.enrolmark, '999'), 'N/A') as mark,
    nvl(e.enrolgrade, 'N/A') as Grade
FROM
         uni.enrolment e
    JOIN uni.student s
    ON e.stuid = s.stuid
    JOIN uni.unit    u
    ON e.unitcode = u.unitcode
WHERE
        lower(s.stufname) = 'brier'
    AND lower(s.stulname) = 'kilgour';

/* B7*/

/* B8*/

/* B9*/

/* B10*/