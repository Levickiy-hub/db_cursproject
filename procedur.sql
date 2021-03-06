create or replace Procedure ADD_BRAND -- ���������� ������ ������
 (BRAND IN VARCHAR2)
 IS 
 ID_BRAND INT;
 BEGIN 
 SELECT BRAND_S.NEXTVAL INTO ID_BRAND  FROM dual;
 INSERT INTO BRAND
 ( ID_BRAND, BRAND)
 VALUES
 (ID_BRAND,UPPER(BRAND));
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

CREATE or replace Procedure ADD_CAR --���������� ������ ����
(ID_USER IN INT, DESCRIPTION_CAR IN VARCHAR2,PRICE IN INT, MODEL1  IN VARCHAR2, ID_PIC INT DEFAULT 0)
 IS 
 ID_CAR INT;
 ID_MODEL1 INT;
 BEGIN 
 SELECT CAR_S.NEXTVAL INTO ID_CAR  FROM dual;
 SELECT ID_MODEL INTO ID_MODEL1 FROM MODEL_ WHERE MODEL_.MODEL_ LIKE UPPER(MODEL1);
 INSERT INTO CAR
 ( ID_CAR, ID_USER,ID_MODEL,ID_PIC,DESCRIPTION_CAR,PRICE)
 VALUES
 (ID_CAR,ID_USER,ID_MODEL1,ID_PIC,description_car,PRICE);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_CONTACT--���������� ���������
 (CONTACT IN VARCHAR2,ID_USER IN VARCHAR2)
 IS 
 ID_CONTACT INT;
 BEGIN 
 SELECT CONTACT_S.NEXTVAL INTO ID_CONTACT  FROM dual;
 INSERT INTO CONTACTS
 ( ID_CONTACTS, CONTACT, ID_USER)
 VALUES
 (ID_CONTACT,CONTACT,ID_USER);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_COMMENT --���������� ������ �������
(ID_USER IN INT, COMMENT1 IN VARCHAR2, ID_CAR1 IN INT,ID_SPARE1 IN INT )
 IS 
 ID_COMMENT INT;
 BEGIN 
 SELECT COMMENT_S.NEXTVAL INTO ID_COMMENT  FROM dual;
 INSERT INTO COMMENT_
 ( ID_COMMENT, ID_USER,ID_CAR,ID_SPARE,COMMENT_)
 VALUES
 (ID_COMMENT,ID_USER,ID_CAR1,ID_SPARE1,COMMENT1);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_MODEL --���������� ����� ������
 (MODEL_ IN VARCHAR2, BRAND1 IN BRAND.BRAND%TYPE)
 IS 
 ID_MODEL INT;
 ID_BRAND INT;
 BEGIN 
 SELECT MODEL_S.NEXTVAL INTO ID_MODEL  FROM dual;
 SELECT ID_BRAND INTO ID_BRAND FROM BRAND WHERE BRAND like UPPER(BRAND1);
 INSERT INTO MODEL_
 ( ID_MODEL, MODEL_,ID_BRAND)
 VALUES
 (ID_MODEL,UPPER(MODEL_),ID_BRAND);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_POST --���������� ������ ��������� �� ������
(ID_USER IN INT, ID_AUTO IN  INT,ID_SPARES IN INT, POST IN VARCHAR2)
 IS 
 ID_POST INT;
 BEGIN 
 SELECT POST_S.NEXTVAL INTO ID_POST  FROM dual;
 INSERT INTO POST
 ( ID_POST, ID_USER,ID_AUTO,ID_SPARES,POST)
 VALUES
 (ID_POST,ID_USER,ID_AUTO,ID_SPARES,POST);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_SAVED --���������� � ���������� 
(ID_USER IN INT, ID_CAR IN  INT,ID_SPARE IN INT,DATE1 IN DATE)
 IS 
 ID_SAVED INT;
 BEGIN 
 SELECT SAVED_S.NEXTVAL INTO ID_SAVED  FROM dual;
 INSERT INTO SAVED
 ( ID_SAVED, ID_USER,ID_CAR,ID_SPARE, DATE_)
 VALUES
 (ID_SAVED,ID_USER,ID_CAR,ID_SPARE,DATE1);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_SPARES --���������� ��������
(ID_USER IN INT, SPARES IN VARCHAR2,PRICE IN INT, MODEL1  IN VARCHAR2, ID_PIC INT DEFAULT 0)
 IS 
 ID_SPARES INT;
 ID_MODEL1 INT;
 BEGIN 
 SELECT SPARE_S.NEXTVAL INTO ID_SPARES  FROM dual;
 SELECT ID_MODEL INTO ID_MODEL1 FROM MODEL_ WHERE MODEL_.MODEL_ LIKE UPPER(MODEL1);
 INSERT INTO SPARES
 ( ID_SPARES, ID_USER,ID_MODEL,ID_PIC,SPARES,PRICE)
 VALUES
 (ID_SPARES,ID_USER,ID_MODEL1,ID_PIC,SPARES,PRICE);
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure ADD_USER --���������� ������ �����\�����������
 (LOGIN IN VARCHAR2,PASSWORD IN VARCHAR2,NAME IN VARCHAR2)
 IS 
 ID_USER INT;
 BEGIN 
 SELECT USER_S.NEXTVAL INTO ID_USER  FROM dual;
 INSERT INTO Users_
 ( ID_USER, LOGIN, PASSWORD,NAME,PRIVILEGE_)
 VALUES
 (ID_USER,LOGIN,PASSWORD,NAME,'USER');
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure CAR_BY_USER--����� ���� ����������� ������������
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

