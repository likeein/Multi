-- DDL (Data Definition Language)

--�̸� ���� ��Ģ
--1. A-Z, a-z, 0-9, _, $, # ��� ����
--2. ù���� ������
--3. ����� (DB���� ����� ���� ���ڵ�) ��� x
--4. �̸��� �ǹ��ְ� ������ ��!

--+ ���̺� ����
-- : ���̺� �����Ϸ��� ����(������)�� CREATE TABLE ������ �־�� �ϸ� ��ü�� ������ ���� ������ �־�� ��.
-- : DBA(�����ͺ��̽� ������)�� DCL(������ �����)���� ����Ͽ� �������� ������ �ο���.

--CREATE TABLE COPY_EMP2
--(EMPNO NUMBER(4),
-- ENAME CHAR, VARCHAR2 (20)
--       cf) LONG TYPE : 2G �ؽ�Ʈ, LONG ROW : 2G �̹���   (v7)
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

-- ���̺� ���� �� subQuery ��� ����
CREATE TABLE EMPS
AS
SELECT * FROM EMP;
 
SELECT * FROM EMPS;

--[�ǽ�] COPY_EMP3 ���̺� ����
--     : EMP ���̺�� ������ ������ ������ ROW�� �ϳ��� ���� ���̺��� ������ ������
     
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO = 9999;

SELECT * FROM COPY_EMP3;

--[�ǽ�] COPY_EMP4 ���̺� ����
--   : EMP ���̺�� ������ ������ �����鼭 10�� �μ� ��������͸� ����Ǿ��ִ� ���̺��� �����ϼ���

CREATE TABLE COPY_EMP4
AS
SELECT * FROM EMP
WHERE DEPTNO = 10;

SELECT * FROM COPY_EMP4;

--+ ���̺� ���� ����
-- ���� : ALTER TABLE ���� 
-- - �� �� �߰�
-- - ���� �� ���� ����
-- - �� ���� �⺻�� ����
-- - �� ����
-- - �� �̸� �ٲٱ�
-- - �б� ���� ���·� ���̺� ���� (11g)
 
-- ���̺� �÷� �߰�
ALTER TABLE EMPS
ADD HP VARCHAR(10);
 
SELECT * FROM EMPS;

-- �÷��� ����
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;
 
SELECT * FROM EMPS;

DESC EMPS

-- �÷� ���� ����
ALTER TABLE EMPS
MODIFY MP VARCHAR2(15);

DESC EMPS

-- �÷� ����
ALTER TABLE EMPS
DROP COLUMN MP;

SELECT * FROM EMPS;

--�б� ���� ���̺�
-- : READ ONLY ������ �����Ͽ� ���̺��� �б�������� �� �� ����.
-- : READ ONLY ����̸� ���̺� ������ �ִ� DML ������ �� ����.
-- : ���̺��� �����͸� �������� �ʴ� �� DDL ���� ������ �� ����.

ALTER TABLE EMPS
READ ONLY;

SELECT * FROM EMPS;

INSERT INTO EMPS (EMPNO)
VALUES (9999);

-- �б� ���� ����
ALTER TABLE EMPS READ WRITE;

INSERT INTO EMPS (EMPNO)
VALUES (9999);

--���� : �б��������� ���̺��� ������ �� ����. 
--     : ���̺� ����(DROP TABLE) ����� ������ ��ųʸ������� ����ǹǷ� 
--       ���̺� ���뿡 ������ �� �ʿ䰡 ���� ����. 

--+ ���̺� ���� 
DROP TABLE EMPS;

DESC EMPS;

--���� ����
--DELETE ���� ���̺��� ROW���� �����ִ� ��ɾ�
--DROP ������ ���̺� ��ü�� �����ϴ� ��ɾ�
--TRUNCATE �� ���̺��� ROW�� �����ִ� ��ɾ�. DELETE�� �޸� ROLLBACK ���� �����Ƿ� �� ���� ������ �����ϴ�.
--            �׷��� WHERE ���� ����� �� �����Ƿ� �κл��� �Ұ�

--+ ���̺� ����
-- : DROP TABLE �ϸ� ������ó�� DBMS�� RECYCLBIN (������)�� ����ó�� 
SHOW RECYCLEBIN

