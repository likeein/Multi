--TCL (Transaction Control Language) : Ʈ������ ���

 --: Ʈ�����ǿ� ���Ͽ� ������ �ϰ����� �����ǵ��� �Ѵ�. 
 
-- 1. Ʈ������ ���۰� ����
--  ���� : ù��° DML���� ������ ���۵� (�ڵ�)
---------------------- DB TCL �ڷ� �ּż� �װɷ� �̷� �˷��ֽ� 

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
-- ���� : ���λ� + ���� keyword + ������
-- show user
-- ;(X) SQL PLUS ��ɾ� 
-- user_ : �� ������ ������ �Ͱ� ������ ����
-- desc user_tables
-- ALL_ : ���ٱ����� �ִ� �Ͱ� ���õ� ����
-- DESC ALL- TABLES
-- SELECT TABLE_NAME, OWNER FROM ALL_TABLES;
-- DBA_ : DB �����ڰ� ���� ����
-- CONN system/oracle as sysdba
-- show user
-- desc dba_users
-- select USER_NAME, USER_ID, PASSWORD
-- FROM DBA_USERS;
-- V$_ : �����̸鼭 ���ɰ� ���õ� ����