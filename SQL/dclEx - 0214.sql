--+DCL (Data Control Language)
--
--+����Ŭ DB �����
--1) SYS : ������
--2) SYSTEM : DBA
--3) SCOTT : END-USER (���� �����) => ���� ������ ���� �����
--
--+ ���� 
--1) SYSTEM : �ý��ۿ� ������ ��ġ�� ���� 
--            GRANT ���� TO ����ڸ�;
--            REVOKE ���� FROM ����ڸ�;
--            : SYS�� ������ ������ ����.
--
--2) OBJECT : �ش� OBJECT���� ������ ��ġ�� ����
--            GRANT ���� ON OBJECT�� TO ����ڸ�;
--            REVOKE ���� ON OBJECT�� FROM ����ڸ�;
--            : �ش� OBJECT �����ڰ� ������ ����.

--==================================================
-- ���������Ʈ
SHOW USER

-- USER1 ���� (���ڱ� ���������ż� ����)
CREATE USER USER1
IDENTIFIED BY TIGER;

GRANT CONNECT, RESOURCE TO USER1;

-- SELECT ������ Ư�� ��ü�� ��ȸ�� �� ������ ���� ����ڿ��Դ� �������� �࿩���� �ʵ��� ó��
-- ���ȼ��� ����
GRANT SELECT ON EMP TO USER1;


-- ���� ȸ��
REVOKE SELECT, UPDATE ON COPY_EMP FROM USER1; 

--��������
CONN SYS/6789 AS SYSDBA

--���� ����
DROP USER USER1;

--PW ����
ALTER USER USER1
IDENTIFIED BY LION;

--��� ���� �䱸
CREATE USER USER2
IDENTIFIED BY TIGER
PASSWORD EXPIRE
ACCOUNT UNLOCK;

--[�ǽ�] ������ ����� ������ ������ �ȵǰ� �ϰ� ���� �� (�α׸� ����)
--USER2�� �α����� �ȵǵ��� �غ�����
ALTER USER USER2
ACCOUNT LOCK;
