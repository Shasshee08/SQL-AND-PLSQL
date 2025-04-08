---Total Revenue per Region in 1994

SELECT
    R.R_NAME AS REGION_NAME,
    SUM(L.L_EXTENDEDPRICE * (1 - L.L_DISCOUNT)) AS TOTAL_REVENUE
FROM
    LINEITEM L
JOIN
    ORDERS O ON L.L_ORDERKEY = O.O_ORDERKEY
JOIN
    CUSTOMER C ON O.O_CUSTKEY = C.C_CUSTKEY
JOIN
    NATION N ON C.C_NATIONKEY = N.N_NATIONKEY
JOIN
    REGION R ON N.N_REGIONKEY = R.R_REGIONKEY
WHERE
    O.O_ORDERDATE BETWEEN DATE '1994-01-01' AND DATE '1994-12-31'
GROUP BY
    R.R_NAME
ORDER BY
    TOTAL_REVENUE DESC;
