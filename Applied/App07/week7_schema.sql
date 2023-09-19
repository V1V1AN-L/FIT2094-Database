/*
Databases Week 7 Applied Class
week7_schema.sql

Author:

*/
set echo on
spool week7_schema_output.txt
-- 7.2
-- DDL for Student-Unit-Enrolment model (using ALTER TABLE)
--

--
-- Place DROP commands at head of schema file
--

drop table student cascade constraints purge;
drop table unit cascade constraints purge;
drop table enrolment cascade constraints purge;


-- Create Tables
-- Here using both table and column constraints
--

CREATE TABLE student (
    stu_nbr     NUMBER(8) NOT NULL,
    stu_lname   VARCHAR2(50) NOT NULL,
    stu_fname   VARCHAR2(50) NOT NULL,
    stu_dob     DATE NOT NULL
);

COMMENT ON COLUMN student.stu_nbr IS
    'Student number';

COMMENT ON COLUMN student.stu_lname IS
    'Student last name';

COMMENT ON COLUMN student.stu_fname IS
    'Student first name';

COMMENT ON COLUMN student.stu_dob IS
    'Student date of birth';

/* Add STUDENT constraints here */

ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY ( stu_nbr );

-- Condition (a): stu_nbr > 10000000
ALTER TABLE student
ADD CONSTRAINT check_stu_nbr
CHECK (stu_nbr > 10000000);




/* Add UNIT data types here */
CREATE TABLE unit (
    unit_code  CHAR(7) NOT NULL,
    unit_name  VARCHAR2(50) NOT NULL 
);

COMMENT ON COLUMN unit.unit_code IS
    'Unit code';

COMMENT ON COLUMN unit.unit_name IS
    'Unit name';

/* Add UNIT constraints here */
-- Condition (b): unit_name is unique in the UNIT table
ALTER TABLE unit
ADD CONSTRAINT unique_unit_name
UNIQUE (unit_name);


/* Add ENROLMENT attributes and data types here */
CREATE TABLE enrolment (
    stu_nbr         NUMBER(8)   NOT NULL,
    unit_code       CHAR(7)     NOT NULL,
    enrol_year      NUMBER(4)   NOT NULL ,
    enrol_semester  CHAR(1)     NOT NULL,
    enrol_mark      NUMBER(3),
    enrol_grade     CHAR(2)
    
);

COMMENT ON COLUMN enrolment.stu_nbr IS
    'Student number';

COMMENT ON COLUMN enrolment.unit_code IS
    'Unit code';

COMMENT ON COLUMN enrolment.enrol_year IS
    'Enrolment year';

COMMENT ON COLUMN enrolment.enrol_semester IS
    'Enrolment semester';

COMMENT ON COLUMN enrolment.enrol_mark IS
    'Enrolment mark (real)';

COMMENT ON COLUMN enrolment.enrol_grade IS
    'Enrolment grade (letter)';

/* Add ENROLMENT constraints here */
-- Condition (c): enrol_semester can only contain the value of 1 or 2 or 3
alter table enrolment add constraint enrolment_pk primary key (stu_nbr, unit_code, enrol_year, enrol_semester);
alter table enrolment add constraint student_fk foreign key (stu_nbr) REFERENCES student (stu_nbr);

ALTER TABLE enrolment
ADD CONSTRAINT check_enrol_semester
CHECK (enrol_semester IN (1, 2, 3));


spool off
set echo off