FLASHBACK TABLE EMPS
TO BEFORE DROP;

DESC EMPS;

SELECT * FROM EMPS;

DROP TABLE EMPS;

SHOW RECYCLEBIN

-- ������ ����
PURGE RECYCLEBIN;

SHOW RECYCLEBIN

-- DROP TABLE EMPS PURGE;  # PURGE���� �ٷ� ����ϸ� ������ ��ġ�� �ʰ� ���� ���� (���� ���� �ʿ�)

--+ ���̺� �̸� ����
RENAME COPY_EMP2
TO EMPS;

DESC COPY_EMP2

-- + ���̺� �ּ� �ޱ�
COMMENT ON TABLE EMPS
IS 'THIS TABLE IS EMPLOYEE TABLE';

--�ּ��� ������ ��ųʸ����� Ȯ���� �� ����.
DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;

--+DDL ����
--1. ���ü�
--: ���� ����
--: ���ü� ���� - Ʈ����� EX) ���� ������ü (TCL - COMMIT, ROLLBACK, SAVEPOINT)

--2. ���Ἲ
--: ���Ἲ ������Ű���� ? DDL. DML���� �� �� ���̺� ������ ������ ���� ������ �� �ֵ��� �ϸ� �ȴ�. 
--: ���� ���� 
-- 1) PRIMARY KEY : ���� �ʼ�
-- 2) NOT NULL 
-- 3) CHECK
-- 4) UNIQUE
-- 5) FOREIGN KEY
 
--EX) EMP ���̺�, DEPT ���̺�
-- EMPNO : NULL(X), �ߺ�(X) - PRIMARY KEY
-- ENAME : NULL(X), �ߺ�(O) - NOT NULL 
-- SAL : �޿��� 0���ٴ� Ŀ���Ѵ� - CHECK
-- DEPTNO : �μ� ���̺� �� �ϳ� - FOREIGN KEY
-- ========================================
-- DEPTNO : NULL(X), �ߺ�(X) - PRIMARY KEY
-- DNAME : �ߺ�(X), ���� - UNIQUE

--+ ���� ���� ���� 
--1) �÷� ���� ���� ���
-- : �÷��� DATATYPE [CONSTRAINT �����] ��������
--: ������� �����ϸ� SYS_C������ ���·� ���� �ο���

CREATE TABLE DEPT1
(DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(20) UNIQUE,
LOC VARCHAR(20));

DESC DEPT1

--���� ���� ���� : ������ ��ųʸ�
DESC USER_CONSTRAINTS

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS;

--2) ���̺� ���� ���� ���
--�÷��� DATATYPE
--�÷��� DATATYPE
--�÷��� DATATYPE
--CONSTRINT ����� �������� (�÷���),
--CONSTRINT ����� �������� (�÷���),
--....

CREATE TABLE EMP1
(EMPNO NUMBER(4) CONSTRAINT EMP1_EMPNO_PK PRIMARY KEY, --���������ϳ� �̷��԰� �����ϴ� ǥ���
ENAME VARCHAR2(20) NOT NULL,
SAL NUMBER(7,2),
DEPTNO NUMBER(2),
CONSTRAINT EMP1_SAL_CK CHECK (SAL BETWEEN 500 AND 5000),
CONSTRAINT EMP1_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT1 (DEPTNO));

DESC EMP1

INSERT INTO DEPT1
VALUES(1, '����', '����');

INSERT INTO DEPT1
VALUES(1, 'ȸ��', '�λ�');

INSERT INTO EMP1
VALUES(1111, 'HONG', 3000, 1);

--�������� �߰� 
ALTER TABLE DEPT1
ADD CONSTRAINT DEPT1_LOIC_UQ UNIQUE (LOC);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP1', 'DEPT1');

--�������� ����
ALTER TABLE DEPT1
DROP CONSTRAINT DEPT1_LOIC_UQ;

--DEFAULT KEYWORD
CREATE TABLE DEPT2
(DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(20) UNIQUE,
LOC VARCHAR(20) DEFAULT '-');

INSERT INTO DEPT2
VALUES(1, '����');
