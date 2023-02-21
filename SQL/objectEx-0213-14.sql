--+ View(��) ��ü
--
-- : ���̺� �Ǵ� �ٸ� �並 ������� �ϴ� ������ ���̺�.
-- : ��ü������ �����͸� ���� ������ ������ ���̺��� �����͸� ���ų� ������ �� �ִ� window ������ �ϴ� ��ü.
-- : ���� ����� �Ǵ� ���̺��� �⺻ ���̺��̶�� �θ���. 
-- : ��� ������ ��ųʸ��� select������ �����.
-- : ��� ���� 1) ���� ����  2) �������� �ܼ���

--1. �� ����
CREATE VIEW EMPVW30
AS
SELECT EMPNO, ENAME, COMM
FROM EMP
WHERE DEPTNO = 30;

--�並 ���� �� �� �� �ִ� ������ �Ϲ� �������Դ� ����. ������(DBA)�� �㰡�������.

DESC EMPVW30

SELECT * FROM EMPVW30;

--���� ���� VIEW ������ Ȯ�� : ������ ��ųʸ����� Ȯ��
DESC USER_VIEW

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;
--: ���� ���� ������ ���̺��� ���� ���� �׸�ŭ�� ���� �뷮�� �� �����ϹǷ� VIEW�� ���ϸ� �ξ� ���� �뷮(TEXT)���� �����ϰ� �ȴ�.

--VIEW ���� : ALTER(X) => CREATE OR REPLACE �������� ����
CREATE OR REPLACE VIEW EMPVW30
AS
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM COPY_EMP
WHERE DEPTNO = 30;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

SELECT * FROM EMPVW30;

--VIEW ��ü�� ���̺� ��üó�� ��� ���� (DML�� �����ؾ� ��)
INSERT INTO EMPVW30
VALUES (111, 'HONG', 1000, 30);

--DML���� �������� ���� ��� => COMPLEX VIE(���պ�) - JOIN, GROUP BY, GROUP FUNCTION�� ���� VIEW
CREATE VIEW EMP_DEPT_SAL
AS
SELECT E.ENAME, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE (E.DEPTNO = D.DEPTNO) AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- ���� : �޿��� ���� ������� 3���� ����� ���, �̸�, �޿��� ���Ͻÿ�.
SELECT * FROM EMP;

SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

SELECT ROWID, ROWNUM, EMPNO
FROM EMP;

SELECT ROWID, ROWNUM, EMPNO
FROM EMP
ORDER BY SAL DESC;

CREATE VIEW E3 
AS 
SELECT EMPNO, ENAME, SAL
FROM EMP
ORDER BY SAL DESC;

SELECT * FROM E3;

SELECT ROWNUM, EMPNO, ENAME, SAL
FROM E3
WHERE ROWNUM = 3;

--�並 ���� DML �۾� �ź� : WITH READ ONLY
CREATE OR REPLACE VIEW EMPVW20
ASSELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO = 20
WITH READ ONLY;

INSERT INTO EMPVW20
VALUES (2222, 'HONG2', 0 , 20);

--�� ����
--: DROP VIEW ����
--: �並 �����ص� ���� ����� �Ǵ� ���̺��� ������ ��ġ�� �ʴ´�.
--=> ������ �並 ������� �ϴ� �ٸ� �䳪 ��Ÿ ���� ���α׷��� ����� �� ���� �ȴ�. 
--: �����ڳ� DROP ANY VIEW������ ���� ������ �並 ������ �� ����.

DROP VIEW EMPVW30;

--+�ε���(Index) ��ü 
--: �����͸� ����Ͽ� �� �˻� �ӵ��� ���� �� �ִ� ��ü
--: ����� �Ǵ� �ڵ����� �ε����� ������ �� ����
--: ���� �ε����� ������ ��ü ���̺��� ��ĵ�ǹǷ� �ε����� �־�� ���̺��� �࿡ ���� ������ �������� �� �ִ�.
--=> ��ũ I/O�� ���̴µ� �� ������ �ִ�.
--: �ε����� ����Ŭ ����(DBMS)�� �ڵ����� ����ϰ� ����, �����Ѵ�. 
--: �ε����� ����, ���������� �ε����� ����� �Ǵ� ���̺� ��������.
--=> �ε����� ������ ����, ������ �� ������ �⺻ ���̺��̳� �ٸ� �ε����� ������ ��ġ�� ����
--=> ���̺��� �����ϸ� �ش� �ε��� ���� ���� �ʿ� ����

--+ �ε��� ���� ���
--1) AUTO: PK(Primary Key), UK(Unique)
--2) ���� : �� where ���������� ���� ���
--         �� join condition���� ���� ���

--�ε��� ���� : ������ ��ųʸ�
DESC USER_INDEXES

SELECT INDEX_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES;

--�ε��� ���� 
SET TIMING ON

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE ENAME = 'KING';

CREATE INDEX IDX_EMP_ENAME
ON EMP(ENAME);

SELECT * 
FROM USER_IND_COLUMNS;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE ENAME = 'JONES';

SET TIMING OFF

--�ε��� ���� : ���� �� �ٽ� �����ؾ���.
DROP INDEX IDX_EMP_ENAME;

--+ ������ (SEQUENCE) : ������ �ڵ���ȣ������
--: ���� ���� �뵵 - ���ø����̼ǿ��� PK������ �ߺ����� ���� ������ �ֱ� ���ؼ� ���� ���

--������ ����
CREATE SEQUENCE CDEPT_DEPTNO_SEQ
START WITH 1        --��𿡼� �������� ���ϴ� �� 
INCREMENT BY 1
MINVALUE 1          --�ּڰ� �����ִ� ��
MAXVALUE 100        --�ִ� ������ ���ڳ� �����ִ� ��
NOCACHE            
NOCYCLE;            --���ڰ� �����ϴ� �����̸� �������

SELECT * FROM CDEPT;

DELETE FROM CDEPT
WHERE DEPTNO = 1;

INSERT INTO CDEPT 
VALUES (CDEPT_DEPTNO_SEQ.NEXTVAL, 'AA', 'BB'); -- NEXTVAL �ڵ����� ���� ����

SELECT * FROM CDEPT;

DELETE FROM DEPT --������ 5������ �� , ���߿� ����¡ ó���Ҷ� �ʿ���
WHERE DEPTNO = 3;

--������ ���� : ������ ��ųʸ�
DESC USER_SEQUENCES

SELECT * FROM USER_SEQUENCES;

--������ ���� 
DROP SEQUENCE CDEPT_DEPTNO_SEQ;

--+ ���Ǿ� (Synonym)
--: ��ü�� �ٸ� �̸�(��Ī) �ο��Ͽ� ��ü�� ���� �������� �뵵
--: �ٸ� ������ ������ ���̺��� ���� ������ �� ����
--: �� ��ü �̸��� ª�� ���� ����� �� ����.
-- ���� : ���� ������ �ʿ���

CREATE SYNONYM EX1
FOR DEPT;

SELECT * FROM EX1;
SELECT * FROM DEPT;

----���� �ֱ� (���������Ʈ)
--sqlplus sys/6789 as sysdba : ������ �������� �α���
--GRANT CREATE SYNONYM TO scott; : �����ֱ�

--���Ǿ� ����
DROP SYNONYM EX1;