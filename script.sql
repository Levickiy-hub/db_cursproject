set serveroutput on format wraped;



BEGIN
C##SUPER.OBS_PACK.LOGIN_IN(10000,10000);
C##SUPER.USER_PACK.ADD_CAR(5555,'33!33', 3000,'Hunter%',3);
C##SUPER.OBS_PACK.GET_CARS;
C##SUPER.user_PACK.add_comment(50,'work!!',12,null);
C##SUPER.OBS_PACK.CAR_BY_ID(12);
C##SUPER.USER_PACK.ADD_CONTACT(777,10000);
C##SUPER.USER_PACK.ADD_SPARES(600,'SPARE', 20000,'Bonus 3%',3);
C##SUPER.OBS_PACK.SPARES_BY_ID(1);
END;
SELECT * FROM USERS_;
SELECT * FROM CAR;
SELECT * FROM COMMENT_;
SELECT * FROM SPARES;
BEGIN 
FOR I IN 20389..100000
LOOP
ADD_USER(I,I,I);
END LOOP;
END;


BEGIN
C##SUPER.OBS_PACK.LOGIN_IN('ADMIN','ADMIN');
C##SUPER.OBS_PACK.GET_CARS;
C##SUPER.ADMIN_PACK.ADD_POST(91,6,NULL,'MESSEGE');
c##super.XML_PACKAGE.EXPORT_BRAND_TO_XML;
END;


BEGIN
C##SUPER.USER_PACK.ADD_CAR(1010,'RX', 30000,'RX-5%',3);
C##SUPER.USER_PACK.ADD_SAVED(1010, 20,NULL,'14-12-2020');
C##SUPER.USER_PACK.USER_SAVED(1010);
DBMS_OUTPUT.PUT_LINE('-----');
C##SUPER.OBS_PACK.GET_CARS;
C##SUPER.USER_PACK.ADD_COMMENT(1010, 'COOL!',20,NULL);
C##SUPER.OBS_PACK.CAR_BY_ID(20);
DBMS_OUTPUT.PUT_LINE('-----');
C##SUPER.OBS_PACK.COMMENT_CAR(20);
DBMS_OUTPUT.PUT_LINE('-----');
C##SUPER.USER_PACK.UPDATE_CAR(50000, NULL,20);
C##SUPER.OBS_PACK.COMMENT_CAR(20);
DBMS_OUTPUT.PUT_LINE('-----');
C##SUPER.OBS_PACK.CARS_BY_BRAND('MAZDA%');
DBMS_OUTPUT.PUT_LINE('-----');
C##SUPER.OBS_PACK.CARS_BY_MODEL('CX-5%');
END;

BEGIN C##SUPER.USER_PACK.ADD_PICTURE('IMG_0402.jpg',NULL,NULL);END;