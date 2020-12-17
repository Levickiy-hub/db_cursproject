CREATE OR REPLACE PACKAGE OBS_PACK AS
Procedure CAR_BY_ID --���� � ���������� ����
(ID_CAR1 IN INT);
Procedure CAR_BY_USER
(ID_USER1 IN INT);
Procedure CARS_BY_BRAND
(BRAND1 IN VARCHAR2);
Procedure CARS_BY_MODEL
(MODEL1 IN VARCHAR2);
Procedure COMMENT_CAR
(ID_CAR1 IN INT);
Procedure COMMENT_SPARE
(ID_SPARE1 IN INT);
Procedure DEL_PICTURE
(ID_PIC1 IN INT);
Procedure DEL_CAR
(ID_CAR1 IN INT);
Procedure DEL_SPARE
(ID_SPARE1 IN INT);
Procedure GET_CARS;
Procedure GET_SPARES;
Procedure LOGIN_IN
(LOGIN1 IN USERS_.LOGIN%TYPE,PASSWORD1 IN USERS_.PASSWORD%TYPE);
Procedure PICTURE_BY_CAR
(ID_CAR1 IN INT);
PROCEDURE PICTURE_BY_SPARES
(ID_SPARE1 IN INT);
Procedure POST_BY_ID -- ���������� ��������� �� �����
(ID_POST1 IN INT);
Procedure POST_BY_USER
(ID_USER1 IN INT);
Procedure SPARE_BY_USER
(ID_USER1 IN INT);
Procedure SPARES_BY_ID --���� � ���������� ������
(IDS IN INT);
Procedure USER_BY_ID
(IDU IN INT);
Procedure USERS_CONTACTS
(ID_USER1 IN INT);
END OBS_PACK;
-------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY OBS_PACK  AS
 Procedure CAR_BY_ID --���� � ���������� ����
(ID_CAR1 IN INT)
 IS
CURSOR GET_CAR IS
       SELECT ID_CAR,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,CAR.PRICE,CAR.DESCRIPTION_CAR  FROM CAR,USERS_,MODEL_,BRAND WHERE CAR.ID_USER = USERS_.ID_USER AND MODEL_.ID_MODEL=CAR.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND CAR.ID_CAR =ID_CAR1;
  U GET_CAR%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_CAR;
LOOP  
EXIT WHEN GET_CAR%NOTFOUND;
     FETCH GET_CAR INTO U;
     IF GET_CAR%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_CAR|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.DESCRIPTION_CAR|| ' '||U.PRICE);
PICTURE_BY_CAR(U.ID_CAR);
comment_car(U.ID_CAR);
END IF;
END LOOP;
CLOSE GET_CAR;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure CAR_BY_USER
(ID_USER1 IN INT)
 IS
 CURSOR GET_COMMENT IS
        SELECT ID_CAR,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,CAR.PRICE,CAR.DESCRIPTION_CAR  FROM CAR,USERS_,MODEL_,BRAND WHERE CAR.ID_USER = USERS_.ID_USER AND MODEL_.ID_MODEL=CAR.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND  AND CAR.ID_USER = ID_USER1;
  U GET_COMMENT%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_COMMENT;
LOOP  
EXIT WHEN GET_COMMENT%NOTFOUND;
     FETCH GET_COMMENT INTO U;
     IF GET_COMMENT%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_CAR|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.DESCRIPTION_CAR|| ' '||U.PRICE);
PICTURE_BY_CAR(U.ID_CAR);
comment_car(U.ID_CAR);
END IF;
END LOOP;
CLOSE GET_COMMENT;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure CARS_BY_BRAND
(BRAND1 IN VARCHAR2)
 IS
CURSOR GET_CAR IS
        SELECT ID_CAR,PRICE,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND  FROM CAR,USERS_,MODEL_,BRAND WHERE CAR.ID_USER = USERS_.ID_USER AND MODEL_.ID_MODEL=CAR.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND BRAND.BRAND LIKE UPPER(BRAND1);
  U GET_CAR%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_CAR;
LOOP  
EXIT WHEN GET_CAR%NOTFOUND;
     FETCH GET_CAR INTO U;
     IF GET_CAR%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_CAR|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.PRICE);
END IF;
END LOOP;
CLOSE GET_CAR;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure CARS_BY_MODEL
(MODEL1 IN VARCHAR2)
 IS
CURSOR GET_CAR IS
        SELECT ID_CAR,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND  FROM CAR,USERS_,MODEL_,BRAND WHERE CAR.ID_USER = USERS_.ID_USER AND MODEL_.ID_MODEL=CAR.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND MODEL_.MODEL_ LIKE UPPER(MODEL1);
  U GET_CAR%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_CAR;
