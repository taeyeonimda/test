drop user kimkwangsoo cascade;

create user kimkwangsoo IDENTIFIED BY kimkwangsoo default tablespace users;
grant connect, resource TO kimkwangsoo;

--------------- ------ ----------------
--------------- TABLES ----------------
--------------- ------ ----------------


--------------- USERS -----------------
CREATE TABLE kimkwangsoo.USERS(
   USER_ID VARCHAR2(50) PRIMARY KEY, 
   USER_NAME VARCHAR2(50) NOT NULL, 
   USER_PWD VARCHAR2(50) NOT NULL, 
   USER_BIRTH VARCHAR2(50) NOT NULL, 
   USER_TEL VARCHAR2(50) NOT NULL,
   USER_EMAIL VARCHAR2(50) NOT NULL, 
   USER_ADDR VARCHAR2(100) NOT NULL, 
   USER_CLASS VARCHAR2(20) NOT NULL,
   USER_REG DATE,
   USER_STATUS CHAR(1)
);


------------ ROOM_TYPES --------------
CREATE TABLE kimkwangsoo.ROOM_TYPES(
   ROOM_TYPE VARCHAR2(50) PRIMARY KEY,
   ROOM_INFO VARCHAR2(4000) NOT NULL,
   ROOM_BED VARCHAR2(100) NOT NULL,
   ROOM_PERCNT VARCHAR2(50) NOT NULL,
   ROOM_PRICE NUMBER NOT NULL,
   ATTACH_NAME1 VARCHAR2(100),
   ATTACH_NAME2 VARCHAR2(100),
   ATTACH_NAME3 VARCHAR2(100)
);


--------------- ROOMS -----------------
CREATE TABLE kimkwangsoo.ROOMS(
   ROOM_NUM NUMBER PRIMARY KEY,
   ROOM_LIST_SEQ NUMBER,
   ROOM_RES_STATUS VARCHAR2(30) default '사용가능',
   ROOM_STATUS  VARCHAR2(30) default '운영중',   
   ROOM_TYPE VARCHAR2(50), CONSTRAINT ROOMS_ROOM_TYPES_FK FOREIGN KEY(ROOM_TYPE) REFERENCES kimkwangsoo.ROOM_TYPES(ROOM_TYPE) ON DELETE CASCADE
);


--------------- REVIEWS -----------------
CREATE TABLE kimkwangsoo.REVIEWS(
    REVIEW_NUM NUMBER PRIMARY KEY,
    REVIEW_TITLE VARCHAR2(100) NOT NULL,
    REVIEW_RATING NUMBER DEFAULT 0,
    REVIEW_ROOM_TYPE VARCHAR2(50) NOT NULL,
    REVIEW_CONTENT VARCHAR2(4000) NOT NULL,
    REVIEW_DATE DATE default sysdate,
    REVIEW_HIT NUMBER DEFAULT 0,
    USER_ID VARCHAR2(50), CONSTRAINT REVIEWS_USERS_FK FOREIGN KEY(USER_ID) REFERENCES kimkwangsoo.USERS(USER_ID) ON DELETE CASCADE
);




--------------- RESERVATIONS ---------------
CREATE TABLE kimkwangsoo.RESERVATIONS(
   RES_NUM NUMBER PRIMARY KEY,
   RES_PERNAME VARCHAR2(50) NOT NULL,
   RES_PERNUM NUMBER NOT NULL,
   RES_DATE DATE default sysdate,
   RES_TEL VARCHAR2(50),
   RES_EMAIL VARCHAR2(50),
   RES_CHKIN DATE NOT NULL,
   RES_CHKOUT DATE NOT NULL,
   RES_STATUS VARCHAR2(50) NOT NULL,
   RES_PAY VARCHAR2(50) NOT NULL,
   RES_PRICE NUMBER NOT NULL,
   ROOM_NUM NUMBER, CONSTRAINT RESERVATIONS_ROOMS_FK FOREIGN KEY(ROOM_NUM) REFERENCES kimkwangsoo.ROOMS(ROOM_NUM) ON DELETE SET NULL,
   USER_ID VARCHAR2(50), CONSTRAINT RESERVATIONS_USERS_FK FOREIGN KEY(USER_ID) REFERENCES kimkwangsoo.USERS(USER_ID) ON DELETE CASCADE
);




--------------- REFUNDS -----------------
CREATE TABLE kimkwangsoo.REFUNDS (
      REFUND_NUM NUMBER PRIMARY KEY,          
      REFUND_ACCOUNT_NUM VARCHAR2(50) NOT NULL,  
      REFUND_CONTENT VARCHAR2(4000) NOT NULL,    
      REFUND_PRICE NUMBER NOT NULL,     
      REFUND_DATE DATE default sysdate,
      REFUND_STATUS VARCHAR2(50) NOT NULL,
      USER_ID VARCHAR2(50), CONSTRAINT REFUNDS_USERS_FK FOREIGN KEY(USER_ID) REFERENCES kimkwangsoo.USERS(USER_ID) ON DELETE CASCADE,
      RES_NUM NUMBER, CONSTRAINT REFUNDS_RESERVATIONS_FK FOREIGN KEY(RES_NUM)  REFERENCES  kimkwangsoo.RESERVATIONS(RES_NUM) ON DELETE SET NULL       
);



--------------- QUERYS -----------------
CREATE TABLE kimkwangsoo.QUERYS (
   QUERY_NUM NUMBER PRIMARY KEY,        
   QUERY_TITLE VARCHAR2(100) NOT NULL,         
   QUERY_CONTENT VARCHAR2(1000) NOT NULL,     
   QUERY_DATE DATE default sysdate,       
   QUERY_REPLY VARCHAR2(4000),
   QUERY_REPLY_STAT VARCHAR2(30), 
   QUERY_HIT NUMBER,           
   USER_ID VARCHAR2(50), CONSTRAINT QUERYS_USERS_FK FOREIGN KEY(USER_ID) REFERENCES kimkwangsoo.USERS(USER_ID) ON DELETE CASCADE   
);


----------------------------- ------- -------------------------
----------------------------- squence -------------------------
----------------------------- ------- -------------------------

CREATE SEQUENCE kimkwangsoo.reviewnum_seq
    increment by 1
    start with 1;

CREATE SEQUENCE kimkwangsoo.refundnum_seq
    increment by 1
    start with 20001;

CREATE SEQUENCE kimkwangsoo.querynum_seq
    increment by 1
    start with 1;
    
CREATE SEQUENCE kimkwangsoo.roomlistseq_seq
    increment by 1
    start with 1;
    
CREATE SEQUENCE kimkwangsoo.reservationnum_seq
    increment by 1
    start with 1;

--------------------- ------ -------------------------
--------------------- INSERT -------------------------
--------------------- ------ -------------------------


--------------- USERS_INSERT -----------------
INSERT INTO kimkwangsoo.USERS VALUES(
 'user',
 '유저',
 'user',
 '1994-05-27',
 '010-3215-7165',
 'user@exam.com',
 '서울시 영등포구',
 'U',
 sysdate,
 'A'
);

INSERT INTO kimkwangsoo.USERS VALUES(
 'admin',
 '관리자',
 'admin',
 '1990-11-24',
 '010-0005-0001',
 'admin@exam.com',
 '서울시 강동구',
 'A',
 sysdate,
 'A'
);


commit;