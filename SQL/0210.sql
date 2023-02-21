--[��������]
--: ������ select�� ��� ���
--: select ���� �������� �־��� �� ���� - �������� ���� select���� ����������� ��
--: ���������� �����Ϸ��� ���� ǥ���ϴ� �κ� - ��������
--
--�������� ���Ⱚ�� �ϳ��̸� ������ ��������
--                �������̸� ������ ��������
--
--* ���ǻ���
--1) ���������� �ݵ�� ��ȣ �ȿ� ����

SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

--2) ������ �������� �տ��� �񱳿�����(SINGLE ROW OPERATOR)�� �;� �Ѵ�.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JOBES' OR COMM IS NOT NULL);
            

--3) ������ �������� �տ��� MULTIPLE ROW OPERATOR ( IN, ANY, ALL)�� �;� �Ѵ�.
--IN ������: ���� �� �� �ϳ��� ����.
--e.g. [10�� �μ� ������� �޿��� ���� �޿�]�� �޴� [����� �̸��� �޿� ��ȸ]
-- 1��° ������ ����� 3���� ���� => ����������
SELECT *
FROM EMP
WHERE DEPTNO = 10;

SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL
              FROM EMP
              WHERE DEPTNO = 10);
--���� : �μ� ��ȣ�� 10, 20, 30���� �������� �μ� ��ȣ�� ��� �޿� �� �ϳ��� ���� �޿��� �޴� ����� ���, �̸�, �޿� ������ ��ȸ�ϼ���.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL)) 
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--���� : �μ� ��ȣ���� ���� ���� �޿��� �޴� ����� ������ ����ϼ��� - 5��
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);
                
--���� : �ٸ� ������ ������� �ٹ��ϰ� �ִ� ������ ���, �̸�, �޿��� ��ȸ�ϼ���.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR 
                FROM EMP);
                
-- �ݴ�� �ٸ� ������ ����� �ƴ� (���������� ����) �������� ���, �̸� , �޿��� ��ȸ�ϼ���
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR 
                    FROM EMP
                    WHERE MGR IS NOT NULL);
                    
--ANY ������: ���� �� �� �ϳ�. �� �����ڰ� �տ� ���;� ��.
--           �� �ϳ��� ����Ʈ�� �� �Ǵ� �������� ��ȯ�Ǵ� ���� ��
--SALESMAN ��å�� �޿����� ���� �޴� ����� ������ �޿��� ��ȸ
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                    WHERE JOB ='SALESMAN');
                    
--���� : �μ� ��ȣ�� 10, 20, 30���� �������� �μ� ��ȣ�� ��� �޿� �� �ϳ����� �۰ų� ���� �޿��� �޴� ������ �޿�, �̸�, ����� ��ȸ�ϼ���.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= ANY (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--���� ���
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= (SELECT MAX(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
-- ALL ������ : ��� ��
--            : �񱳿����ڰ� �տ� ��ġ
-- ��� SALESMAN�� �޿����� ���� �޴� ����� ��� ��� �޿� ������ ��ȸ
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL --> ANY�� ���Ͱ� ��, ALL�� ���δ�?? �̰� �����ϱ�
                FROM EMP
                WHERE JOB = 'SALESMAN');
                
--���� : �μ� ��ȣ�� 10, 20, 30���� �������� �μ� ��ȣ�� ��� �޿� ��κ��� ���� �޿��� �޴� ������ �޿�, �̸�, ����� ��ȸ�ϼ���.
--1. ���� �� ��������
SELECT ENAME, EMPNO, SAL
FROM EMP
WHERE SAL < ALL (SELECT AVG(SAL) 
                    FROM EMP
                    WHERE DEPTNO IN (10, 20, 30)
                    GROUP BY DEPTNO);

--2. ���� �� ��������
SELECT ENAME, EMPNO, SAL
FROM EMP
WHERE SAL < (SELECT MIN(AVG(SAL))
                    FROM EMP
                    WHERE DEPTNO IN (10, 20, 30)
                    GROUP BY DEPTNO);

-- 4) ������ �������� �����Լ� ��� ����
-- EMP ���̺��� �μ��� ��ձ޿��� ���� ū �μ���ȣ�� �� ��ձ޿��� ���Ͻÿ�

SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);


-- EMP ���̺��� [��å�� ��� �޿��� ���� ���� ��å]�� �� ��� �޿��� ���Ͻÿ�
SELECT MIN(AVG(SAL))
FROM EMP
GROUP BY JOB;

SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                    FROM EMP
                    GROUP BY JOB);
                    
