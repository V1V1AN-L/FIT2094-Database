/*
Databases Week 11 Applied Class
week11_sql_advanced.sql

student id: 
student name:
last modified date:

*/
/*1*/
/*
Assuming that the student name is unique, display Claudette Serman’s academic record.
Include the unit code, unit name, year, semester, mark and explained_grade in the listing. The
Explained Grade column must show Fail for N, Pass for P, Credit for C, Distinction for D and High
Distinction for HD. Order by year, within the same year order the list by semester, and within the
same semester order the list by the unit code.
*/
SELECT
    unitcode,
    unitname,
    to_char(ofyear, 'yyyy') AS year,
    ofsemester,
    enrolmark,
    CASE upper(enrolgrade)
        WHEN 'N'  THEN
            'Fail'
        WHEN 'P'  THEN
            'Pass'
        WHEN 'C'  THEN
            'Credit'
        WHEN 'D'  THEN
            'Distinction'
        WHEN 'HD' THEN
            'High Distinction'
    END                     AS explained_grade
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
WHERE
    stuid = (
        SELECT
            stuid
        FROM
            uni.student
        WHERE
                upper(stufname) = upper('Claudette')
            AND upper(stulname) = upper('Serman')
    )
ORDER BY
    year,
    ofsemester,
    unitcode;

/*2*/
/*
Find the number of scheduled classes assigned to each staff member for each semester in
2019. If the number of classes is 2 then this should be labelled as a correct load, more than 2 as
an overload and less than 2 as an underload. Include the staff id, staff first name, staff last name,
semester, number of scheduled classes and load in the listing. Sort the list by decreasing order of
the number of scheduled classes and when the number of classes is the same, sort by the staff id
then by the semester
*/
SELECT
    unitcode,
    unitname,
    to_char(ofyear, 'yyyy')    AS year,
    ofsemester,
    enrolmark,
    decode(upper(enrolgrade),
           'N',
           'Fail',
           'P',
           'Pass',
           'C',
           'Credit',
           'D',
           'Distinction',
           'HD',
           'High Distinction') AS explained_grade
FROM
         uni.enrolment
    NATURAL JOIN uni.unit
WHERE
    stuid = (
        SELECT
            stuid
        FROM
            uni.student
        WHERE
                upper(stufname) = upper('Claudette')
            AND upper(stulname) = upper('Serman')
    )
ORDER BY
    year,
    ofsemester,
    unitcode;

/*3*/
/*Find the total number of prerequisite units for all units. Include in the list the unit code of units
that do not have a prerequisite. Order the list in descending order of the number of prerequisite
units and where several units have the same number of prerequisites order then by unit code*/

/*4 Display the unit code and unit name for units that do not have a prerequisite. Order the list by
unit code. There are many approaches that you can take in writing an SQL statement to answer
this query. You can use the SET OPERATORS, OUTER JOIN and a SUBQUERY. Write SQL
statements based on all three approaches.*/

 /* Using MINUS*/

/* Using outer join */
SELECT
    u.unitcode,
    u.unitname
FROM
    uni.unit   u
    LEFT JOIN uni.prereq p
    ON u.unitcode = p.unitcode
WHERE
    p.unitcode IS NULL
ORDER BY
    u.unitcode;

/* Using set operator MINUS */
SELECT
    unitcode,
    unitname
FROM
    uni.unit
MINUS
SELECT
    unitcode,
    unitname
FROM
         uni.prereq
    NATURAL JOIN uni.unit;

/* Using subquery */
SELECT
    unitcode,
    unitname
FROM
    uni.unit
WHERE
    unitcode NOT IN (
        SELECT
            unitcode
        FROM
            uni.prereq
    );

/*5*/

/*6*/

/*7*/

/*8 Given that the payment rate for a tutorial is $42.85 per hour and the payment rate for a lecture is
$75.60 per hour, calculate the weekly payment per type of class for each staff member in semester
1 2020. In the display, include staff id, staff name, type of class (lecture - L or tutorial - T), number
of classes, number of hours (total duration), and weekly payment (number of hours * payment
rate). The weekly payment must be displayed to two decimal points and right aligned. Order the list
by the staff id and for a given staff id by the type of class*/
SELECT
    s.staffid,
    s.stafffname,
    s.stafflname,
    c.cltype,
    COUNT(*) AS number_of_classes,
    SUM(c.clduration) AS total_duration,
    to_char(SUM(c.clduration) * 
          CASE WHEN c.cltype = 'L' THEN 75.60
               WHEN c.cltype = 'T' THEN 42.85
               ELSE 0
          END, '$99999.99') AS weekly_payment
FROM
    uni.staff s
JOIN
    uni.schedclass c
ON
    s.staffid = c.staffid
WHERE
    c.ofsemester = 1 and to_char(c.ofyear, 'yyyy') = '2020' 
GROUP BY
    s.staffid, s.stafffname, s.stafflname, c.cltype
ORDER BY
    s.staffid, c.cltype;

    
/*9*/

    
/*10*/