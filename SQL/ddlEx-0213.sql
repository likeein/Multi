-- DDL (Data Definition Language)

--이름 지정 규칙
--1. A-Z, a-z, 0-9, _, $, # 사용 가능
--2. 첫글자 영문자
--3. 예약어 (DB에서 약속해 놓은 문자들) 사용 x
--4. 이름은 의미있게 생성할 것!

--+ 테이블 생성
-- : 테이블 생성하려면 유저(개발자)는 CREATE TABLE 권한이 있어야 하며 객체를 생성할 저장 영역이 있어야 함.
-- : DBA(데이터베이스 관리자)는 DCL(데이터 제어어)문을 사용하여 유저에게 권한을 부여함.

--CREATE TABLE COPY_EMP2
--(EMPNO NUMBER(4),
-- ENAME CHAR, VARCHAR2 (20)
--       cf) LONG TYPE : 2G 텍스트, LONG ROW : 2G 이미지   (v7)
--       =>  LOB(Large Object), CLOB, BLOB, BFILE : 4G     (v10)
-- JOB CHAR, VARCHAR(20),
-- SAL NUMBER(7, 2),
-- HIREDATE DATE)

CREATE TABLE COPY_EMP2
(EMPNO NUMBER(4), 
ENAME VARCHAR(20), 
JOB CHAR(10),
SAL NUMBER(7, 2),
HIREDATE DATE);

DESC COPY_EMP2

CREATE TABLE BIGDATA1
(D1 LONG, D2 LONG RAW);

CREATE TABLE BIGDATA2
(D1 CLOB, D2 BLOB, D3 BFILE);

DESC BIGDATA2

-- 테이블 생성 시 subQuery 사용 가능
CREATE TABLE EMPS
AS
SELECT * FROM EMP;
 
SELECT * FROM EMPS;

--[실습] COPY_EMP3 테이블 생성
--     : EMP 테이블과 동일한 구조를 갖지만 ROW는 하나도 없는 테이블을 생성해 보세요
     
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO = 9999;

SELECT * FROM COPY_EMP3;

--[실습] COPY_EMP4 테이블 생성
--   : EMP 테이블과 동일한 구조를 가지면서 10번 부서 사원데이터만 저장되어있는 테이블을 생성하세요

CREATE TABLE COPY_EMP4
AS
SELECT * FROM EMP
WHERE DEPTNO = 10;

SELECT * FROM COPY_EMP4;

--+ 테이블 구조 변경
-- 문법 : ALTER TABLE 구문 
-- - 새 열 추가
-- - 기존 열 정의 수정
-- - 새 열의 기본값 정의
-- - 열 삭제
-- - 열 이름 바꾸기
-- - 읽기 전용 상태로 테이블 변경 (11g)
 
-- 테이블에 컬럼 추가
ALTER TABLE EMPS
ADD HP VARCHAR(10);
 
SELECT * FROM EMPS;

-- 컬럼명 변경
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;
 
SELECT * FROM EMPS;

DESC EMPS

-- 컬럼 정의 수정
ALTER TABLE EMPS
MODIFY MP VARCHAR2(15);

DESC EMPS

-- 컬럼 삭제
ALTER TABLE EMPS
DROP COLUMN MP;

SELECT * FROM EMPS;

--읽기 전용 테이블
-- : READ ONLY 구문을 지정하여 테이블을 읽기전용모드로 둘 수 있음.
-- : READ ONLY 모드이면 테이블에 영향을 주는 DML 실행할 수 없음.
-- : 테이블이 데이터를 수정하지 않는 한 DDL 문은 실행할 수 있음.

ALTER TABLE EMPS
READ ONLY;

SELECT * FROM EMPS;

INSERT INTO EMPS (EMPNO)
VALUES (9999);

-- 읽기 전용 해제
ALTER TABLE EMPS READ WRITE;

INSERT INTO EMPS (EMPNO)
VALUES (9999);

--참고 : 읽기전용모드인 테이블을 삭제할 수 있음. 
--     : 테이블 삭제(DROP TABLE) 명령은 데이터 딕셔너리에서만 실행되므로 
--       테이블 내용에 엑세스 할 필요가 없기 때문. 

--+ 테이블 삭제 
DROP TABLE EMPS;

DESC EMPS;

