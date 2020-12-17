CREATE TABLE CAR (
    id_car int NOT NULL,
    id_user int NULL,
    id_model int NULL,
    id_pic int NULL,
    description_car nchar(13) NULL,
    price int NULL,
    CONSTRAINT PK_car PRIMARY KEY (
    id_car
)
 );
 --DROP TABLE CAR;
ALTER TABLE CAR  ADD  CONSTRAINT FK_car_Model FOREIGN KEY(id_model)
REFERENCES Model_ (id_model);

ALTER TABLE car  ADD  CONSTRAINT FK_car_Pictures FOREIGN KEY(id_pic)
REFERENCES Pictures (id_picture);

ALTER TABLE car   ADD  CONSTRAINT FK_car_Users FOREIGN KEY(id_user)
REFERENCES Users_ (id_user);


CREATE TABLE Brand(
    id_brand int NOT NULL,
    Brand nchar(13) NULL,
 CONSTRAINT PK_Brand PRIMARY KEY 
(
    id_brand 
));


CREATE TABLE Comment_(
    id_comment int NOT NULL,
    id_user int NULL,
    id_car int null,
    id_spare int null,
    Comment_ nchar(50) NULL,
 CONSTRAINT PK_Comment PRIMARY KEY 
(
    id_comment 
));

ALTER TABLE Comment_   ADD  CONSTRAINT FK_Comment_CAR FOREIGN KEY(ID_CAR)
REFERENCES CAR (ID_CAR);

ALTER TABLE Comment_   ADD  CONSTRAINT FK_Comment_SPARE FOREIGN KEY(ID_SPARE)
REFERENCES SPARES (ID_SPARES);


ALTER TABLE Comment_   ADD  CONSTRAINT FK_Comment_Users FOREIGN KEY(id_USER)
REFERENCES Users_ (id_user);

CREATE TABLE Contacts(
    id_contacts int NOT NULL,
    id_user int NULL,
    Contact nchar(50) NULL,
 CONSTRAINT PK_Contacts PRIMARY KEY 
(
    id_contacts 
));

ALTER TABLE Contacts   ADD  CONSTRAINT FK_Contacts_Users FOREIGN KEY(id_user)
REFERENCES Users_ (id_user);


CREATE TABLE Model_(
    id_model int NOT NULL,
    Model_ nchar(30) NULL,
    id_brand int NULL,
 CONSTRAINT PK_Model PRIMARY KEY 
(
    id_model
    ));
    
ALTER TABLE Model_  ADD  CONSTRAINT FK_Model_Brand FOREIGN KEY(id_brand)
REFERENCES Brand (id_brand);

    
CREATE TABLE Post(
    id_post int NOT NULL,
    id_AUTO int NULL,
    id_user int NULL,
    id_spares int NULL,
    POST VARCHAR(300),
 CONSTRAINT PK_Post PRIMARY KEY 
(
    id_post 
));
--drop table Post;
ALTER TABLE Post   ADD  CONSTRAINT FK_Post_car FOREIGN KEY(id_AUTO)
REFERENCES CAR (id_car);


ALTER TABLE Post   ADD  CONSTRAINT FK_Post_Spares FOREIGN KEY(id_spares)
REFERENCES Spares (id_spares);



ALTER TABLE Post   ADD  CONSTRAINT FK_Post_Users FOREIGN KEY(id_user)
REFERENCES Users_ (id_user);


CREATE TABLE Saved(
    id_saved int NOT NULL,
    id_CAR int NULL,
    ID_SPARE INT NULL,
    id_user int NULL,
    Date_ DATE  NULL,
 CONSTRAINT PK_Saved PRIMARY KEY
(
    id_saved 
));
--drop table Saved;

ALTER TABLE Saved   ADD  CONSTRAINT FK_Saved_CAR FOREIGN KEY(id_CAR)
REFERENCES CAR (id_CAR);

ALTER TABLE Saved   ADD  CONSTRAINT FK_Saved_SPARE FOREIGN KEY(id_SPARE)
REFERENCES SPARES (id_SPARES);



ALTER TABLE Saved   ADD  CONSTRAINT FK_Saved_Users FOREIGN KEY(id_user)
REFERENCES Users_ (id_user);



CREATE TABLE Spares(
    Id_spares int NOT NULL,
    Id_model int NULL,
    Id_pic int NULL,
    Id_user int Null,
    Spares nchar(10) NULL,
    Price int NULL,
 CONSTRAINT PK_Spares PRIMARY KEY
(
    Id_spares
));
--drop table Spares;

ALTER TABLE Spares   ADD  CONSTRAINT FK_Spares_Brand FOREIGN KEY(ID_user)
REFERENCES Users_ (ID_user);

ALTER TABLE Spares   ADD  CONSTRAINT FK_Spares_Model FOREIGN KEY(ID_model)
REFERENCES Model_ (ID_model);


ALTER TABLE Spares   ADD  CONSTRAINT FK_Spares_Pictures FOREIGN KEY(ID_pic)
REFERENCES Pictures (ID_picture);



CREATE TABLE Users_(
    Id_user int NOT NULL,
    Login nchar(10) NULL,
    Password nchar(10) NULL,
    Name nchar(10) NULL,
    PRIVILEGE_ nchar(5),
 CONSTRAINT PK_Users PRIMARY KEY  
(
    Id_user
));

INSERT INTO USERS_(ID_USER,LOGIN,PASSWORD,NAME,PRIVILEGE_) VALUES(0,'ADMIN','ADMIN','AADMIN','ADMIN');

CREATE TABLE Pictures(
    Id_picture int NOT NULL,
    picture BLOB NULL,
    Id_car int NULL,
    Id_spare int NULL,
 CONSTRAINT PK_Pictures PRIMARY KEY
(
    Id_picture
));