LOOP  
EXIT WHEN GET_CAR%NOTFOUND;
     FETCH GET_CAR INTO U;
     IF GET_CAR%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_CAR|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND);
END IF;
END LOOP;
CLOSE GET_CAR;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure COMMENT_CAR
(ID_CAR1 IN INT)
 IS
 CURSOR GET_COMMENT IS
        SELECT ID_COMMENT,ID_USER,COMMENT_ FROM COMMENT_ WHERE ID_CAR=ID_CAR1;
  U GET_COMMENT%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_COMMENT;
LOOP  
EXIT WHEN GET_COMMENT%NOTFOUND;
     FETCH GET_COMMENT INTO U;
     IF GET_COMMENT%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_COMMENT||' '||U.ID_USER||' '||U.COMMENT_);
END IF;
END LOOP;
CLOSE GET_COMMENT;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure COMMENT_SPARE
(ID_SPARE1 IN INT)
 IS
 CURSOR GET_COMMENT IS
        SELECT ID_COMMENT,ID_USER,COMMENT_ FROM COMMENT_ WHERE ID_SPARE=ID_SPARE1;
  U GET_COMMENT%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_COMMENT;
LOOP  
EXIT WHEN GET_COMMENT%NOTFOUND;
     FETCH GET_COMMENT INTO U;
     IF GET_COMMENT%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_COMMENT||' '||U.ID_USER||' '||U.COMMENT_);
END IF;
END LOOP;
CLOSE GET_COMMENT;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure DEL_PICTURE
(ID_PIC1 IN INT)
 IS
BEGIN
DELETE PICTURES WHERE ID_PICTURE = ID_PIC1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure DEL_SPARE
(ID_SPARE1 IN INT)
 IS
BEGIN
DELETE SPARES WHERE ID_SPARES = ID_SPARE1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure DEL_CAR
(ID_CAR1 IN INT)
 IS
BEGIN
DELETE CAR WHERE ID_CAR = ID_CAR1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure GET_CARS -- ���� � ���� ����
 IS
CURSOR GET_CAR IS
        SELECT ID_CAR,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND  FROM CAR,USERS_,MODEL_,BRAND WHERE CAR.ID_USER = USERS_.ID_USER AND MODEL_.ID_MODEL=CAR.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND;
  U GET_CAR%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_CAR;
LOOP  
EXIT WHEN GET_CAR%NOTFOUND;
     FETCH GET_CAR INTO U;
     IF GET_CAR%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_CAR|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND);
END IF;
END LOOP;
CLOSE GET_CAR;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure GET_SPARES -- ���� � ���� �������
 IS
CURSOR GET_SPARE IS
        SELECT SPARES.SPARES, ID_SPARES,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,PRICE  FROM SPARES,USERS_,MODEL_,BRAND WHERE USERS_.ID_USER = SPARES.ID_USER AND MODEL_.ID_MODEL=SPARES.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND;
  U GET_SPARE%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_SPARE;
LOOP  
EXIT WHEN GET_SPARE%NOTFOUND;
     FETCH GET_SPARE INTO U;
     IF GET_SPARE%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_SPARES|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.SPARES|| ' ' ||U.PRICE);
END IF;
END LOOP;
CLOSE GET_SPARE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure PICTURE_BY_CAR
(ID_CAR1 IN INT)
 IS
CURSOR GET_PICTURE IS
        SELECT ID_PICTURE,PICTURE FROM PICTURES WHERE ID_CAR=ID_CAR1;
  U GET_PICTURE%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_PICTURE;
LOOP  
EXIT WHEN GET_PICTURE%NOTFOUND;
     FETCH GET_PICTURE INTO U;
     IF GET_PICTURE%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_PICTURE);
END IF;
END LOOP;
CLOSE GET_PICTURE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure PICTURE_BY_SPARES
(ID_SPARE1 IN INT)
 IS
CURSOR GET_PICTURE IS
        SELECT ID_PICTURE,PICTURE FROM PICTURES WHERE ID_SPARE=ID_SPARE1;
  U GET_PICTURE%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_PICTURE;
LOOP  
EXIT WHEN GET_PICTURE%NOTFOUND;
     FETCH GET_PICTURE INTO U;
     IF GET_PICTURE%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_PICTURE);
END IF;
END LOOP;
CLOSE GET_PICTURE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure POST_BY_ID -- ���������� ��������� �� �����
(ID_POST1 IN INT)
IS
CURSOR GET_POST IS
        SELECT * FROM POST WHERE ID_POST = ID_POST1;
  U GET_POST%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_POST;