--삭제 정리
--DELETE 구문 테이블의 ROW들을 지워주는 명령어
--DROP 구문은 테이블 자체를 삭제하는 명령어
--TRUNCATE 는 테이블의 ROW를 지워주는 명령어. DELETE와 달리 ROLLBACK 하지 않으므로 더 빨리 삭제가 가능하다.
--            그러나 WHERE 절을 사용할 수 없으므로 부분삭제 불가

--+ 테이블 복구
-- : DROP TABLE 하면 윈도우처럼 DBMS도 RECYCLBIN (휴지통)에 보류처리 
SHOW RECYCLEBIN

FLASHBACK TABLE EMPS
TO BEFORE DROP;

DESC EMPS;

SELECT * FROM EMPS;

DROP TABLE EMPS;

SHOW RECYCLEBIN

-- 휴지통 비우기
PURGE RECYCLEBIN;

SHOW RECYCLEBIN

-- DROP TABLE EMPS PURGE;  # PURGE절을 바로 사용하면 휴지통 거치지 않고 삭제 가능 (사용시 주의 필요)

--+ 테이블 이름 변경
RENAME COPY_EMP2
TO EMPS;

DESC COPY_EMP2

-- + 테이블에 주석 달기
COMMENT ON TABLE EMPS
IS 'THIS TABLE IS EMPLOYEE TABLE';

--주석은 데이터 딕셔너리에서 확인할 수 있음.
DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;

--+DDL 성질
--1. 동시성
--: 동시 공유
--: 동시성 제어 - 트랜잭션 EX) 은행 계좌이체 (TCL - COMMIT, ROLLBACK, SAVEPOINT)

--2. 무결성
--: 무결성 만족시키려면 ? DDL. DML문을 쓸 때 테이블 조건을 만족할 때만 실행할 수 있도록 하면 된다. 
--: 제약 조건 
-- 1) PRIMARY KEY : 거의 필수
-- 2) NOT NULL 
-- 3) CHECK
-- 4) UNIQUE
-- 5) FOREIGN KEY
 
--EX) EMP 테이블, DEPT 테이블
-- EMPNO : NULL(X), 중복(X) - PRIMARY KEY
-- ENAME : NULL(X), 중복(O) - NOT NULL 
-- SAL : 급여가 0보다는 커야한다 - CHECK
-- DEPTNO : 부서 테이블 중 하나 - FOREIGN KEY
-- ========================================
-- DEPTNO : NULL(X), 중복(X) - PRIMARY KEY
-- DNAME : 중복(X), 고유 - UNIQUE

--+ 제약 조건 정의 
--1) 컬럼 레벨 정의 방식
-- : 컬럼명 DATATYPE [CONSTRAINT 제약명] 제약조건
--: 제약명을 생략하면 SYS_C숫자형 형태로 임의 부여함

CREATE TABLE DEPT1
(DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(20) UNIQUE,
LOC VARCHAR(20));

DESC DEPT1

--제약 조건 정보 : 데이터 딕셔너리
DESC USER_CONSTRAINTS

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS;

--2) 테이블 레벨 정의 방식
--컬럼명 DATATYPE
--컬럼명 DATATYPE
--컬럼명 DATATYPE
--CONSTRINT 제약명 제약종류 (컬럼명),
--CONSTRINT 제약명 제약종류 (컬럼명),
--....

CREATE TABLE EMP1
(EMPNO NUMBER(4) CONSTRAINT EMP1_EMPNO_PK PRIMARY KEY, --생략가능하나 이렇게가 권장하는 표기법
ENAME VARCHAR2(20) NOT NULL,
SAL NUMBER(7,2),
DEPTNO NUMBER(2),
CONSTRAINT EMP1_SAL_CK CHECK (SAL BETWEEN 500 AND 5000),
CONSTRAINT EMP1_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT1 (DEPTNO));

DESC EMP1

INSERT INTO DEPT1
VALUES(1, '영업', '서울');

INSERT INTO DEPT1
VALUES(1, '회계', '부산');

INSERT INTO EMP1
VALUES(1111, 'HONG', 3000, 1);

--제약조건 추가 
ALTER TABLE DEPT1
ADD CONSTRAINT DEPT1_LOIC_UQ UNIQUE (LOC);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP1', 'DEPT1');

--제약조건 삭제
ALTER TABLE DEPT1
DROP CONSTRAINT DEPT1_LOIC_UQ;

--DEFAULT KEYWORD
CREATE TABLE DEPT2
(DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(20) UNIQUE,
LOC VARCHAR(20) DEFAULT '-');

INSERT INTO DEPT2
VALUES(1, '제주');
