--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T4-mns-alter.sql

--Student ID: 25348914
--Student Name: Zecan Liu
--Unit Code: FIT2094
--Applied Class No: A04

/* Comments for your marker:




*/

--4(a)

ALTER TABLE patient ADD (
    patient_appt_amount NUMBER(3, 0)
);

COMMENT ON COLUMN patient.patient_appt_amount IS
    'total number of appointments for this patient in the system';

DESC patient;

SELECT
    patient_no,
    nvl(patient_appt_amount, 0) AS "Patient Appt Amount"
FROM
    patient;

UPDATE patient p
SET
    patient_appt_amount = (
        SELECT
            COUNT(*)
        FROM
            appointment a
        WHERE
            a.patient_no = p.patient_no
    );

COMMIT;

SELECT
    patient_no,
    nvl(patient_appt_amount, 0) AS "Patient Appt Amount"
FROM
    patient;



--4(b)
DROP TABLE patient_ec_record CASCADE CONSTRAINTS PURGE;

CREATE TABLE patient_ec_record (
    patient_no NUMBER(4) NOT NULL,
    ec_id      NUMBER(4) NOT NULL
);

COMMENT ON COLUMN patient_ec_record.patient_no IS
    'patient id number';

COMMENT ON COLUMN patient_ec_record.ec_id IS
    'emergency contact id number';

ALTER TABLE patient_ec_record ADD CONSTRAINT p_ec_pk PRIMARY KEY ( patient_no,
                                                                   ec_id );

ALTER TABLE patient_ec_record
    ADD CONSTRAINT patient_pec_fk FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE patient_ec_record
    ADD CONSTRAINT ec_pec_fk FOREIGN KEY ( ec_id )
        REFERENCES emergency_contact ( ec_id );

desc patient_ec_record;


--4(c)
DROP TABLE training_record CASCADE CONSTRAINTS PURGE;

DROP TABLE training_course CASCADE CONSTRAINTS PURGE;

CREATE TABLE training_course (
    training_course_id NUMBER(3) NOT NULL,
    nurse_no           NUMBER(3) NOT NULL,
    tc_starttime       DATE NOT NULL,
    tc_endtime         DATE NOT NULL,
    tc_description     VARCHAR2(100)
);

COMMENT ON COLUMN training_course.nurse_no IS
    'trainer nurse id';

COMMENT ON COLUMN training_course.training_course_id IS
    'training course id';

COMMENT ON COLUMN training_course.tc_starttime IS
    'training course start datetime';

COMMENT ON COLUMN training_course.tc_endtime IS
    'training course end datetime';

COMMENT ON COLUMN training_course.tc_description IS
    'training course description';

ALTER TABLE training_course ADD CONSTRAINT tc_pk PRIMARY KEY ( training_course_id );

ALTER TABLE training_course
    ADD CONSTRAINT uq_tc UNIQUE ( nurse_no,
                                  tc_starttime,
                                  tc_endtime );

CREATE TABLE training_record (
    nurse_no           NUMBER(3) NOT NULL,
    training_course_id NUMBER(3) NOT NULL
);

COMMENT ON COLUMN training_record.nurse_no IS
    'trainee nurse id';

COMMENT ON COLUMN training_record.training_course_id IS
    'training course id';

ALTER TABLE training_record ADD CONSTRAINT tr_pk PRIMARY KEY ( nurse_no,
                                                               training_course_id );

ALTER TABLE training_course
    ADD CONSTRAINT nurse_tc_fk FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE training_record
    ADD CONSTRAINT nurse_tr_fk FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE training_record
    ADD CONSTRAINT course_tr_fk FOREIGN KEY ( training_course_id )
        REFERENCES training_course ( training_course_id );