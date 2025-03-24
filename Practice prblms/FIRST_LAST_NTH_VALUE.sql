CREATE TABLE TEST3
(
    ID INT,
    STATE VARCHAR2(20),
    SALE_DATE DATE,
    SALES NUMBER(4)
);

DESC TEST3;

INSERT INTO TEST3 VALUES(&ID,'&STATE','&SALE_DATE',&SALES);

SELECT * FROM TEST3;

DELETE FROM TEST3 WHERE ID=17;


SELECT ID,STATE,SALE_DATE,SALES,FIRST_VALUE(SALES) OVER(ORDER BY SALE_DATE) AS
FIRST_VALUE FROM TEST3;

SELECT ID,STATE,SALE_DATE,SALES,LAST_VALUE(SALES) OVER(ORDER BY SALE_DATE ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING) AS LAST_VALUE FROM TEST3;

SELECT ID,STATE,SALE_DATE,SALES,NTH_VALUE(SALES,8) OVER(ORDER BY SALE_DATE) AS
FIRST_VALUE FROM TEST3;