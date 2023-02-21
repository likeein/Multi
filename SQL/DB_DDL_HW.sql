--[ DDL 실습]

--그림1)
--SQL> desc cust
--Name                                      Null?    Type
------------------------------------------   -------
--CUST_ID                                           NUMBER(6)
--CUST_GENDER                                        NUMBER
--CUST_NAME                                          VARCHAR2(10)
--1.      그림1처럼 TABLE을 생성 하는 SQL문을 작성하시오.
CREATE TABLE CUST
(CUST_ID NUMBER(6),
CUST_GENDER NUMBER,
CUST_NAME VARCHAR2(10));

DESC CUST;

--그림2)
--SQL> select * from cust;
--CUST_ID   CUST_GENDER    CUST_NAME
---------     -------------     -----------
--         1           1        홍길동
--         2           0        이순신
--         3           1
--         4           0        이이
--         5           1        신사임당
--2.      그림2처럼 데이터를 추가 하는 SQL문을 작성하시오.
INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (1, 1, '홍길동');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (2, 0, '이순신');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (3, 1, '');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (4, 0, '이이');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (5, 1, '신사임');

SELECT * FROM CUST;

--3. CUST 테이블에 CUST_GRADE 컬럼을 추가 하는 SQL문을 작성하시오
--(단 GRADE 는 숫자2자리)
ALTER TABLE CUST
ADD CUST_GRADE NUMBER(2); 

DESC CUST;

--4. CUST_GRADE 컬럼에 TYPE을 숫자 4자리로 변경 시키는 SQL문을 작성하시오
ALTER TABLE CUST
MODIFY CUST_GRADE NUMBER(4);

DESC CUST;

--5. CUST 테이블을 복사하여 CUSTOMER 테이블을 생성
CREATE TABLE CUSTOMER
AS
SELECT * FROM CUST;

DESC CUSTOMER;

--6. CUST 테이블에  고객테이블 이라는 주석을 달고   올바르게  추가되었는지 데이터 딕셔너리를 조회하세요
COMMENT ON TABLE CUST
IS '고객테이블';

DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;

--7. CUST 테이블의 모든 데이터를 삭제 하는 2가지 방법의 명령을 쓰고 둘의 차이점에 대해 기술하시요
DROP TABLE CUST; -- 테이블 자체를 삭제하는 명령어
DROP TABLE CUST PURGE; --휴지통을 거치지 않고 테이블을 바로 삭제하는 명령어

--8. CUST 테이블을 삭제
DROP TABLE CUST;

--9. 휴지통에서 삭제된 테이블의 정보를 찾을수 있다.
SHOW RECYCLEBIN

--10. 삭제하기 전으로 되돌리려고 한다. 어떻게 해야 하나?
ROLLBACK;

SELECT * FROM CUST;
