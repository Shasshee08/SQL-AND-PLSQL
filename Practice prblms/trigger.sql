CREATE TABLE SAL_AUDIT(
    EMPNO NUMBER,
    OLD_SAL NUMBER,
    NEW_SAL NUMBER,
    MODIFIED_AT DATE
);

SELECT * FROM EMP_LARGE WHERE EMPNO=1234;

UPDATE EMP_LARGE SET SAL=4500 WHERE EMPNO=1234;

SELECT * FROM SAL_AUDIT;

SELECT * FROM EMP_LARGE WHERE EMPNO=122;

DELETE FROM EMP_LARGE WHERE EMPNO=122;