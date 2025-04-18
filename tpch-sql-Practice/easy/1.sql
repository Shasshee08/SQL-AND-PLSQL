
--Get a list of customers along with their nation and region names.
SELECT * FROM CUSTOMER;

SELECT * FROM REGION;

SELECT * FROM NATION;

SELECT
 C.C_CUSTKEY,
 C.C_NAME,
 N.N_NAME AS NATION_NAME,
 R.R_NAME AS REGION_NAME 
FROM
 CUSTOMER C
JOIN
    NATION N ON C.C_NATIONKEY=N.N_NATIONKEY
JOIN
    REGION R ON N.N_REGIONKEY=R.R_REGIONKEY
    WHERE R.R_NAME='ASIA'
ORDER BY
    C.C_CUSTKEY;
