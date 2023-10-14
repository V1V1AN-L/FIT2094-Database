/******PLEASE ENTER YOUR DETAILS BELOW******/
/*T3-mns-dm.sql*/

/*Student ID: 25348914*/
/*Student Name: Zecan Liu*/
/*Unit Code: FIT2094*/
/*Applied Class No: A04*/

/* Comments for your marker:


*/

/*3(a)*/
DROP SEQUENCE ec_seq;

DROP SEQUENCE patient_seq;

DROP SEQUENCE appt_seq;

CREATE SEQUENCE ec_seq START WITH 100 INCREMENT BY 5;

CREATE SEQUENCE patient_seq START WITH 100 INCREMENT BY 5;

CREATE SEQUENCE appt_seq START WITH 100 INCREMENT BY 5;

/*3(b)*/
INSERT INTO emergency_contact VALUES (
    ec_seq.NEXTVAL,
    'Jonathan',
    'Robey',
    '0412523122'
);

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Laura',
    'Robey',
    '12 moverly rd',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('05-May-2016', 'dd-Mon-yyyy'),
    '0412523122',
    'laurarobey@gmail.com',
    (
        SELECT
            ec_id
        FROM
            emergency_contact
        WHERE
            ec_phone = '0412523122'
    )
);

INSERT INTO appointment VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('04-Sep-2023 15:30', 'dd-Mon-yyyy HH24:MI'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    patient_seq.CURRVAL,
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);

COMMIT;

INSERT INTO patient VALUES (
    patient_seq.NEXTVAL,
    'Lachlan',
    'Robey',
    '12 moverly rd',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('21-Sep-2017', 'dd-Mon-yyyy'),
    '0412523122',
    'lachlanrobey@gmail.com',
    (
        SELECT
            ec_id
        FROM
            emergency_contact
        WHERE
            ec_phone = '0412523122'
    )
);

INSERT INTO appointment VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('04-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'S',
    patient_seq.CURRVAL,
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    6,
    NULL
);

COMMIT;

/*3(c)*/
INSERT INTO appointment VALUES (
    appt_seq.NEXTVAL,
    TO_DATE('14-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI'),
    (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    'T',
    (
        SELECT
            patient_no
        FROM
                 patient p
            NATURAL JOIN emergency_contact e
        WHERE
                upper(p.patient_fname) = upper('Lachlan')
            AND e.ec_phone = '0412523122'
    ),
    (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ),
    14,
    (
        SELECT
            appt_no
        FROM
            appointment
        WHERE
                appt_datetime = TO_DATE('04-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI')
            AND appt_roomno = (
                SELECT
                    provider_roomno
                FROM
                    provider
                WHERE
                        upper(provider_title) = upper('Dr')
                    AND upper(provider_fname) = upper('Bruce')
                    AND upper(provider_lname) = upper('STRIPLIN')
            )
            AND patient_no = (
                SELECT
                    patient_no
                FROM
                         patient p
                    NATURAL JOIN emergency_contact e
                WHERE
                        upper(p.patient_fname) = upper('Lachlan')
                    AND e.ec_phone = '0412523122'
            )
            AND provider_code = (
                SELECT
                    provider_code
                FROM
                    provider
                WHERE
                        upper(provider_title) = upper('Dr')
                    AND upper(provider_fname) = upper('Bruce')
                    AND upper(provider_lname) = upper('STRIPLIN')
            )
            AND appt_prior_apptno IS NULL
    )
);

COMMIT;

/*3(d)*/

UPDATE appointment
SET
    appt_datetime = TO_DATE('18-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI')
WHERE
        appt_datetime = TO_DATE('14-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI')
    AND appt_roomno = (
        SELECT
            provider_roomno
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    )
    AND patient_no = (
        SELECT
            patient_no
        FROM
                 patient p
            NATURAL JOIN emergency_contact e
        WHERE
                upper(p.patient_fname) = upper('Lachlan')
            AND e.ec_phone = '0412523122'
    )
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    ) and appt_prior_apptno =     (
        SELECT
            appt_no
        FROM
            appointment
        WHERE
                appt_datetime = TO_DATE('04-Sep-2023 16:00', 'dd-Mon-yyyy HH24:MI')
            AND appt_roomno = (
                SELECT
                    provider_roomno
                FROM
                    provider
                WHERE
                        upper(provider_title) = upper('Dr')
                    AND upper(provider_fname) = upper('Bruce')
                    AND upper(provider_lname) = upper('STRIPLIN')
            )
            AND patient_no = (
                SELECT
                    patient_no
                FROM
                         patient p
                    NATURAL JOIN emergency_contact e
                WHERE
                        upper(p.patient_fname) = upper('Lachlan')
                    AND e.ec_phone = '0412523122'
            )
            AND provider_code = (
                SELECT
                    provider_code
                FROM
                    provider
                WHERE
                        upper(provider_title) = upper('Dr')
                    AND upper(provider_fname) = upper('Bruce')
                    AND upper(provider_lname) = upper('STRIPLIN')
            )
            AND appt_prior_apptno IS NULL
    );

COMMIT;

/*3(e)*/
DELETE FROM appointment
WHERE
    appt_datetime BETWEEN TO_DATE('15-Sep-2023', 'dd-Mon-yyyy') AND TO_DATE('22-Sep-2023'
    , 'dd-Mon-yyyy')
    AND provider_code = (
        SELECT
            provider_code
        FROM
            provider
        WHERE
                upper(provider_title) = upper('Dr')
            AND upper(provider_fname) = upper('Bruce')
            AND upper(provider_lname) = upper('STRIPLIN')
    );

COMMIT;