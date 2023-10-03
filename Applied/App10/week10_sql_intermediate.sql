/*
Databases Week 10 Applied Class
week10_sql_intermediate.sql

student id: 
student name:
last modified date:

*/

/*1*/
SELECT
    to_char(MAX(enrolmark),
            '990.00') AS max_mark
FROM
    uni.enrolment
WHERE
        upper(unitcode) = upper('FIT9136')
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2019';

/*2*/
SELECT
    to_char(AVG(enrolmark),
            '990.00') AS average_mark
FROM
    uni.enrolment
WHERE
        upper(unitcode) = upper('FIT2094')
    AND ofsemester = 2
    AND to_char(ofyear, 'yyyy') = '2020';

/*3 List the average mark for each offering of FIT9136. A unit offering is an instance of a
particular unit in a particular semester - for example FIT1045 offered in semester 1 of 2019 -
is a unit offering. In the listing, include the year and semester number. Sort the result
according to the year then the semester.*/
SELECT
    to_char(ofyear, 'yyyy') AS year,
    ofsemester,
    to_char(AVG(enrolmark),
            '990.00')       AS average_mark
FROM
    uni.enrolment
WHERE
    upper(unitcode) = upper('FIT9136')
GROUP BY
    to_char(ofyear, 'yyyy'),
    ofsemester
ORDER BY
    year,
    ofsemester;

/*4Find the number of students enrolled in FIT1045 in the year 2019, under the following
conditions (note two separate selects are required):
a. Repeat students are counted multiple times in each semester of 2019
b. Repeat students are only counted once across 2019*/
/* a. */

SELECT
    COUNT(DISTINCT stuid) AS count_repeat_students
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT1045'
    AND to_char(ofyear, 'yyyy') = '2019';

/* b. Repeat students are only counted once across 2019*/
SELECT
    COUNT(DISTINCT stuid) AS count_unique_repeat_students
FROM
    uni.enrolment
WHERE
        unitcode = 'FIT1045'
    AND EXTRACT(YEAR FROM to_char(ofyear, 'yyyy')) = '2019';

/*5*/

/*6*/

/*7 Find the total number of prerequisite units for each unit which has prerequisites. Order the
list by unit code.*/
SELECT
    unitcode,
    COUNT(prerequnitcode) AS num_prereqs
FROM
    uni.prereq
GROUP BY
    unitcode
ORDER BY
    unitcode;

/*8*/

/*9 For each prerequisite unit, calculate how many times it has been used as a prerequisite
(number of times used). In the listing include the prerequisite unit code, the prerequisite unit
name and the number of times used. Sort the output by prerequisite unit code.*/
SELECT
    p.prerequnitcode,
    u.unitname,
    COUNT(p.prerequnitcode) AS num_occurence
FROM
         uni.prereq p
    JOIN uni.unit u
    ON p.prerequnitcode = u.unitcode
GROUP BY
    p.prerequnitcode,
    u.unitname
ORDER BY
    p.prerequnitcode; 

/*10 Display the unit code and unit name of units which had at least 2 students who were granted
a deferred exam (grade is recorded as DEF) in semester 2 2021. Order the list by unit code.*/

/*11 Find the oldest student/s in FIT9132. Display the student’s id, full name and the date of birth.
Sort the list by student id.*/
SELECT
    s.stuid                         AS studentid,
    s.stufname
    || ' '
    || s.stulname                   AS fullname,
    to_char(s.studob, 'dd-mm-yyyy') AS studentdob
FROM
         uni.student s
    JOIN uni.enrolment e
    ON s.stuid = e.stuid
WHERE
        upper(e.unitcode) = upper('FIT9132')
    AND s.studob = (
        SELECT
            MIN(studob)
        FROM
                 uni.enrolment e
            JOIN uni.student s
            ON s.stuid = e.stuid
        WHERE
            upper(e.unitcode) = upper('FIT9132')
    )
ORDER BY
    s.stuid;
/*12*/

/*13*/