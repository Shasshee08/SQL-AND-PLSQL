---Evaluate performance difference between bitmap and b-tree indexes on a low-cardinality column: customer.c_mktsegment

SELECT * FROM CUSTOMER;

SELECT
    C_MKTSEGMENT,COUNT(*)
FROM
    CUSTOMER
GROUP BY C_MKTSEGMENT;

SELECT INDEX_NAME FROM USER_INDEXES WHERE TABLE_NAME='CUSTOMER';

DROP INDEX IDX_CUSTOMER_SEGMENT_BTREE;

CREATE BITMAP INDEX IDX_CUSTOMER_SEGMENT_BITMAP ON CUSTOMER(C_MKTSEGMENT);

SELECT COUNT(*) FROM CUSTOMER WHERE C_MKTSEGMENT='BUILDING';

EXPLAIN PLAN FOR 
SELECT COUNT(*) FROM CUSTOMER WHERE C_MKTSEGMENT='BUILDING';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

DROP INDEX IDX_CUSTOMER_SEGMENT_BITMAP;

CREATE INDEX IDX_CUSTOMER_SEGMENT_BTREE ON CUSTOMER(C_MKTSEGMENT);