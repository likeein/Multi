--[ DDL �ǽ�]

--�׸�1)
--SQL> desc cust
--Name                                      Null?    Type
------------------------------------------   -------
--CUST_ID                                           NUMBER(6)
--CUST_GENDER                                        NUMBER
--CUST_NAME                                          VARCHAR2(10)
--1.      �׸�1ó�� TABLE�� ���� �ϴ� SQL���� �ۼ��Ͻÿ�.
CREATE TABLE CUST
(CUST_ID NUMBER(6),
CUST_GENDER NUMBER,
CUST_NAME VARCHAR2(10));

DESC CUST;

--�׸�2)
--SQL> select * from cust;
--CUST_ID   CUST_GENDER    CUST_NAME
---------     -------------     -----------
--         1           1        ȫ�浿
--         2           0        �̼���
--         3           1
--         4           0        ����
--         5           1        �Ż��Ӵ�
--2.      �׸�2ó�� �����͸� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�.
INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (1, 1, 'ȫ�浿');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (2, 0, '�̼���');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (3, 1, '');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (4, 0, '����');

INSERT INTO CUST (CUST_ID, CUST_GENDER, CUST_NAME)
VALUES (5, 1, '�Ż���');

SELECT * FROM CUST;

--3. CUST ���̺� CUST_GRADE �÷��� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�
--(�� GRADE �� ����2�ڸ�)
ALTER TABLE CUST
ADD CUST_GRADE NUMBER(2); 

DESC CUST;

--4. CUST_GRADE �÷��� TYPE�� ���� 4�ڸ��� ���� ��Ű�� SQL���� �ۼ��Ͻÿ�
ALTER TABLE CUST
MODIFY CUST_GRADE NUMBER(4);

DESC CUST;

--5. CUST ���̺��� �����Ͽ� CUSTOMER ���̺��� ����
CREATE TABLE CUSTOMER
AS
SELECT * FROM CUST;

DESC CUSTOMER;

--6. CUST ���̺�  �����̺� �̶�� �ּ��� �ް�   �ùٸ���  �߰��Ǿ����� ������ ��ųʸ��� ��ȸ�ϼ���
COMMENT ON TABLE CUST
IS '�����̺�';

DESC USER_TAB_COMMENTS

SELECT * FROM USER_TAB_COMMENTS;

--7. CUST ���̺��� ��� �����͸� ���� �ϴ� 2���� ����� ����� ���� ���� �������� ���� ����Ͻÿ�
DROP TABLE CUST; -- ���̺� ��ü�� �����ϴ� ��ɾ�
DROP TABLE CUST PURGE; --�������� ��ġ�� �ʰ� ���̺��� �ٷ� �����ϴ� ��ɾ�

--8. CUST ���̺��� ����
DROP TABLE CUST;

--9. �����뿡�� ������ ���̺��� ������ ã���� �ִ�.
SHOW RECYCLEBIN

--10. �����ϱ� ������ �ǵ������� �Ѵ�. ��� �ؾ� �ϳ�?
ROLLBACK;

SELECT * FROM CUST;
