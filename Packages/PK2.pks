CREATE OR REPLACE PACKAGE PK2
IS
    A NUMBER:= 2000;
    PROCEDURE SP1;
    FUNCTION SF1(X NUMBER) RETURN NUMBER;
END PK2;

--============BODY
CREATE OR REPLACE PACKAGE BODY PK2
IS
    PROCEDURE SP1
    IS  
       X  NUMBER;
    BEGIN
           X:=A/2;
           DBMS_OUTPUT.PUT_LINE('HALF OF A: '|| X);
    END SP1;

    FUNCTION SF1(X NUMBER) RETURN NUMBER
    IS
    BEGIN
            RETURN X * A;
    END SF1;
END PK2;       

--==============
EXEC PK2.SP1;

SELECT PK2.SF1(10) FROM DUAL;