-- 5) ���������� ���������� ��ȯ�Ǵ� ���� ������ '���õ� ���� ����'��� �޼����� ǥ�õ�
--    �߿�/����) ������ ���� ������ �ش� �÷��� NULL�� ��쵵 ���� ���� �޼��� ǥ�õ� (�ִµ� ���ٰ� NULL�̶�� ����)
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
            FROM EMP
            WHERE EMPNO = 9999);

-- �����ϴ� ���� ������ NULL ������ ���� ���� ������ �߻��� �� �����Ƿ� �������� �ذ��ؾ� ��
-- �ذ��� ( ���� �����ϴ� ���, ���� BEST�� ���!)
-- �� NULL ���·� ���� �ʰ� ��ü������ ä��� - ������ Ư���� ���� ������ Ư���� �°�
--        ����� ���Ǹ� ��ģ ��, ���� ������ ���� �ʴ� ������ ä��� 
--        ���� ������ �����̶�� '-' ��, ���� ������ �����̶�� 0��, ��������� �����Ǵ� ��(��հ�, �߾Ӱ�, �ֺ�)
--        ��ü���� �̸� �Է��� �ξ�����, ���� ����� ǥ�õ� �� ����

-- �� NULL ó�� �Լ� (������ �ǵ� �� ���� ��Ȳ�� ��) 
--    NVL, IS NOT NUL �� ���
--    �������� ���̳� �ε��� Ű �� ��������� ���� �����ͺ��̽��� ���ϸ� �� �� ������ ����

-- 6) EXISTS ������: ���̺� Ư�� ���� �ִ��� ���ο� ���� ���� ����� �޶����� ���ǿ� ���
--                : �������� �����Ͱ� �����ϴ°��� üũ�� ���� ���� (True/False)�� ����� ��ȯ
--                : �������� ������� ã���� inner query ������ �ߴ��ϰ� True�� ��ȯ

-- ��������: �μ����� ���� �μ� ���� ��ȸ

-- �� �μ����� �ִ� ���̺� ����
SELECT *
FROM EMP
WHERE EMP.DEPTNO = DEPT.DEPTNO; 

-- �� ���� ������ ���� ���� ��ȸ
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT *
                  FROM EMP
                  WHERE EMP.DEPTNO = DEPT.DEPTNO);
                     
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;

--> ������̺��� ���� ������� ���� �μ���ȣ�� ���� ��ȸ
-----> �����ϰ��� �ϴ� ������ ��� ���̺��� DEPT������, EMP ���̺�� �����Ͽ� �μ���ȣ�� üũ
-----> �� ���̺��� ����� 1:N ����. �׷��Ƿ� ���ʿ��ϰ� EMP ���̺��� ��� �о�߸� �ϴ� ������
-----> ���������δ� �ߺ����Ÿ� �ؼ� �ùٸ� ����� ���� �ִ� ����.

SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1
            FROM EMP E
            WHERE E.DEPTNO = D.DEPTNO);
--> �ӵ� ����.. ��..?? ���ο��� TRUE FALSE�� ���ؼ� ��������?
-- EXISTS �����ڸ� ����� ���ǹ�: �����ϰ��� �ϴ� ����� FROM ���� ���� 
-- EMP ���̺��� üũ�� �ϱ� ���� EXISTS ���� ��ġ��Ŵ => ��ü ���� �ӵ� ���� ���


-- 7) �������������� ORDER BY ���� �������� �ʴ´�. (���� X)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES')
--             ORDER BY 1 DESC); --> ORDER BY ���� �� �ϹǷ� ���� �߻�. ���ʿ���
ORDER BY SAL;    --> ������ �������� ���� �ڿ� ����                
                    
--[��������]
--: ���� �����ڰ� ���Ե� ����
--: ���� ������? �� �̻��� ������� ���� ����� �ϳ��� ����� ����
--: ���� - UNION, UNION ALL, INTERSECT, MINUS (SET OPERATOR) (����)
--: ���� �����ڴ� ��� �켱������ ����.
--: ��������� �ֿ켱 ������ ��ȣ()�� ������ �������� �ʴ� �� ���ʿ��� ������, ������ �Ʒ��� �����ڸ� ����
--: �ٸ� ���� �����ڿ� �Բ� MINUS�� ���� �������̶�� ������ ��ġ�� ����

--* ���տ����� ��ħ
--: SELECT ���� ����Ʈ�� ǥ������ ������ ��ġ�ؾ� �Ѵ�.
--: �ι�° ������ �ִ� �� ���� ������ ������ ù��° ������ �ִ� (Ȥ�� �����ϴ�) ���� ������ ������ ��ġ�ؾ� ��
--: ��������� �����Ϸ��� ��ȣ�� ����Ѵ�.
--: ��������� �����Ϸ��� ORDER BY ���� ��ɹ��� �� ���� ����Ѵ�.

