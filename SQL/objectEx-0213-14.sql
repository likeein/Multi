--+ View(뷰) 객체
--
-- : 테이블 또는 다른 뷰를 기반으로 하는 논리적인 테이블.
-- : 자체적으로 데이터를 갖고 있지는 않지만 테이블의 데이터를 보거나 변경할 수 있는 window 역할을 하는 객체.
-- : 뷰의 기반이 되는 테이블을 기본 테이블이라고 부른다. 
-- : 뷰는 데이터 딕셔너리에 select문으로 저장됨.
-- : 사용 목적 1) 보안 목적  2) 엑세스의 단순함

--1. 뷰 생성
CREATE VIEW EMPVW30
AS
SELECT EMPNO, ENAME, COMM
FROM EMP
WHERE DEPTNO = 30;

--뷰를 생성 및 볼 수 있는 권한은 일반 계정에게는 없음. 관리자(DBA)가 허가해줘야함.

DESC EMPVW30

SELECT * FROM EMPVW30;

--내가 만든 VIEW 정보를 확인 : 데이터 딕셔너리에서 확인
DESC USER_VIEW

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;
--: 보고 싶은 정보를 테이블을 새로 만들어서 그만큼의 저장 용량을 더 차지하므로 VIEW를 통하면 훨씬 적은 용량(TEXT)으로 동작하게 된다.

--VIEW 수정 : ALTER(X) => CREATE OR REPLACE 구문으로 수정
CREATE OR REPLACE VIEW EMPVW30
AS
SELECT EMPNO, ENAME, COMM, DEPTNO
FROM COPY_EMP
WHERE DEPTNO = 30;

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;

SELECT * FROM EMPVW30;

--VIEW 객체를 테이블 객체처럼 사용 가능 (DML이 가능해야 함)
INSERT INTO EMPVW30
VALUES (111, 'HONG', 1000, 30);

--DML문이 가능하지 않은 경우 => COMPLEX VIE(복합뷰) - JOIN, GROUP BY, GROUP FUNCTION이 사용된 VIEW
CREATE VIEW EMP_DEPT_SAL
AS
SELECT E.ENAME, D.DNAME, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE (E.DEPTNO = D.DEPTNO) AND E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- 문제 : 급여가 많은 순서대로 3명의 사원의 사번, 이름, 급여를 구하시오.
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

--뷰를 통한 DML 작업 거부 : WITH READ ONLY
CREATE OR REPLACE VIEW EMPVW20
ASSELECT EMPNO, ENAME, COMM, DEPTNO
FROM EMP
WHERE DEPTNO = 20
WITH READ ONLY;

INSERT INTO EMPVW20
VALUES (2222, 'HONG2', 0 , 20);

--뷰 제거
--: DROP VIEW 구문
--: 뷰를 제거해도 뷰의 기반이 되는 테이블에는 영향을 미치지 않는다.
--=> 삭제된 뷰를 기반으로 하는 다른 뷰나 기타 응용 프로그램은 사용할 수 없게 된다. 
--: 생성자나 DROP ANY VIEW권한을 가진 유저만 뷰를 제거할 수 있음.

DROP VIEW EMPVW30;

--+인덱스(Index) 객체 
--: 포인터를 사용하여 행 검색 속도를 높일 수 있는 객체
--: 명시적 또는 자동으로 인덱스를 생성할 수 있음
--: 열에 인덱스가 없으면 전체 테이블이 스캔되므로 인덱스가 있어야 테이블의 행에 직접 빠르게 엑세스할 수 있다.
--=> 디스크 I/O를 줄이는데 그 목적이 있다.
--: 인덱스는 오라클 서버(DBMS)가 자동으로 사용하고 유지, 관리한다. 
--: 인덱스는 논리적, 물리적으로 인덱스의 대상이 되는 테이블에 독립적임.
--=> 인덱스는 언제든 생성, 삭제할 수 있으면 기본 테이블이나 다른 인덱스에 영향을 미치지 않음
--=> 테이블을 삭제하면 해당 인덱스 또한 삭제 됨에 유의

--+ 인덱스 생성 방법
--1) AUTO: PK(Primary Key), UK(Unique)
--2) 수동 : ① where 조건절에서 자주 사용
--         ② join condition에서 자주 사용

--인덱스 정보 : 데이터 딕셔너리
DESC USER_INDEXES

SELECT INDEX_NAME, INDEX_TYPE, UNIQUENESS
FROM USER_INDEXES;

--인덱스 생성 
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

--인덱스 변경 : 삭제 후 다시 생성해야함.
DROP INDEX IDX_EMP_ENAME;

--+ 시퀀스 (SEQUENCE) : 일종의 자동번호생성기
--: 많이 쓰는 용도 - 어플리케이션에서 PK값으로 중복되지 않은 값들을 주기 위해서 많이 사용

--시퀀스 생성
CREATE SEQUENCE CDEPT_DEPTNO_SEQ
START WITH 1        --어디에서 시작할지 정하는 것 
INCREMENT BY 1
MINVALUE 1          --최솟값 정해주는 것
MAXVALUE 100        --최대 어디까지 가겠나 정해주는 것
NOCACHE            
NOCYCLE;            --숫자가 증가하는 형태이면 써줘야함

SELECT * FROM CDEPT;

DELETE FROM CDEPT
WHERE DEPTNO = 1;

INSERT INTO CDEPT 
VALUES (CDEPT_DEPTNO_SEQ.NEXTVAL, 'AA', 'BB'); -- NEXTVAL 자동으로 숫자 증가

SELECT * FROM CDEPT;

DELETE FROM DEPT --지워도 5번으로 들어감 , 나중에 페이징 처리할때 필요함
WHERE DEPTNO = 3;

--시퀀스 정보 : 데이터 딕셔너리
DESC USER_SEQUENCES

SELECT * FROM USER_SEQUENCES;

--시퀀스 삭제 
DROP SEQUENCE CDEPT_DEPTNO_SEQ;

--+ 동의어 (Synonym)
--: 객체에 다른 이름(별칭) 부여하여 객체에 쉽게 엑세스할 용도
--: 다른 유저가 소유한 테이블을 쉽게 참조할 수 있음
--: 긴 객체 이름을 짧게 만들어서 사용할 수 있음.
-- 참고 : 생성 권한이 필요함

CREATE SYNONYM EX1
FOR DEPT;

SELECT * FROM EX1;
SELECT * FROM DEPT;

----권한 주기 (명령프롬프트)
--sqlplus sys/6789 as sysdba : 관리자 계정으로 로그인
--GRANT CREATE SYNONYM TO scott; : 권한주기

--동의어 삭제
DROP SYNONYM EX1;