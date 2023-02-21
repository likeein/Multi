--[ DML (Data Manipulation Language] : ������ ���۾�
-- : ���̺��� �� ���� �߰�
-- : ���̺��� ���� ���� ����
-- : ���̺��� ���� ���� ����
--: ���̺� ���� ����

--INSERT ���� (�� ����)
--1) �� �� ����
--INSERT INTO ���̺�� VALUES (������ ������);
DESC DEPT  --> F9 Ŭ��

INSERT INTO DEPT
VALUES (50, 'A', 'B');  --> 1�μ�Ʈ ������ 1�� �߰�. �߰� �� ���� ��� 1�྿��

SELECT * FROM DEPT;  --> �߰��� 1�� Ȯ�� ����

-- 2) NULL ���� ���� ���� ���� (���� X)
--�Ͻ��� : �� ����Ʈ���� ���� ����
INSERT INTO DEPT (DEPTNO, DNAME)
VALUES (60, 'C');

SELECT * FROM DEPT;

--����� : VALUES ������ NULL Ű���� ����
INSERT INTO DEPT
VALUES (70, 'D', NULL);

SELECT * FROM DEPT;

--3) Ư���� ���� : �Լ� ��� ����
INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9090, SYSDATE);

SELECT * FROM EMP WHERE EMPNO = 9090;  -- ���� �������� ���� 

-- cf)
SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--SYSDATE : �ý��ۿ����� ���� �ð��� ��ȯ
--CURRENT_DATE : ���� ���ǿ����� ���� �ð��� ��ȯ

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL; 

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

ALTER SESSION SET TIME_ZONE = '-5:0';

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL; 

SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--4) Ư�� ��¥ �� �ð� ���� : ��ȯ �Լ� ���
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9092, SYSDATE);

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9093, TO_DATE(SYSDATE, 'DD-MON-RR'));

SELECT * FROM EMP;

-- ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

SELECT * FROM EMP;

DELETE FROM EMP WHERE EMPNO IN (9090, 9091, 9092, 9093);

--5) ��ũ��Ʈ �ۼ�
-- : SQL���� &ġȯ�� ����Ͽ� ���� �Է��ϵ��� �䱸
-- : &ġȯ - &�������� ���� ��ġ ǥ���� 
SELECT * FROM DEPT;

INSERT INTO DEPT (DEPTNO, DNAME, LOC)   --ȸ�翡�� 6���� ������ ��� �ٲٶ�� �ϴ� ����̶� �����.
VALUES (&DEPTNO, '&DNAME', '&LOC');

SELECT * FROM DEPT;

-- 6) �ٸ� ���̺��� �� �����ؼ� ����
-- ���� ������ ����Ͽ� �� ���� ���� ������ �߰��ϱ� (���ÿ� �ѹ��� ���� �� ����)
SELECT * FROM SALGRADE;

INSERT INTO DEPT (DEPTNO)  -- ��������ó�� ���� (VALUES��� SELECT �ֱ�)
SELECT GRADE FROM SALGRADE
WHERE GRADE = 1;

SELECT * FROM DEPT;

--UPDATE ���� (������ ����)
--1) ���̺� �� ����
-- - WHERE �� �� : ��� �� ����
-- - WHERE �� �� : Ư�� �� ����

SELECT * FROM DEPT;

UPDATE DEPT
SET DNAME = 'G'
WHERE DEPTNO = 60;

SELECT * FROM DEPT;

--2) ���������� ����Ͽ� ���� �� ���� ����
-- : SET ���� ���������� ���� �� ����Ͽ� ���ÿ� ���� �÷����� ���� ����
-- : ���ÿ� ���� ���ڵ带 �����ϴ� ���� �ƴԿ� ����!

CREATE TABLE CEMP
AS
SELECT * FROM EMP;

SELECT * FROM CEMP;

-- 7900 ����� ��å�� �޿��� ���ÿ� ���� <- 7521 ����� ��å�� �޿��� ����
UPDATE CEMP
SET JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO = 7521),
    SAL = (SELECT SAL
           FROM CEMP
           WHERE EMPNO = 7521)
WHERE EMPNO = 7900;

SELECT * FROM CEMP;

--���� : CEMP ���̺��� ����� 7499�� ����� ������ ��å�� ���� ������� SAL����
--      7902 ����� SAL ������ �����ϼ���.

UPDATE CEMP
SET SAL = (SELECT SAL
            FROM CEMP
            WHERE EMPNO = 7902)
WHERE JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO = 7499);


SELECT * FROM CEMP;

--3) �ٸ� ���̺��� ������� �� ���� : �������� �̿�
CREATE TABLE COPY_EMP
AS
SELECT * FROM EMP;

--EMP ���̺� ������� �Ͽ� ��� ��ȣ�� 7934�� ����� ��å�� ������ ����� �μ� ��ȣ�� 
--���� 7902 ����� �μ���ȣ�� ��� �����Ѵ�.
UPDATE COPY_EMP
SET DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE EMPNO = 7902)
WHERE JOB = (SELECT JOB
            FROM EMP
            WHERE EMPNO = 7934);
            
--���� : EMP ���̺��� ������� �����ȣ�� 7934�� ����� �Ŵ����� ������ �μ���ȣ�� ������ �ִ�
--      ��� ����� �μ���ȣ�� ���� (COPY_EMP) 7902 ����� �μ���ȣ�� ��� �����ϼ���.
UPDATE COPY_EMP
SET DEPYNO = (SELECT DEPTNO
                FROM COPY_EMP
                WHERE EMPNO = 7902)
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE EMPNO = (SELECT MGR
                                FROM EMP
                                WHERE EMPNO = 7934));

-- DELETE ���� : �� ����
-- 1) ���̺��� �� ����
-- - WHERE�� ������ : ���̺� ��� �� ����
-- - WHERE�� ������ : Ư�� �� ����
-- DELETE FROM ���̺� WHERE ��
DELETE FROM DEPT
WHERE DEPTNO = 50; -- DELETE�� FROM ���� ���� 

-- DELETE ������ ���������� FROM KEYWORD ���� ����
DELETE DEPT
WHERE DEPTNO IN(60,70);

CREATE TABLE CDEPT
AS
SELECT * FROM DEPT;

--2) �ٸ� ���̺��� ������� �� ���� ����
DELETE COPY_EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE DNAME = 'RESEARCH');

SELECT * FROM COPY_EMP; 
                
--ROLLBACK;
--cf) TRUNCATE ���� (DDL ����)
-- : ���̺� ������ ��� ���ܳ���ä ��� �� ����
-- : ��! �ѹ��� �ȵǹǷ� ������ ��
-- ���� - TRUNCATE TABLE ���̺��;
