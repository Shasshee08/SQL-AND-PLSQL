---Improve join performance between orders and customer.

SELECT * FROM CUSTOMER;

SELECT * FROM ORDERS;

SELECT /*+ INDEX (ORDERS IDX_ORDERS_CUSTKEY) */
    C.C_NAME,
    O.O_ORDERDATE
FROM
    CUSTOMER C
JOIN ORDERS O ON C.C_CUSTKEY=O.O_CUSTKEY
WHERE o.o_orderdate BETWEEN DATE '1995-01-01' AND DATE '1995-12-31';


---==== INDEX CREATION
CREATE INDEX IDX_ORDERS_CUSTKEY ON ORDERS(O_CUSTKEY);