--[��������]
-- : ������ select�� ��� ���
-- : select���� �������� �־��� �� ���� - �������� ���� select���� ���������ϰ� �Ѵ�.
-- : ���������� �����Ϸ��� ���� ǥ���ϴ� �κ� - ��������
-- 
-- �������� ���Ⱚ�� �ϳ��̸� ������ ��������
--                   �������� ������ ��������
--                   
--* ���ǻ���
--1) ���������� �ݵ�� ��ȣ �ȿ� ����
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES');
            
--2) ������ �������� �տ��� SINGLE ROW OPERATOR (�� ������) �� �;� �Ѵ�. 
-- : =, >=, <=, >, <, ==, <>

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES' OR COMM IS NOT NULL);
            
--3) ������ �������� �տ��� MULTIPLE ROW OPERATOR (IN, ANY, ALL) �� �;� �Ѵ�. 
-- IN ������ : ���� �� �� �ϳ��� ����.

-- 10�� �μ� ������� �޿��� ���� �޿��� �޴� ����� �̸��� �޿��� ��ȸ
-- 1��° ������ ����� 3���� ���� => ����������
SELECT SAL
FROM EMP
WHERE DEPTNO = 10;

SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL
               FROM EMP
               WHERE DEPTNO = 10);
               
--���� : �μ���ȣ�� 10, 20, 30���� �������� �μ���ȣ�� ��� �޿� �� �ϳ��� ���� �޿��� �޴�
--       ����� ���, �̸�, �޿� ������ ��ȸ�ϼ���.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--���� : �μ���ȣ���� ���� ���� �޿��� �޴� ����� ������ ����ϼ��� - 5��
SELECT MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
            FROM EMP
            GROUP BY DEPTNO);
            
            
--���� : �ٸ� ������ ������� �ٹ��ϰ� �ִ� ������ ���, �̸�, �޿��� ��ȸ�ϼ��� - 5��
SELECT MGR
FROM EMP;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR
                 FROM EMP);
                 
--�ݴ�� �ٸ� ������ ����� �ƴ� (���������� ����) �������� ���, �̸�, �޿��� ��ȸ�ϼ��� - 3��
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP);

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP
                    WHERE MGR IS NOT NULL);

--ANY ������ : ���� �� �� �ϳ� 
--           : �� �����ڰ� �տ� ���;� ��.
--           : �� �ϳ��� ����Ʈ�� �� �Ǵ� �������� ��ȯ�Ǵ� ���� ���� ��
--           
--SALESMAN ��å�� �޿����� ���� �޴� ����� ������ �޿��� ��ȸ

SELECT SAL
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL
            FROM EMP
            WHERE JOB = 'SALESMAN');

--���� : �μ���ȣ�� 10, 20, 30���� �������� �μ���ȣ�� ��� �޿� �� �ϳ����� �۰ų� ���� �޿��� �޴�
--       ������ �޿�, �̸�, ����� ��ȸ�ϼ���.

SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= ANY (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);

SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO;

-- ���� ���
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= (SELECT MAX(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--ALL ������ : ��� ��
--           : �� �����ڰ� �տ� ��ġ

--��� SALESMAN�� �޿����� ���� �޴� ����� ������ �޿� ������ ��ȸ
SELECT SAL
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL  --> ANY�� ���Ͱ� ��, ALL�� ���δ�?? �̰� �����ϱ�
                FROM EMP
                WHERE JOB = 'SALESMAN');

--���� : �μ���ȣ�� 10, 20, 30���� �������� �μ���ȣ�� ��ձ޿� ��κ��� ���� �޿��� �޴�
--       ������ ���, �޿�, �̸��� ��ȸ�ϼ��� - 8��
--�� ������ ��������
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL < ALL (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);

SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO;
--�� ������ ��������
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < (SELECT MIN(AVG(SAL))
             FROM EMP
             WHERE DEPTNO IN (10, 20, 30)
             GROUP BY DEPTNO);
             
--4) ���� �� �������� �����Լ� ��� ����
--EMP ���̺��� �μ��� ��ձ޿��� ���� ū �μ���ȣ�� �� ��ձ޿��� ���Ͻÿ�
SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;


SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);

--���� : EMP ���̺��� ��å�� ��� �޿��� ���� ���� ��å�� �� ��ձ޿��� ���Ͻÿ�
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                    FROM EMP
                    GROUP BY JOB);
                    
--5) ���������� ���������� ��ȯ�Ǵ� ���� ������ '���õ� ���� ����' �̶�� �޽����� ǥ�õ�.
--   �߿�/����)������ ���� ������ �ش� �÷��� NULL�� ��쵵 '���õ� ���� ����' �̶�� �޽����� ǥ�õʿ� ���� 
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
              FROM EMP
              WHERE EMPNO = 9999);
              
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP);

--�����ϴ� ���� ������ NULL ������ ���� ���� ������ �߻��� �� �����Ƿ� �������� �ذ��ؾ� ��.
--�ذ��ϴ� ���
--�� NULL ���·� ���� �ʰ� ��ü������ ä���
--  ���ڵ����� �����̶�� '-' ��, ���� ������ ���� 0��, ��������� �����Ǵ� �� (��հ�, �߾Ӱ�, �ֺ� ��) 
--  : ��ü���� �̸� �Է��صθ� ���� ����� ǥ�õ� �� ����.
--  
--�� NULL ó�� �Լ�
--  : �������� ���̳� �ε��� Ű �� ��������� ���� �����ͺ��̽��� ���ϸ� ����


SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP
                    WHERE MGR IS NOT NULL);

--6) EXISTS ������ : ���̺� Ư�� ���� �ִ��� ���ο� ���� ���� ����� �޶����� ���ǿ� ����ϴ� ������
--                  : �������� �����Ͱ� �����ϴ°��� üũ�� ���� ���� (True/False)�� ����� ��ȯ
--                  : �������� ������� ã���� inner query ������ �ߴ��ϰ� True �� ��ȯ 

-- �� �μ����� ���� �μ������� ��ȸ
SELECT * 
FROM DEPT
WHERE NOT EXISTS (SELECT *
                    FROM EMP
                    WHERE EMP.DEPTNO = DEPT.DEPTNO);

SELECT D.DEPTNO, D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;

-- �� ���� ������ ���� ���� ��ȸ
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT *
                  FROM EMP
                  WHERE EMP.DEPTNO = DEPT.DEPTNO);
                     
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;


--��� ���̺��� ���� ������� ���� �μ���ȣ�� ������ ��ȸ
--=> �����ϰ��� �ϴ� ������ ��� ���̺��� DEPT������ EMP ���̺�� �����Ͽ� �μ���ȣ�� üũ�ؾ� ��.
--   �� ���̺��� ����� 1:N ������. �׷��Ƿ� ���ʿ��ϰ� EMP ���̺��� ��� �о�߸� �ϴ� ������.
--   ���������δ� �ߺ����Ÿ� �ؼ� �ùٸ� ����� ���� �ִ� ����.

SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1
               FROM EMP E
               WHERE E.DEPTNO = D.DEPTNO);

--EXISTS �����ڸ� ����� ���ǹ�
-- : �����ϰ��� �ϴ� ����� FROM ���� ���� EMP ���̺��� üũ�� �ϱ� ���� EXISTS ���� ��ġ��Ų ����
--   �׷��� ��ü ����ӵ��� ���� ����

-- 7) �������������� ORDER BY ���� �������� �ʴ´�. (���� �߻���) (���� X)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES')  --> ORDER BY ���� �� �ϹǷ� ���� �߻�. ���ʿ���
ORDER BY SAL;  --> ������ �������� ���� �ڿ� ���� 

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
