--���������� ����

--1. ���� ������ ���� ����� ����
--    1) ���� �� ��������
--    2) ���� �� �������� 
--    3) ���� �� ��������
    
--2. ���������� ���� ���
--    1) �Ϲ� ��������
--    2) ��� ������ ��������

--===========================================================================================
--    ���� 1. emp���̺��� ������ ���� ���� �޴� ����� �̸�, ����, �޿�, �Ի����� ����ϴ� ������ �ۼ��ϼ���.
        SELECT ENAME, JOB, SAL, HIREDATE
        FROM EMP
        WHERE SAL = (SELECT MAX(SAL)
                    FROM EMP);
                
--    ���� 2. EMP ���̺��� SCOTT ����� ������ �޿��� �޴� ��� ����� �̸�, ����, �޿�, �μ���ȣ�� ����ϴ� ������ �ۼ��ϼ���.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL = (SELECT SAL             --<- = �̰� ���� �ϳ� �̻� ��ȯ�Ѵٸ� IN���� 
                    FROM EMP
                    WHERE ENAME = 'SCOTT');
                  
--    ����1. EMP ���̺��� ������ ��� ��ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ������ ����ϴ� ������ �ۼ��ϼ���.
        SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO 
        FROM EMP 
        WHERE EMPNO IN (SELECT MGR
                        FROM EMP);

-- ANY -> OR ����, ���������� ��� �ȵ�
--    ����2. EMP���̺��� 30�� �μ��� ���� � ������� �� ���� �޿��� �޴� ������� �̸�, ����, �޿�, �μ���ȣ�� ����ϴ� ������ �ۼ��ϼ���.
--        ��, 30�� �μ��� ����� �����մϴ�.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL > ANY (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
            AND DEPTNO != 30;
            
-- ALL -> AND ����, ���������� ��� �ȵ�
--    ����3. EMP���̺��� 30�� �μ��� ���� ��� ������� �� ���� �޿��� �޴� ������� �̸�, ����, �޿�, �μ���ȣ�� ����ϴ� ������ �ۼ��ϼ���.
--        ��, 30�� �μ��� ����� �����մϴ�.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL > ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
            AND DEPTNO != 30;
            
--EXISTS
--EMP ���̺��� ������ ��� ��ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ������ ����ϴ� ������ �ۼ��ϼ���.
        SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO 
        FROM EMP E
        WHERE EXISTS (SELECT *
                        FROM EMP
                        WHERE MGR = E.EMPNO);

--EMP ���̺��� SCOTT ����� ������ �޿��� �޴� ��� ����� �̸�, ����, �޿�, �μ���ȣ�� ����ϴ� ������ �ۼ��ϼ���.
SELECT *
FROM EMP
WHERE (SAL, NVL(COMM, -1)) IN (SELECT SAL, NVL(COMM, -1)
                                FROM EMP
                                WHERE ENAME = 'SCOTT');
                        
-- �� ����
CREATE VIEW EMP_S
AS
SELECT ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP;

SELECT *
FROM (SELECT ENAME, JOB, SAL, HIREDATE, DEPTNO
        FROM EMP);

SELECT E.*, DNAME, LOC
FROM (SELECT ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP) E INNER JOIN DEPT 
    ON E.DEPTNO = DEPT.DEPTNO;

--WITH -> ���� ���⼺�� �����ϰ� �ۼ� �����ϰ� ����
SELECT E.*, DNAME, LOC
FROM (SELECT ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP) E INNER JOIN DEPT 
    ON E.DEPTNO = DEPT.DEPTNO
WHERE EXISTS (SELECT * FROM EMP WHERE MGR = E.EMPNO);

WITH
EMP_S AS (SELECT ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP)
EMP_MGR AS (SELECT * FROM EMP WHERE MGR = E.EMPNO)
SELECT E.*, DNAME, LOC
FROM EMP_S E INNER JOIN DEPT 
    ON E.DEPTNO = DEPT.DEPTNO
WHERE EXISTS EMP_MGR;
--===========================================================================================
--EMP ���̺��� �� �⵵�� �Ի��� ����� ���� ����ϴ� ������ �ۼ��ϼ���.
--��, ���������� �̿��Ͽ� ������ �ذ��մϴ�.
SELECT (SELECT COUNT(*) FROM EMP) TOTAL,
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1980') "1980",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981') "1981",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1982') "1982",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1983') "1983"
FROM DUAL;

--�� ����� �̸�, ����, �Ի���,�μ� ��ȣ ,�μ���, �ٹ� ��ġ�� ����ϴ� ������ �ۼ��ϼ���.
--�� ������ ������� �ʽ��ϴ�. 
SELECT ENMAE, JOB, HIREDATE, DEPTNO, (SELECT DANME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAMEI   
FROM EMP E;

--===========================================================================================
INSERT INTO (SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP)
VALUES (9999, 'LONG', 'CLERK', 700, 40);

CREATE TABLE EMP_ORDER
AS
SELECT * FROM EMP
WHERE 1=2;          --������ ������ ���� �����͸� ������ ���°� �ƴ�

SELECT * FROM EMP_ORDER;

INSERT INTO EMP_PRDER
SELECT * FROM EMP ORDER BY HIREDATE;
--===========================================================================================
--NEW YORK�� �ٹ��ϴ� ��� ����� ������ ��ȣ�� SCOTT ����� ������ ��ȣ�� �����ϵ��� �����ϴ� �ڵ带 �ۼ��ϼ���.
SELECT * FROM DEPT WHERE LOC = 'NEW YORK';
SELECT ENAME, MGR FROM EMP WHERE ENAME = 'SCOTT';

UPDATE EMP
SET MGR = (SELECT MGR FROM EMP WHERE ENAME = 'SCOTT')
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'NEW YORK');

DELETE FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
--=========================================================================================
- ����] �Ʒ��� ���̺� ������ ���������� ������ dept2, emp2 ���̺��� �����ϴ� ������ �ۼ��ϼ���.
CREATE TABLE DEPT2 (
    DEPTNO NUMBER(2)    CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14)  CONSTRAINT DEPT2_DNAME_NN NOT NULL,
    LOC VARCHAR2(13),
    CONSTRAINT DEPT2_DNAME_UK UNIQUE(DNAME)
);

CREATE TABLE EMP2 (
    EMPNO NUMBER(4)     CONSTRAINT EMP2_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10)  CONSTRAINT EMP2_ENAME_NN NOT NULL,
    JOB VARCHAR2(9)     CONSTRAINT EMP2_JOB_CK CHECK (JOB IN ('ANALYST', 'CLERK', 'MANAGER', 'SALESMAN', 'PRESIDENT')),
    MGR NUMBER(4)       CONSTRAINT EMP2_MGR_FK REFERENCES EMP2 (EMPNO),
    HIREDATE DATE       DEFAULT SYSDATE, 
    SAL NUMBER(7,2)     CONSTRAINT EMP2_SAL_NN NOT NULL,
    COMM NUMBER(7,2),
    DEPTNO NUMBER(2),
    CONSTRAINT EMP2_ENAME_UK UNIQUE(ENAME),
    CONSTRAINT EMP2_SAL_CK CHECK (SAL BETWEEN 700 AND 9999),
    CONSTRAINT EMP2_DEPTNO_FK FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO)
);

CREATE TABLE DEPT3(
    DEPTNO NUMBER(2)    CONSTRAINT DEPT2_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14)  CONSTRAINT DEPT2_DNAME_NN NOT NULL,
    LOC VARCHAR2(13),
    CONSTRAINT DEPT2_DNAME_UK UNIQUE(DNAME)
); 