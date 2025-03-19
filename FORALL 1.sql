DECLARE
    TYPE EMP_TABLE IS TABLE OF EMP_LARGE%ROWTYPE;
    EMP_DATA EMP_TABLE;
    
    ERROR_COUNT NUMBER;
    ERROR_MESSAGE VARCHAR2(4000);
    
BEGIN
    SELECT * BULK COLLECT INTO EMP_DATA FROM EMP_LARGE;
    
    FORALL I IN EMP_DATA.FIRST ..EMP_DATA.LAST
    SAVE EXCEPTIONS
    INSERT INTO EMP_BACKUP VALUES EMP_DATA(I);
    
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE INSERTED SUCCESFULLY');
EXCEPTION
    WHEN OTHERs THEN
       ERROR_COUNT :=SQL%BULK_EXCEPTIONS.COUNT;
       DBMS_OUTPUT.PUT_LINE('TOTAL ERRORS: ' ||ERROR_COUNT);
       
       FOR i IN 1 .. error_count LOOP
            error_message := SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE);
            DBMS_OUTPUT.PUT_LINE('Error at index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX || ': ' || error_message);
        END LOOP;
END;

---===================================
DECLARE
    TYPE EMP_ID IS TABLE OF EMP_LARGE.EMPNO%TYPE;
    EMP_IDS EMP_ID;
    
    BEGIN
    SELECT EMPNO BULK COLLECT INTO EMP_IDS FROM EMP_LARGE;
    
    FORALL I IN EMP_IDS.FIRST ..EMP_IDS.LAST
    SAVE EXCEPTIONS
    UPDATE EMP_LARGE
    SET SAL=SAL*1.10
    WHERE EMPNO=EMP_IDS(I);
    
    DBMS_OUTPUT.PUT_LINE('Salaries updated successfully.');
    
EXCEPTION
    WHEN OTHERS THEN
        -- Handle Errors
        FOR i IN 1 .. SQL%BULK_EXCEPTIONS.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('Error at index ' || SQL%BULK_EXCEPTIONS(i).ERROR_INDEX || ': ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
        END LOOP;
END;

---=========================
---=============FORALL with UPDATE===============
DECLARE
    TYPE EMP_SAL IS TABLE OF EMP_LARGE.SAL%TYPE;
    EMP_SALS EMP_SAL;
BEGIN
    SELECT SAL BULK COLLECT INTO EMP_SALS FROM EMP_LARGE WHERE DEPTNO=11;
        
   FORALL I IN EMP_SALS.FIRST .. EMP_SALS.LAST
   UPDATE EMP_LARGE SET SAL=SAL*1.10 WHERE SAL=EMP_SALS(I);
   
   DBMS_OUTPUT.PUT_LINE('SALARIES UPDATED SUCCESSFULLY');
END;
/

---=====================================
---Copy employee data from EMP to EMP_BACKUP.
DESC EMP_BACKUP;

SELECT * FROM EMP_BACKUP;

    CREATE TABLE EMP_BACKUP AS
    SELECT * FROM EMP_LARGE WHERE 1=0;
    
DECLARE
    type EMP_TABLE IS TABLE OF EMP_LARGE%ROWTYPE;
    EMP_DATA EMP_TABLE;
BEGIN
    SELECT * BULK COLLECT INTO EMP_DATA FROM EMP_LARGE;
    
    FORALL I IN  EMP_DATA.FIRST .. EMP_DATA.LAST
        INSERT INTO EMP_BACKUP VALUES EMP_DATA(I);
        DBMS_OUTPUT.PUT_LINE('Employee data copied successfully.');
END;
/

---=================================
--- Increase salaries of employees in DEPTNO = 20 by 15%.
DECLARE
    TYPE EMP_SAL IS TABLE OF EMP_LARGE.SAL%TYPE;
    EMP_SALS EMP_SAL;
 BEGIN
    SELECT SAL BULK COLLECT INTO EMP_SALS FROM EMP_LARGE WHERE DEPTNO=20;
    
    FORALL I IN EMP_SALS.FIRST .. EMP_SALS.LAST
        UPDATE EMP_LARGE SET SAL=SAL*1.15 WHERE EMPNO=EMP_SALS(I);
            DBMS_OUTPUT.PUT_LINE('Salaries updated successfully for DEPT 20.');
END;
/


---================
---Fetch large employee records in batches of 100
DECLARE
    TYPE EMP_TABLE IS TABLE OF EMP_LARGE%ROWTYPE;
    EMP_DATA EMP_TABLE;
    CURSOR C1 IS SELECT * FROM EMP_LARGE;
    BATCH_SIZE CONSTANT NUMBER:=100;
    BEGIN
        OPEN C1;
        LOOP
            FETCH C1 BULK COLLECT INTO EMP_DATA LIMIT BATCH_SIZE;
            EXIT WHEN EMP_DATA.COUNT=0;
            FOR I IN Emp_Data.FIRST .. Emp_Data.LAST
        LOOP
            DBMS_OUTPUT.PUT_LINE('Processing Employee: ' || Emp_Data(I).EMPNO);
        END LOOP;
    END LOOP;
    CLOSE C1;
END;
/