LOOP  
EXIT WHEN GET_POST%NOTFOUND;
     FETCH GET_POST INTO U;
     IF GET_POST%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_POST|| ' ' || U.ID_AUTO|| ' ' ||U.ID_SPARES|| ' ' ||U.POST);
END IF;
END LOOP;
CLOSE GET_POST;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
 Procedure POST_BY_USER
(ID_USER1 IN INT)
IS
CURSOR GET_POST IS
        SELECT * FROM POST WHERE ID_USER = ID_USER1;
  U GET_POST%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_POST;
LOOP  
EXIT WHEN GET_POST%NOTFOUND;
     FETCH GET_POST INTO U;
     IF GET_POST%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_POST|| ' ' || U.ID_AUTO|| ' ' ||U.ID_SPARES|| ' ' ||U.POST);
END IF;
END LOOP;
CLOSE GET_POST;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure SPARE_BY_USER
(ID_USER1 IN INT)
IS
CURSOR GET_SPARE IS
        SELECT SPARES.SPARES, ID_SPARES,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,PRICE  FROM SPARES,USERS_,MODEL_,BRAND WHERE USERS_.ID_USER = SPARES.ID_USER AND MODEL_.ID_MODEL=SPARES.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND SPARES.ID_USER=ID_USER1;
  U GET_SPARE%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_SPARE;
LOOP  
EXIT WHEN GET_SPARE%NOTFOUND;
     FETCH GET_SPARE INTO U;
     IF GET_SPARE%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_SPARES|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.SPARES|| ' ' ||U.PRICE);
END IF;
END LOOP;
CLOSE GET_SPARE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure SPARES_BY_ID --���� � ���������� ������
(IDS IN INT)
 IS
CURSOR GET_SPARE IS
        SELECT SPARES.SPARES, ID_SPARES,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,SPARES.PRICE  FROM SPARES,USERS_,MODEL_,BRAND WHERE USERS_.ID_USER = SPARES.ID_USER AND MODEL_.ID_MODEL=SPARES.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND SPARES.ID_SPARES = IDS;
  U GET_SPARE%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_SPARE;
LOOP  
EXIT WHEN GET_SPARE%NOTFOUND;
     FETCH GET_SPARE INTO U;
     IF GET_SPARE%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_SPARES|| ' ' || U.NAME|| ' ' ||U.MODEL_|| ' ' ||U.BRAND||' '||U.SPARES|| ' ' ||U.PRICE);
picture_by_spares(U.ID_SPARES);
comment_spare(U.ID_SPARES);
END IF;
END LOOP;
CLOSE GET_SPARE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure USER_BY_ID
(IDU IN INT)
 IS
CURSOR GET_USER IS
        SELECT ID_USER,NAME,LOGIN,PRIVILEGE_ FROM USERS_  WHERE  USERS_.ID_USER=IDU; --�������� 
  U GET_USER%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_USER;
LOOP  
EXIT WHEN GET_USER%NOTFOUND;
     FETCH GET_USER INTO U;
     IF GET_USER%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.NAME|| ' ' || U.LOGIN|| ' ' ||U.PRIVILEGE_||' '||U.ID_USER);
USERS_CONTACTS(U.ID_USER);
END IF;
END LOOP;
CLOSE GET_USER;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure USERS_CONTACTS
(ID_USER1 IN INT)
 IS
CURSOR get_contacts IS
        SELECT name,contact FROM USERS_, CONTACTS WHERE USERS_.ID_USER= CONTACTS.ID_USER AND USERS_.ID_USER = ID_USER1;
  U GET_CONTACTS%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_CONTACTS;
LOOP  
EXIT WHEN get_CONTACTS%NOTFOUND;
     FETCH GET_CONTACTS INTO U;
     IF GET_CONTACTS%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.CONTACT|| ' ' || U.NAME);
END IF;
END LOOP;
CLOSE GET_CONTACTS;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
Procedure LOGIN_IN
(LOGIN1 IN USERS_.LOGIN%TYPE,PASSWORD1 IN USERS_.PASSWORD%TYPE)
 IS
CURSOR GET_USER IS
        SELECT ID_USER FROM USERS_ WHERE LOGIN=LOGIN1 AND PASSWORD = PASSWORD1;
  U GET_USER%ROWTYPE; 
BEGIN
BEGIN
OPEN GET_USER;
LOOP  
EXIT WHEN GET_USER%NOTFOUND;
     FETCH GET_USER INTO U;
     IF GET_USER%FOUND THEN
USER_BY_ID(U.ID_USER);
ELSE
DBMS_OUTPUT.PUT_LINE('NOT FOUND');
END IF;
END LOOP;
CLOSE GET_USER;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
END OBS_PACK;