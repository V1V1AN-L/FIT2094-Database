-- Task 1: Add a new column to the UNIT table for credit points
ALTER TABLE UNIT
ADD credit_points NUMBER(2) DEFAULT 6 CHECK (credit_points IN (3, 6, 12));

-- Task 2: Create a new table for course details
CREATE TABLE COURSE (
    course_code VARCHAR2(10),
    course_name VARCHAR2(100),
    course_totalpoints NUMBER(3)
);
alter table course add constraint course_pk primary key (course_code);

-- Task 3: Create a linking table to represent the many-to-many relationship between units and courses
CREATE TABLE UNIT_COURSE (
    unit_id NUMBER,
    course_code VARCHAR2(10),
    CONSTRAINT fk_unit FOREIGN KEY (unit_id) REFERENCES UNIT(unit_id),
    CONSTRAINT fk_course FOREIGN KEY (course_code) REFERENCES COURSE(course_code)
);

-- Example course data insertion
INSERT INTO COURSE (course_code, course_name, course_totalpoints)
VALUES ('C2000', 'Bachelor of Information Technology', 144);

INSERT INTO COURSE (course_code, course_name, course_totalpoints)
VALUES ('C2001', 'Bachelor of Computer Science', 144);

INSERT INTO COURSE (course_code, course_name, course_totalpoints)
VALUES ('C4001', 'Graduate Certificate of Cybersecurity', 24);

-- Continue inserting data for other courses as needed

-- Example unit-course relationship insertion
INSERT INTO UNIT_COURSE (unit_id, course_code)
SELECT unit_id, 'C2000' FROM UNIT WHERE unit_code IN ('FIT1047', 'FIT1045');

INSERT INTO UNIT_COURSE (unit_id, course_code)
SELECT unit_id, 'C2001' FROM UNIT WHERE unit_code IN ('FIT1047', 'FIT1045');

-- Continue inserting unit-course relationships for other courses and units as needed
