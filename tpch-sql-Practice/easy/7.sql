---List all suppliers that belong to nations in the 'EUROPE' region.

SELECT * FROM SUPPLIER;

SELECT * FROM REGION;

SELECT * FROM NATION;

--========
SELECT
    S.S_SUPPKEY,
    S.S_NAME,
    S.S_PHONE,
    N.N_NAME,
    R.R_NAME
FROM 
    SUPPLIER S
JOIN 
    NATION N ON S.S_NATIONKEY=N.N_NATIONKEY
JOIN
    REGION R ON N.N_REGIONKEY=R.R_REGIONKEY
WHERE
    R.R_NAME='EUROPE'
ORDER BY
    S.S_SUPPKEY;
