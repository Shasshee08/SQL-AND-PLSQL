---Finding Factorial Using Recursion

CREATE OR REPLACE FUNCTION FACTORIAL(N NUMBER) 
RETURN NUMBER IS
BEGIN   
    IF N=0 THEN
    RETURN 1;
    ELSE 
    RETURN N * FACTORIAL(N-1);
    END IF;
    END;
    /
    
    SELECT FACTORIAL(6) FROM DUAL;