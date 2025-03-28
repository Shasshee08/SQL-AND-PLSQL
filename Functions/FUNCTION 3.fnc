---Function to Get Employee Salary
CREATE OR REPLACE FUNCTION GET_SALARY(F_EMPNO NUMBER)
RETURN NUMBER
IS
    EMP_SAL NUMBER;
BEGIN
    SELECT SAL INTO EMP_SAL FROM EMP_LARGE WHERE EMPNO=F_EMPNO;
    RETURN EMP_SAL;
END;

SELECT GET_SALARY(1234) FROM DUAL;