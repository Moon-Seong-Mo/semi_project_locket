CREATE USER LOCKET IDENTIFIED BY LOCKET;
GRANT RESOURCE, CONNECT TO LOCKET;
GRANT CREATE VIEW TO LOCKET;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
DROP SEQUENCE SEQ_BCOUNT;
DROP SEQUENCE SEQ_BFCOUNT;
DROP SEQUENCE SEQ_CCOUNT;
DROP SEQUENCE SEQ_DCOUNT;
DROP SEQUENCE SEQ_GCOUNT;
DROP SEQUENCE SEQ_GFCOUNT;
DROP TABLE MEMBER;
DROP TABLE MEMBER_RANK;
DROP TABLE MEMBER_ACTIVITY;
DROP TABLE SHIPPING_ADDRESS;
DROP TABLE WISHLIST;
DROP TABLE APPLY;
DROP TABLE BOARD;
DROP TABLE BOARD_COMMENT;
DROP TABLE BOARD_FILE;
DROP TABLE GROUP_BUY;
DROP TABLE GROUP_FILE;
DROP TABLE MEMBER_REPORT;
DROP TABLE PRODUCT;
DROP TABLE PRODUCT_FILE;
DROP TABLE MEMBER_MESSAGE;
DROP TABLE PRODUCT_COMMENT;
DROP TABLE DEAL;
DROP VIEW ALIST;
DROP TABLE APPLY;
DROP SEQUENCE SEQ_MERCHANT_UID;
----------------------------------------------------------------------------
----------------------------------------------------------------------------
CREATE TABLE MEMBER_RANK(
    RANK_CODE NUMBER PRIMARY KEY,
    RANK_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_RANK VALUES(1, '종이비행기');
INSERT INTO MEMBER_RANK VALUES(2, '드론');
INSERT INTO MEMBER_RANK VALUES(3, '비행기');
INSERT INTO MEMBER_RANK VALUES(4, '로켓');
INSERT INTO MEMBER_RANK VALUES(99, '관리자');
----------------------------------------------------------------------------
CREATE TABLE MEMBER(
   MEMBER_ID VARCHAR2(20) PRIMARY KEY,
   MEMBER_PW VARCHAR2(20) NOT NULL,
   PW_HINT VARCHAR2(255) NOT NULL,
   PW_HINT_ANS VARCHAR2(255) NOT NULL,
   GENDER VARCHAR2(1) NOT NULL,
   EMAIL VARCHAR2(30) NOT NULL,
   PHONE VARCHAR2(20) NOT NULL,
   MEMBERNAME VARCHAR2(15) NOT NULL UNIQUE,
   RANK_CODE NUMBER DEFAULT 1 NOT NULL,
   JOIN_DATE DATE NOT NULL,
   INCHECK VARCHAR2(1) DEFAULT 'Y' NOT NULL,
       M_CHECK VARCHAR2(1) NOT NULL,
       P_IMAGE VARCHAR2(255) NULL,
       M_DATE DATE NULL,       --언제까지 정지인지
       S_CHECK VARCHAR2(1) DEFAULT 'N' NOT NULL
);
INSERT INTO MEMBER VALUES('admin', 'admin', 'pw', 'pw', 'M', 'admin@admin.admin', '010-1234-5678', '관리자', 99, SYSDATE, DEFAULT, 'N', NULL, NULL, DEFAULT);
ALTER TABLE MEMBER ADD CONSTRAINT M_RC_FK FOREIGN KEY(RANK_CODE) REFERENCES MEMBER_RANK;
ALTER TABLE MEMBER ADD CONSTRAINT M_GENDER_CK CHECK(GENDER IN('M', 'F'));
ALTER TABLE MEMBER ADD CONSTRAINT M_MC_CK CHECK(M_CHECK IN('Y', 'N'));
----------------------------------------------------------------------------
CREATE TABLE PRODUCT(
   PRODUCT_NUM NUMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(20) NOT NULL,
   CATEGORY VARCHAR2(20) NOT NULL,
   TITLE VARCHAR2(1000) NOT NULL,
   PRICE NUMBER NOT NULL,
   CONDITION VARCHAR2(20) NOT NULL,
   DELIVERY VARCHAR2(20) NOT NULL,
   EXPLAIN VARCHAR2(4000) NOT NULL,
    CREATE_DATE DATE NOT NULL,
    PRODUCT_COUNT NUMBER DEFAULT 0 NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    LOCATION1 VARCHAR2(50) NOT NULL,
    LOCATION2 VARCHAR2(50) NOT NULL,
    LOCATION3 VARCHAR2(50) NOT NULL,
   FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER
);
CREATE SEQUENCE SEQ_PCOUNT NOCACHE;
ALTER TABLE PRODUCT
ADD CONSTRAINT PRODUCT_FK1 FOREIGN KEY
(LOCATION1 , LOCATION2 , LOCATION3)REFERENCES ADDR(SIDO_NAME , SIGUNGU_NAME , DONG_NAME)ENABLE;

CREATE TABLE PRODUCT_FILE(
      PF_ID NUMBER PRIMARY KEY,
      PRODUCT_NUM NUMBER NOT NULL,
      ORIGIN_NAME VARCHAR2(255) NOT NULL,
      CHANGE_NAME VARCHAR2(255) NOT NULL,
      FILE_PATH VARCHAR2(1000) NOT NULL,
      FILE_LEVEL NUMBER,
      STATUS VARCHAR2(1) DEFAULT 'Y',
      FOREIGN KEY (PRODUCT_NUM) REFERENCES PRODUCT ON DELETE CASCADE
);
CREATE SEQUENCE SEQ_PFCOUNT NOCACHE;
----------------------------------------------------------------------------
CREATE TABLE BOARD(
   BOARD_NUM NUMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(20) NOT NULL,
    BOARD_LEVEL NUMBER DEFAULT 0 NOT NULL,
   TITLE VARCHAR2(255) NOT NULL,
   VIEWS NUMBER DEFAULT 0 NOT NULL,
   BOARD_C VARCHAR2(4000 BYTE) NOT NULL,
    CREATE_DATE DATE NOT NULL,
    MODIFY_DATE DATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL
);

CREATE SEQUENCE SEQ_BCOUNT NOCACHE;
ALTER TABLE BOARD ADD CONSTRAINT B_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE BOARD ADD CONSTRAINT B_STATUS_CK CHECK(STATUS IN('Y', 'N'));
SELECT SEQ_BCOUNT.NEXTVAL FROM DUAL;
SELECT SEQ_BCOUNT.CURRVAL FROM DUAL;
BEGIN
    FOR I IN 1..97
    LOOP
        INSERT INTO BOARD VALUES(SEQ_BCOUNT.NEXTVAL, 'bhan1515', 0, I + 1, DEFAULT, I + 10, SYSDATE, SYSDATE, DEFAULT);
    END LOOP;
END;
/

COMMIT;

CREATE OR REPLACE VIEW BLIST
AS
SELECT ROWNUM RNUM, DESCBOARD.*
FROM (SELECT BOARD_NUM, MEMBER_ID, MEMBERNAME, TITLE, VIEWS, BOARD_C, CREATE_DATE, MODIFY_DATE
      FROM BOARD
           JOIN MEMBER USING(MEMBER_ID)
      WHERE STATUS = 'Y' AND BOARD_LEVEL = 0
      ORDER BY BOARD_NUM DESC) DESCBOARD;

SELECT *
FROM BLIST
WHERE RNUM BETWEEN 11 AND 20;

SELECT RNUM, BOARD.*
FROM (SELECT ROWNUM RNUM, B.* 
      FROM (SELECT BOARD_NUM, MEMBER_ID, MEMBERNAME, TITLE, VIEWS, CREATE_DATE, MODIFY_DATE
            FROM BOARD
                JOIN MEMBER USING(MEMBER_ID)
            WHERE STATUS = 'Y' AND MEMBER_ID LIKE '%' || 'bhan' || '%'
            ORDER BY BOARD_NUM DESC) B) BOARD 
WHERE RNUM BETWEEN 11 AND 20;
----------------------------------------------------------------------------
CREATE TABLE BOARD_FILE(
      FILE_ID NUMBER PRIMARY KEY,
      BOARD_NUM NUMBER NOT NULL,
      ORIGIN_NAME VARCHAR2(255) NOT NULL,
      CHANGE_NAME VARCHAR2(255) NOT NULL,
      FILE_PATH VARCHAR2(1000) NOT NULL,
      UPLOAD_DATE DATE DEFAULT SYSDATE,
      FILE_LEVEL NUMBER,
      DOWNLOAD_COUNT NUMBER DEFAULT 0,
      STATUS VARCHAR2(1) DEFAULT 'Y',
      FOREIGN KEY (BOARD_NUM) REFERENCES BOARD
);
CREATE SEQUENCE SEQ_BFCOUNT NOCACHE;
----------------------------------------------------------------------------
CREATE TABLE BOARD_COMMENT(
     COMMENT_NUM NUMBER PRIMARY KEY,
      BOARD_NUM NUMBER NOT NULL,
    COMMENT_LEVEL NUMBER DEFAULT 0 NOT NULL,
   MEMBER_ID VARCHAR2(20) NOT NULL,
    COMMENT_C VARCHAR2(200) NOT NULL,
   WR_DATE DATE NOT NULL,
    MODIFY_DATE DATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y'
);

CREATE SEQUENCE SEQ_CCOUNT NOCACHE;
ALTER TABLE BOARD_COMMENT ADD CONSTRAINT BC_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE BOARD_COMMENT ADD CONSTRAINT BC_BN_FK FOREIGN KEY(BOARD_NUM) REFERENCES BOARD;
----------------------------------------------------------------------------
CREATE TABLE MEMBER_REPORT(
   R_NUM NUMBER PRIMARY KEY,
     R_CATEGORY VARCHAR2(20) NULL,
      MEMBER_ID VARCHAR2(20) NOT NULL,
    MEMBER_ID2 VARCHAR2(20) NOT NULL,
      R_REASON VARCHAR2(20) NOT NULL,
      R_DATE DATE NOT NULL,
      R_PATH VARCHAR2(255) NOT NULL,
      STATUS VARCHAR2(1) DEFAULT 'N' NOT NULL
);

ALTER TABLE MEMBER_REPORT ADD CONSTRAINT MR_MID1_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE MEMBER_REPORT ADD CONSTRAINT MR_MID2_FK FOREIGN KEY(MEMBER_ID2) REFERENCES MEMBER;
----------------------------------------------------------------------------
CREATE TABLE MEMBER_MESSAGE(
   MESSAGE_NUM NUMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(20) NOT NULL,
   SEND_ID VARCHAR2(20) NOT NULL,
   MESSAGE_C VARCHAR2(255) NOT NULL,
   SEND_DATE DATE NOT NULL
);
CREATE SEQUENCE SEQ_MCOUNT NOCACHE;
ALTER TABLE MEMBER_MESSAGE ADD CONSTRAINT MM_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE MEMBER_MESSAGE ADD CONSTRAINT MM_SID_FK FOREIGN KEY(SEND_ID) REFERENCES MEMBER;
----------------------------------------------------------------------------
CREATE TABLE GROUP_BUY (
   	GROUP_NUM NUMBER PRIMARY KEY,
  	MEMBER_ID VARCHAR2(20) NOT NULL,
  	TITLE VARCHAR2(60) NOT NULL,
   	EXPLAIN VARCHAR2(4000) NOT NULL,
   	PRICE NUMBER NOT NULL,
   	START_DATE DATE NOT NULL,
   	END_DATE DATE NOT NULL,
   	G_DATE DATE NOT NULL ,
	STATUS VARCHAR2(1) DEFAULT 'Y' ,
	VIEWS NUMBER DEFAULT 0 NOT NULL 
);

CREATE TABLE GROUP_FILE(
      FILE_ID NUMBER PRIMARY KEY,
      GROUP_NUM NUMBER NOT NULL,
      ORIGIN_NAME VARCHAR2(255) NOT NULL,
      CHANGE_NAME VARCHAR2(255) NOT NULL,
      FILE_PATH VARCHAR2(1000) NOT NULL,
      UPLOAD_DATE DATE DEFAULT SYSDATE,
      FILE_LEVEL NUMBER,
      DOWNLOAD_COUNT NUMBER DEFAULT 0,
      STATUS VARCHAR2(1) DEFAULT 'Y',
      FOREIGN KEY (GROUP_NUM) REFERENCES GROUP_BUY
);

CREATE OR REPLACE VIEW GLIST
AS
SELECT ROWNUM RNUM, DESCGROUP.* 
FROM (SELECT GROUP_NUM, TITLE,MEMBERNAME, G.EXPLAIN,MEMBER_ID, G.START_DATE, G.END_DATE, G.G_DATE, G.STATUS, VIEWS
FROM GROUP_BUY G
    JOIN MEMBER USING(MEMBER_ID)
WHERE G.STATUS ='Y'
ORDER BY GROUP_NUM DESC) DESCGROUP;

ALTER TABLE GROUP_BUY ADD CONSTRAINT GB_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
----------------------------------------------------------------------------
CREATE TABLE APPLY(
    GROUP_NUM NUMBER,
    MEMBER_ID VARCHAR2(20) NOT NULL,
    AMOUNT NUMBER NOT NULL,
    APPLY_DATE DATE NOT NULL,
    MERCHANT_UID VARCHAR2(20) NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    ADDRESS VARCHAR2(4000) NOT NULL,
    CONSTRAINT A_GNUMID_PK PRIMARY KEY(GROUP_NUM, MEMBER_ID)
);

CREATE SEQUENCE SEQ_MERCHANT_UID;
ALTER TABLE APPLY ADD CONSTRAINT A_GNUM_FK FOREIGN KEY(GROUP_NUM) REFERENCES GROUP_BUY;
ALTER TABLE APPLY ADD CONSTRAINT A_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;

CREATE OR REPLACE VIEW ALIST
AS
SELECT ROWNUM RNUM, DESCAPPLY.*
FROM (SELECT MERCHANT_UID, GROUP_NUM, MEMBERNAME, AMOUNT, APPLY_DATE
        FROM APPLY A
            JOIN MEMBER USING(MEMBER_ID)
            JOIN GROUP_BUY USING(GROUP_NUM)
        WHERE A.STATUS = 'Y'
        ORDER BY MERCHANT_UID DESC) DESCAPPLY;
        
ALTER TABLE APPLY ADD CONSTRAINT A_GNUM_FK FOREIGN KEY(GROUP_NUM) REFERENCES GROUP_BUY;
ALTER TABLE APPLY ADD CONSTRAINT A_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
----------------------------------------------------------------------------
CREATE TABLE SHIPPING_ADDRESS(
        ADD_NUM NUMBER DEFAULT 0 NOT NULL PRIMARY KEY,
       MEMBER_ID VARCHAR2(20) NOT NULL,
       ADDRESS_NAME VARCHAR2(20) NOT NULL,
       ADDRESS VARCHAR2(255) NOT NULL,
       PHONE VARCHAR2(20) NOT NULL,
        RECEIVER VARCHAR2(25) NOT NULL,
        STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL
);
CREATE SEQUENCE SEQ_DCOUNT NOCACHE;
CREATE SEQUENCE SEQ_GCOUNT NOCACHE;
CREATE SEQUENCE SEQ_GFCOUNT NOCACHE;
ALTER TABLE SHIPPING_ADDRESS ADD CONSTRAINT SA_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
----------------------------------------------------------------------------
CREATE TABLE WISHLIST(
       MEMBER_ID VARCHAR2(20),
       WISH_NUM NUMBER,
        CONSTRAINT UR_USERNO_PK PRIMARY KEY(MEMBER_ID, WISH_NUM)
);

ALTER TABLE WISHLIST ADD CONSTRAINT W_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
ALTER TABLE WISHLIST ADD CONSTRAINT W_WNUM_FK FOREIGN KEY(WISH_NUM) REFERENCES PRODUCT;

CREATE TABLE DEAL (
    MEMBER VARCHAR2(20) NOT NULL,
    PRODUCT_NUM NUMBER NOT NULL,
    PRODUCT_TITLE VARCHAR2(100) NOT NULL,
    RECEIVER VARCHAR2(20) NOT NULL,
    SEND_DATE DATE NOT NULL,
    DEAL_DATE DATE NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL,
    FOREIGN KEY (RECEIVER) REFERENCES MEMBER,
    FOREIGN KEY (MEMBER) REFERENCES MEMBER,
    FOREIGN KEY (PRODUCT_NUM) REFERENCES PRODUCT
);
ALTER TABLE DEAL ADD PRIMARY KEY (MEMBER, PRODUCT_NUM);

----------------------------------------------------------------------------
CREATE TABLE PRODUCT_COMMENT(
   COMMENT_NUM NUMBER PRIMARY KEY,
   O_NUM NUMBER NOT NULL,
   MEMBER_ID VARCHAR2(20) NOT NULL,
   COMMENT_C VARCHAR2(200) NOT NULL,
   WR_DATE DATE NOT NULL,
    STATUS VARCHAR2(1) DEFAULT 'Y' NOT NULL
);

ALTER TABLE PRODUCT_COMMENT ADD CONSTRAINT PC_ONUM_FK FOREIGN KEY(O_NUM) REFERENCES PRODUCT;
ALTER TABLE PRODUCT_COMMENT ADD CONSTRAINT PC_MID_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER;
----------------------------------------------------------------------------
----------------------------------------------------------------------------

CREATE OR REPLACE VIEW PLIST
AS
SELECT ROWNUM RNUM, DESCPRODUCT.*
FROM (SELECT PRODUCT_NUM, MEMBER_ID, RANK_CODE, MEMBERNAME, CATEGORY, TITLE, PRICE, CONDITION, DELIVERY, EXPLAIN, CREATE_DATE, PRODUCT_COUNT
      FROM PRODUCT
           JOIN MEMBER USING(MEMBER_ID)
      WHERE STATUS = 'Y'
      ORDER BY PRODUCT_NUM DESC) DESCPRODUCT;

CREATE OR REPLACE VIEW PDETAIL
AS
SELECT ROWNUM RNUM, DESCPRODUCT.*
FROM (SELECT PRODUCT_NUM, MEMBER_ID, MEMBERNAME, CATEGORY, TITLE, PRICE, CONDITION, DELIVERY, EXPLAIN, CREATE_DATE, PRODUCT_COUNT, LOCATION1, LOCATION2, LOCATION3
      FROM PRODUCT
           JOIN MEMBER USING(MEMBER_ID)
      ORDER BY PRODUCT_NUM DESC) DESCPRODUCT;
      
-----------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CHECK_RANK(V_MEMBER_ID MEMBER.MEMBER_ID%TYPE, V_RANK_CODE OUT MEMBER.RANK_CODE%TYPE, V_COUNT OUT NUMBER)
IS
BEGIN
    SELECT COUNT(*)
    INTO V_COUNT
    FROM DEAL
    WHERE (RECEIVER = V_MEMBER_ID AND STATUS = 'N') OR (MEMBER = V_MEMBER_ID AND STATUS = 'N');
    
    SELECT RANK_CODE
    INTO V_RANK_CODE
    FROM MEMBER
    WHERE MEMBER_ID = V_MEMBER_ID;
    
END;
/

CREATE OR REPLACE PROCEDURE CHECK_RANK_RES(V_MEMBER_ID MEMBER.MEMBER_ID%TYPE, V_MEMBER_ID2 MEMBER.MEMBER_ID%TYPE, RES OUT NUMBER)
IS
  V_RANK_CODE MEMBER.RANK_CODE%TYPE;
  V_COUNT NUMBER;
  V_RANK_CODE2 MEMBER.RANK_CODE%TYPE;
  V_COUNT2 NUMBER;
  RES2 NUMBER;
BEGIN
    CHECK_RANK(V_MEMBER_ID, V_RANK_CODE, V_COUNT);
    CHECK_RANK(V_MEMBER_ID2, V_RANK_CODE2, V_COUNT2);
    
    RES := 0;
    RES2 := 0;
    IF V_RANK_CODE <= 1 AND V_COUNT >= 5
    THEN RES := 1;
    ELSIF V_RANK_CODE <= 2 AND V_COUNT >= 10
    THEN RES := 2;
    ELSIF V_RANK_CODE <= 3 AND V_COUNT >= 20
    THEN RES := 3;
    END IF;
    
    IF V_RANK_CODE2 <= 1 AND V_COUNT2 >= 5
    THEN RES2 := 1;
    ELSIF V_RANK_CODE2 <= 2 AND V_COUNT2 >= 10
    THEN RES2 := 2;
    ELSIF V_RANK_CODE2 <= 3 AND V_COUNT2 >= 20
    THEN RES2 := 3;
    END IF;
    
    IF RES > 0
    THEN UPDATE MEMBER SET RANK_CODE = RANK_CODE + 1 WHERE MEMBER_ID = V_MEMBER_ID;
    END IF;
    IF RES2 > 0
    THEN UPDATE MEMBER SET RANK_CODE = RANK_CODE + 1 WHERE MEMBER_ID = V_MEMBER_ID2;
    END IF;
    COMMIT;
    RES := RES + RES2;
END;
/
------------------------------------------------------------------------------------------------
SELECT RNUM, MEMBER, MEMBERNAME, COUNT, MAXDATE
FROM (SELECT ROWNUM RNUM, COUNTDESC.*
      FROM (SELECT MEMBERNAME, C.*
            FROM (SELECT MEMBER, COUNT(*) COUNT, MAX(DEAL_DATE) MAXDATE
                  FROM DEAL
                  WHERE DEAL_DATE BETWEEN TRUNC(SYSDATE,'MM') AND  + TO_DATE(TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD')) + 0.99999 AND STATUS = 'N'
                  GROUP BY MEMBER
                  UNION ALL
                  SELECT RECEIVER, COUNT(*) COUNT, MAX(DEAL_DATE) MAXDATE
                  FROM DEAL
                  WHERE DEAL_DATE BETWEEN TRUNC(SYSDATE,'MM') AND  + TO_DATE(TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD')) + 0.99999 AND STATUS = 'N'
                  GROUP BY RECEIVER) C
                  JOIN MEMBER ON(MEMBER = MEMBER_ID)
            ORDER BY COUNT DESC, MAXDATE) COUNTDESC) CD
WHERE RNUM BETWEEN 1 AND 3;


SELECT TRUNC(SYSDATE,'MM'), TO_DATE(TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD')) + 0.99999
FROM DUAL;
--------------------------------------------------------------------------------------------------------
SELECT * 
FROM (SELECT ROWNUM RNUM, PRODUCT.*
      FROM (SELECT PRODUCT.*, CHANGE_NAME
            FROM PRODUCT
                 JOIN PRODUCT_FILE ON(PRODUCT.PRODUCT_NUM = PRODUCT_FILE.PRODUCT_NUM)
            WHERE CREATE_DATE BETWEEN TRUNC(SYSDATE,'MM') AND  + TO_DATE(TO_CHAR(LAST_DAY(SYSDATE), 'YYYYMMDD')) + 0.99999 AND PRODUCT.STATUS = 'Y' AND PRODUCT_FILE.STATUS = 'Y' AND PRODUCT_FILE.FILE_LEVEL = 0
            ORDER BY PRODUCT_COUNT DESC) PRODUCT)
WHERE RNUM BETWEEN 1 AND 10;

----------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW BUY_LIST
AS
SELECT ROWNUM RNUM, DESCAPPLY.*
FROM (SELECT A.*, MEMBERNAME, TITLE, AMOUNT / PRICE NUM
      FROM APPLY A
            JOIN MEMBER M ON(M.MEMBER_ID = A.MEMBER_ID)
            JOIN GROUP_BUY G ON(A.GROUP_NUM = G.GROUP_NUM)
        WHERE A.STATUS = 'Y'
        ORDER BY MERCHANT_UID DESC) DESCAPPLY;
        
SELECT * FROM APPLY;
SELECT * FROM APPLY WHERE MEMBER_ID = 'bhan1515';
ALTER TABLE ADDR ADD PRIMARY KEY (SIDO_NAME, SIGUNGU_NAME, DONG_NAME);
SELECT * FROM ADDR WHERE (SELECT SIDO_NAME, SIGUNGU_NAME, DONG_NAME FROM ADDR) = (SELECT SIDO_NAME, SIGUNGU_NAME, DONG_NAME FROM ADDR WHERE SIDO_NAME = '세종특별자치시' GROUP BY SIDO_NAME, SIGUNGU_NAME, DONG_NAME);
SELECT * FROM ADDR WHERE SIDO_NAME = '세종특별자치시';

DELETE FROM ADDR A
WHERE ROWID >
(SELECT MIN(ROWID) FROM ADDR B
  WHERE b.SIDO_NAME = a.SIDO_NAME
  AND b.SIGUNGU_NAME = a.SIGUNGU_NAME
  AND b.DONG_NAME = a.DONG_NAME
);

SELECT SIDO_NAME FROM ADDR GROUP BY SIDO_NAME ORDER BY SIDO_NAME;
SELECT SIGUNGU_NAME FROM ADDR WHERE SIDO_NAME = '강원도' GROUP BY SIGUNGU_NAME;
SELECT DONG_NAME FROM ADDR WHERE SIDO_NAME = '세종특별자치시' AND SIGUNGU_NAME = '세종특별자치시' GROUP BY DONG_NAME ORDER BY DONG_NAME;