create or replace  Procedure CARS_BY_BRAND --����� ���� �� ������
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

create or replace  Procedure CARS_BY_MODEL --����� ���� �� �������
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

create or replace Procedure COMMENT_CAR --�������� �������� � ��������� ������
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

create or replace Procedure COMMENT_SPARE --����������� � ���������� ��������
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

create or replace Procedure DEL_CAR -- �������� ������
(ID_CAR1 IN INT)
 IS
BEGIN
DELETE CAR WHERE ID_CAR = ID_CAR1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure DEL_PICTURE --�������� �����������
(ID_PIC1 IN INT)
 IS
BEGIN
DELETE PICTURES WHERE ID_PICTURE = ID_PIC1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure DEL_SPARE--�������� ������ 
(ID_SPARE1 IN INT)
 IS
BEGIN
DELETE SPARES WHERE ID_SPARES = ID_SPARE1;
COMMIT;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure LOGIN_IN --��������� �������� �����
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

create or replace Procedure PICTURE_BY_CAR -- �������� � ���������� ������ 
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
DBMS_OUTPUT.PUT_LINE(U.ID_PICTURE||' '||U.PICTURE);
END IF;
END LOOP;
CLOSE GET_PICTURE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure PICTURE_BY_SPARES -- �������� � ���������� ������
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
DBMS_OUTPUT.PUT_LINE(U.ID_PICTURE||' '||U.PICTURE);
END IF;
END LOOP;
CLOSE GET_PICTURE;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure POST_BY_ID -- ���������� ��������� �� �����
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
--
create or replace Procedure POST_BY_USER -- ��� ��������� ��� ����������� ������������
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

create or replace Procedure SPARE_BY_USER --������ ����������� ������������
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

create or replace Procedure UPDATE_CAR -- ���������� ��� ��� ����
(DES IN VARCHAR2,NEWPRICE IN INT, IC IN INT )
IS 
 BEGIN 
 IF DES IS NULL THEN
 UPDATE CAR 
 SET PRICE=NEWPRICE WHERE ID_CAR =IC;
 ELSIF DES IS NULL THEN
 UPDATE CAR 
 SET DESCRIPTION_CAR=DES WHERE ID_CAR =IC;
 ELSE
  UPDATE CAR 
 SET DESCRIPTION_CAR=DES,PRICE =NEWPRICE WHERE ID_CAR =IC;
 END IF;
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure UPDATE_SPARES-- ���������� ��� ��� ������
(DES IN VARCHAR2,NEWPRICE IN INT, IDS IN INT )
IS 
 BEGIN 
 IF DES IS NULL THEN
 UPDATE SPARES 
 SET PRICE=NEWPRICE WHERE ID_SPARES =IDS;
 ELSIF DES IS NULL THEN
 UPDATE SPARES 
 SET SPARES=DES WHERE ID_SPARES =IDS;
 ELSE
  UPDATE SPARES 
 SET SPARES=DES,PRICE =NEWPRICE WHERE ID_SPARES =IDS;
 END IF;
 COMMIT;
 EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure USER_BY_ID -- ���������� � ���������� ������������
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

create or replace Procedure USERS_CONTACTS -- �������� ����������� ������������
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

create or replace  Procedure CAR_BY_ID --���� � ���������� ����
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

create or replace  Procedure GET_CARS -- ���� � ���� ����
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
--
create or replace  Procedure GET_SPARES -- ���� � ���� �������
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

create or replace  Procedure GET_USERS--���� � ���� �������������
 IS
CURSOR USERS_ IS
        SELECT * FROM USERS_;
  U USERS_%ROWTYPE; 
BEGIN
BEGIN
OPEN USERS_;
LOOP  
EXIT WHEN USERS_%NOTFOUND;
     FETCH USERS_ INTO U;
     IF USERS_%FOUND THEN
DBMS_OUTPUT.PUT_LINE(U.ID_USER|| ' ' || U.NAME|| ' ' ||U.LOGIN);
END IF;
END LOOP;
CLOSE USERS_;
END;
EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;

create or replace Procedure SPARES_BY_ID --���� � ���������� ������
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

create or replace Procedure SPARES_BY_MODEL -- ������ ������ �� ������ 
(MODEL1 IN MODEL_.MODEL_%TYPE)
 IS
CURSOR GET_SPARE IS
        SELECT SPARES.SPARES, ID_SPARES,USERS_.NAME,MODEL_.MODEL_,BRAND.BRAND,SPARES.PRICE  FROM SPARES,USERS_,MODEL_,BRAND
        WHERE USERS_.ID_USER = SPARES.ID_USER AND MODEL_.ID_MODEL=SPARES.ID_MODEL AND BRAND.ID_BRAND = MODEL_.ID_BRAND AND MODEL_.MODEL_ LIKE UPPER(MODEL1);
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