--UNION: ������
--     : �� ���̺��� ����. ���ս�Ű�� �� ���̺��� �ߺ����� ���� ���� ��ȯ
-- ��������: �μ���ȣ ��ȸ
SELECT DEPTNO
FROM EMP
UNION
SELECT DEPTNO DEPT;                    

--[ DML (Data Manipulation Language ] : ������ ���۾�
--: ���̺��� �� �� �߰�
--: ���̺��� ���� ���� ����
--: ���̺��� ���� ���� ����
--: ���̺� ���� ����

--INSERT ���� (�� ����)
--1) �� �� ����
--INSERT INTO ���̺��
--VALUES (������ ������);
DESC DEPT --> F9 Ŭ��
--�̸�     ��? ����
-------- -- ------------
--DEPTNO    NUMBER(2)     --> ����, 2�ڸ� ���� �� ����
--DNAME     VARCHAR2(14)  --> ����, 14�ڸ� ���� �� ����
--LOC       VARCHAR2(13)  --> ����, 13�ڸ� ���� �� ����
INSERT INTO DEPT
VALUES (50, 'A', 'B');      --> 1�μ�Ʈ ������ 1�� �߰�. �߰� �� ���� ��� 1�྿��
SELECT * FROM DEPT;         --> �߰��� 1�� Ȯ�� ����

--2) NULL ���� ���� �� ���� (���� X)
--�Ͻ���: �� ����Ʈ���� �� ����
INSERT INTO DEPT (DEPTNO, DNAME)
VALUES (60, 'C');
SELECT * FROM DEPT;
--�����: VALUE ������ NULL Ű���� ����
INSERT INTO DEPT
VALUES (70, 'D', NULL);
SELECT * FROM DEPT;
                    
-- 3) Ư�� �� ���� : �Լ� ��� ����
INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9090, SYSDATE);

SELECT * FROM EMP WHERE EMPNO = 9090; -- ���� �������� ���� 

--CF)
SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--SYSDATE : �ý��ۿ����� ���� �ð��� ��ȯ
--CURRENT_DATE : ���� ���ǿ����� ���� �ð��� ��ȯ

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

ALTER SESSION SET TIME_ZONE = '-5:0';

SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--4) Ư�� ��¥ �� �ð� ���� : ��ȯ �Լ� ���
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES(9091, SYSDATE);

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES(9093, TO_DATE(SYSDATE, 'DD-MON-RR'));

--���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

DELETE FROM EMP WHERE EMPNO IN (9090, 9093);

--5) ��ũ��Ʈ �ۼ�
-- : SQL���� &ġȯ�� ����Ͽ� ���� �Է��ϵ��� �䱸
-- : &ġȯ - & �������� ���� ��ġ ǥ����
INSERT INTO DEPT(DEPTNO, DNAME, LOC) --ȸ�翡�� 6���� ������ ��� �ٲٶ�� �ϴ� ����̶� �����.
VALUES (&DEPTNO, '&DNAME', '&LOC');

--6) �ٸ� ���̺��� �� �����ؼ� ���� 
-- ���� ������ ����Ͽ� �� ���� ���� ������ �߰��ϱ� (���ÿ� �ѹ��� ���� �� ����)
SELECT * FROM SALGRADE;

INSERT INTO DEPT (DEPTNO) -- ��������ó�� ���� (VALUES��� SELECT �ֱ�)
SELECT GRADE FROM SALGRADE
WHERE GRADE = 1;

SELECT * FROM DEPT;

--UPDATE ���� (������ ����)
-- 1) ���̺� �� ����
-- WHERE�� ������ ��� �� ����
-- WHERE�� ������ Ư�� �� ����
UPDATE DEPT
SET DNAME = 'G'
WHERE DEPTNO = 60;

--2) ���������� ����Ͽ� ���� �� ���� ����
-- : SET���� ���������� ���� �� ����Ͽ� ���ÿ� ���� �÷� ���� ���� ����
-- : ���ÿ� ���� ���ڵ带 �����ϴ� ���� �ƴԿ� ���� !
CREATE TABLE CEMP
AS
SELECT * FROM EMP;

--7900����� ��å�� �޿��� ���ÿ� ���� <- 7521 ����� ��å�� �޿��� ����
UPDATE CEMP
SET JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO =7521),
    SAL = (SELECT SAL
            FROM CEMP
            WHERE EMPNO = 7521)
WHERE EMPNO = 7900;

-- ���� : CEMP ���̺��� ����� 7499�� ����� ������ ��å�� ���� ������� SAL���� 7902����� SAL ������ �����ϼ���.
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

