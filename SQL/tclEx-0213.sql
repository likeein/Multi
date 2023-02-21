--TCL (Transaction Control Language) : 트랜젝션 제어문

 --: 트랜젝션에 준하여 데이터 일관성이 유지되도록 한다. 
 
-- 1. 트랜젝션 시작과 종료
--  시작 : 첫번째 DML문을 만나면 시작됨 (자동)
---------------------- DB TCL 자료 주셔서 그걸로 이론 알려주심 

-- COMMIT:
SELECT * FROM DEPT;

DELETE FROM DEPT
WHERE DEPTNO = 1;

INSERT INTO DEPT 
VALUES (50, 'COMMIT', 'DEPT');

COMMIT;

-- ROLLBACK
SELECT * FROM DEPT;

DELETE FROM DEPT
WHERE DEPTNO = 80;

ROLLBACK;

-- SAVEPOINT
SELECT * FROM COPY_EMP;

DELETE COPY_EMP
WHERE EMPNO = 7902;

SAVEPOINT DEL01_COPY_EMP;

DELETE FROM COPY_EMP
WHERE EMPNO = 7934;

SAVEPOINT DEL02_COPY_EMP;

INSERT INTO COPY_EMP (EMPNO)
VALUES (9990);

SAVEPOINT INSERT01_COPY_EMP;

INSERT INTO COPY_EMP (EMPNO)
VALUES (9991);

ROLLBACK TO INSERT01_COPY_EMP;

ROLLBACK TO DEL02_COPY_EMP;

ROLLBACK;

-------------------------------------------------------------

-- Data Dictionary
-- 구성 : 접두사 + 관심 keyword + 복수형
-- show user
-- ;(X) SQL PLUS 명령어 
-- user_ : 각 게정이 생성한 것과 관련한 정보
-- desc user_tables
-- ALL_ : 접근권한이 있는 것과 관련된 정보
-- DESC ALL- TABLES
-- SELECT TABLE_NAME, OWNER FROM ALL_TABLES;
-- DBA_ : DB 관리자가 보는 정보
-- CONN system/oracle as sysdba
-- show user
-- desc dba_users
-- select USER_NAME, USER_ID, PASSWORD
-- FROM DBA_USERS;
-- V$_ : 동적이면서 성능과 관련된 정보