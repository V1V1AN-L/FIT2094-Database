--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T2-mns-insert.sql

--Student ID: 25348914
--Student Name: Zecan Liu
--Unit Code: FIT2094
--Applied Class No: A04

/* Comments for your marker:




*/

--------------------------------------
--INSERT INTO emergency_contact
--------------------------------------
INSERT INTO emergency_contact VALUES (
    1,
    'San',
    'Zhang',
    '0451111111'
);

INSERT INTO emergency_contact VALUES (
    2,
    'Si',
    'Li',
    '0452222222'
);

INSERT INTO emergency_contact VALUES (
    3,
    'Wu',
    'Wang',
    '0454545645'
);

INSERT INTO emergency_contact VALUES (
    4,
    'Neng',
    'Liu',
    '0458978612'
);

INSERT INTO emergency_contact VALUES (
    5,
    'Tie',
    'Niu',
    '0453357545'
);


--------------------------------------
--INSERT INTO patient
--------------------------------------
INSERT INTO patient VALUES (
    1,
    'Kui',
    'Li',
    '1 alma rd',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('01-Jan-2010', 'dd-Mon-yyyy'),
    '0478515285',
    'helloworld@gmail.com',
    1
);

INSERT INTO patient VALUES (
    2,
    'Jiang',
    'Song',
    '2 liangshan rd',
    'Sydney',
    'NSW',
    '2000',
    TO_DATE('25-Dec-2011', 'dd-Mon-yyyy'),
    '0458123456',
    'nihao@gmail.com',
    1
);

INSERT INTO patient VALUES (
    3,
    'Song',
    'Wu',
    '3 rose rd',
    'Perth',
    'WA',
    '6000',
    TO_DATE('05-May-2012', 'dd-Mon-yyyy'),
    '0436915765',
    'xixihaha@gmail.com',
    1
);

INSERT INTO patient VALUES (
    4,
    'Chong',
    'Lin',
    '4 lily rd',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('10-Oct-2014', 'dd-Mon-yyyy'),
    '0421369741',
    'bilibala@gmail.com',
    2
);

INSERT INTO patient VALUES (
    5,
    'Zhishen',
    'Lu',
    '5 albert rd',
    'Melbourne',
    'VIC',
    '3000',
    TO_DATE('08-Jan-2015', 'dd-Mon-yyyy'),
    '0478456129',
    'wuwulala@gmail.com',
    2
);

INSERT INTO patient VALUES (
    6,
    'Zhi',
    'Yang',
    '6 england rd',
    'Melbourne',
    'VIC',
    '3010',
    TO_DATE('01-Mar-1990', 'dd-Mon-yyyy'),
    '0473514829',
    'zhiyang@gmail.com',
    2
);

INSERT INTO patient VALUES (
    7,
    'Yong',
    'Wu',
    '7 glen rd',
    'Melbourne',
    'VIC',
    '3015',
    TO_DATE('31-Jan-1992', 'dd-Mon-yyyy'),
    '0452000111',
    'yongwu@gmail.com',
    2
);

INSERT INTO patient VALUES (
    8,
    'Gai',
    'Chao',
    '8 sydney rd',
    'Melbourne',
    'VIC',
    '3150',
    TO_DATE('21-Feb-1993', 'dd-Mon-yyyy'),
    '0410360580',
    'gaichao@gmail.com',
    4
);

INSERT INTO patient VALUES (
    9,
    'Sheng',
    'Gongsun',
    '9 clifford rd',
    'Melbourne',
    'VIC',
    '3017',
    TO_DATE('11-May-1994', 'dd-Mon-yyyy'),
    '0410201708',
    'shenggongsun@gmail.com',
    3
);

INSERT INTO patient VALUES (
    10,
    'Rong',
    'Hua',
    '10 hallows st',
    'Brisbane',
    'QLD',
    '4000',
    TO_DATE('17-Oct-1995', 'dd-Mon-yyyy'),
    '0429887501',
    'ronghua@gmail.com',
    5
);


--------------------------------------
--INSERT INTO appointment
--------------------------------------
INSERT INTO appointment VALUES (
    1,
    TO_DATE('01-May-2023 17:00', 'dd-Mon-yyyy HH24:MI'),
    1,
    'S',
    1,
    'END001',
    1,
    NULL
);

INSERT INTO appointment VALUES (
    2,
    TO_DATE('02-May-2023 11:00', 'dd-Mon-yyyy HH24:MI'),
    2,
    'T',
    2,
    'PER001',
    2,
    NULL
);

INSERT INTO appointment VALUES (
    3,
    TO_DATE('03-May-2023 09:00', 'dd-Mon-yyyy HH24:MI'),
    3,
    'T',
    3,
    'AST002',
    3,
    NULL
);

INSERT INTO appointment VALUES (
    4,
    TO_DATE('04-May-2023 16:00', 'dd-Mon-yyyy HH24:MI'),
    4,
    'L',
    4,
    'PER002',
    4,
    NULL
);

INSERT INTO appointment VALUES (
    5,
    TO_DATE('05-May-2023 15:00', 'dd-Mon-yyyy HH24:MI'),
    5,
    'S',
    5,
    'PED002',
    5,
    NULL
);

INSERT INTO appointment VALUES (
    6,
    TO_DATE('01-Jun-2023 10:00', 'dd-Mon-yyyy HH24:MI'),
    1,
    'S',
    6,
    'GEN003',
    6,
    NULL
);

INSERT INTO appointment VALUES (
    7,
    TO_DATE('02-Jun-2023 11:00', 'dd-Mon-yyyy HH24:MI'),
    2,
    'L',
    7,
    'ORS001',
    7,
    NULL
);

INSERT INTO appointment VALUES (
    8,
    TO_DATE('03-Jun-2023 09:00', 'dd-Mon-yyyy HH24:MI'),
    3,
    'T',
    8,
    'PED001',
    8,
    NULL
);

INSERT INTO appointment VALUES (
    9,
    TO_DATE('04-Jun-2023 14:00', 'dd-Mon-yyyy HH24:MI'),
    4,
    'S',
    9,
    'END001',
    9,
    NULL
);

INSERT INTO appointment VALUES (
    10,
    TO_DATE('05-Jun-2023 15:00', 'dd-Mon-yyyy HH24:MI'),
    5,
    'L',
    10,
    'PED002',
    10,
    NULL
);

INSERT INTO appointment VALUES (
    11,
    TO_DATE('01-Jul-2023 13:00', 'dd-Mon-yyyy HH24:MI'),
    1,
    'S',
    1,
    'END001',
    11,
    1
);

INSERT INTO appointment VALUES (
    12,
    TO_DATE('02-Jul-2023 13:00', 'dd-Mon-yyyy HH24:MI'),
    2,
    'T',
    10,
    'PED002',
    12,
    10
);

INSERT INTO appointment VALUES (
    13,
    TO_DATE('03-Jul-2023 13:00', 'dd-Mon-yyyy HH24:MI'),
    3,
    'S',
    8,
    'PED001',
    13,
    8
);

INSERT INTO appointment VALUES (
    14,
    TO_DATE('04-Jul-2023 13:00', 'dd-Mon-yyyy HH24:MI'),
    4,
    'L',
    2,
    'AST001',
    14,
    NULL
);

INSERT INTO appointment VALUES (
    15,
    TO_DATE('04-Jul-2023 13:00', 'dd-Mon-yyyy HH24:MI'),
    5,
    'T',
    3,
    'ORT001',
    15,
    NULL
);

COMMIT;