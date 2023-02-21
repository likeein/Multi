--서브쿼리의 종류

--1. 서브 쿼리의 실행 결과의 형태
--    1) 단일 행 서브쿼리
--    2) 다중 행 서브쿼리 
--    3) 다중 열 서브쿼리
    
--2. 서브쿼리의 동작 방식
--    1) 일반 서브쿼리
--    2) 상관 관계의 서브쿼리

--===========================================================================================
--    문제 1. emp테이블에서 월급을 가장 많이 받는 사원의 이름, 업무, 급여, 입사일을 출력하는 쿼리를 작성하세요.
        SELECT ENAME, JOB, SAL, HIREDATE
        FROM EMP
        WHERE SAL = (SELECT MAX(SAL)
                    FROM EMP);
                
--    문제 2. EMP 테이블에서 SCOTT 사원과 동일한 급여를 받는 모든 사원의 이름, 업무, 급여, 부서번호를 출력하는 쿼리를 작성하세요.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL = (SELECT SAL             --<- = 이거 말고 하나 이상 반환한다면 IN으로 
                    FROM EMP
                    WHERE ENAME = 'SCOTT');
                  
--    문제1. EMP 테이블에서 관리자 사원 번호, 이름, 업무, 입사일, 급여, 부서번호 정보를 출력하는 쿼리를 작성하세요.
        SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO 
        FROM EMP 
        WHERE EMPNO IN (SELECT MGR
                        FROM EMP);

-- ANY -> OR 개념, 독립적으로 사용 안됨
--    문제2. EMP테이블에서 30번 부서에 속한 어떤 사원보다 더 많은 급여를 받는 사원들의 이름, 업무, 급여, 부서번호를 출력하는 쿼리를 작성하세요.
--        단, 30번 부서의 사원은 제외합니다.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL > ANY (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
            AND DEPTNO != 30;
            
-- ALL -> AND 개념, 독립적으로 사용 안됨
--    문제3. EMP테이블에서 30번 부서에 속한 모든 사원보다 더 많은 급여를 받는 사원들의 이름, 업무, 급여, 부서번호를 출력하는 쿼리를 작성하세요.
--        단, 30번 부서의 사원은 제외합니다.
        SELECT ENAME, JOB, SAL, DEPTNO
        FROM EMP
        WHERE SAL > ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30)
            AND DEPTNO != 30;
            
--EXISTS
--EMP 테이블에서 관리자 사원 번호, 이름, 업무, 입사일, 급여, 부서번호 정보를 출력하는 쿼리를 작성하세요.
        SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, DEPTNO 
        FROM EMP E
        WHERE EXISTS (SELECT *
                        FROM EMP
                        WHERE MGR = E.EMPNO);

--EMP 테이블에서 SCOTT 사원과 동일한 급여를 받는 모든 사원의 이름, 업무, 급여, 부서번호를 출력하는 쿼리를 작성하세요.
SELECT *
FROM EMP
WHERE (SAL, NVL(COMM, -1)) IN (SELECT SAL, NVL(COMM, -1)
                                FROM EMP
                                WHERE ENAME = 'SCOTT');
                        
-- 뷰 생성
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

--WITH -> 쿼리 복잡성을 간편하고 작성 용이하게 해줌
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
--EMP 테이블에서 각 년도별 입사한 사원의 수를 출력하는 쿼리를 작성하세요.
--단, 서브쿼리를 이용하여 문제를 해결합니다.
SELECT (SELECT COUNT(*) FROM EMP) TOTAL,
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1980') "1980",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1981') "1981",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1982') "1982",
    (SELECT COUNT(*) FROM EMP WHERE TO_CHAR(HIREDATE, 'YYYY') = '1983') "1983"
FROM DUAL;

--각 사원의 이름, 업무, 입사일,부서 번호 ,부서명, 근무 위치를 출력하는 쿼리를 작성하세요.
--단 조인은 사용하지 않습니다. 
SELECT ENMAE, JOB, HIREDATE, DEPTNO, (SELECT DANME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAMEI   
FROM EMP E;

--===========================================================================================
INSERT INTO (SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP)
VALUES (9999, 'LONG', 'CLERK', 700, 40);

CREATE TABLE EMP_ORDER
AS
SELECT * FROM EMP
WHERE 1=2;          --구조만 가지고 오고 데이터를 가지고 오는게 아님

SELECT * FROM EMP_ORDER;

INSERT INTO EMP_PRDER
SELECT * FROM EMP ORDER BY HIREDATE;
--===========================================================================================
--NEW YORK에 근무하는 모든 사원의 관리자 번호를 SCOTT 사원의 관리자 번호와 동일하도록 변경하는 코드를 작성하세요.
SELECT * FROM DEPT WHERE LOC = 'NEW YORK';
SELECT ENAME, MGR FROM EMP WHERE ENAME = 'SCOTT';

UPDATE EMP
SET MGR = (SELECT MGR FROM EMP WHERE ENAME = 'SCOTT')
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'NEW YORK');

DELETE FROM EMP
WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS');
--=========================================================================================
- 문제] 아래의 테이블 구조와 제약조건을 가지는 dept2, emp2 테이블을 생성하는 쿼리를 작성하세요.
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