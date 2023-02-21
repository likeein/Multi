--[ DML (Data Manipulation Language] : 데이터 조작어
-- : 테이블에서 새 행을 추가
-- : 테이블에서 기존 행을 수정
-- : 테이블에서 기존 행을 삭제
--: 테이블 내부 단위

--INSERT 구문 (행 삽입)
--1) 새 행 삽입
--INSERT INTO 테이블명 VALUES (삽입할 데이터);
DESC DEPT  --> F9 클릭

INSERT INTO DEPT
VALUES (50, 'A', 'B');  --> 1인서트 구문에 1행 추가. 추가 및 제거 모두 1행씩만

SELECT * FROM DEPT;  --> 추가된 1행 확인 가능

-- 2) NULL 값을 가진 행을 삽입 (권장 X)
--암시적 : 열 리스트에서 열을 생략
INSERT INTO DEPT (DEPTNO, DNAME)
VALUES (60, 'C');

SELECT * FROM DEPT;

--명시적 : VALUES 절에서 NULL 키워드 지정
INSERT INTO DEPT
VALUES (70, 'D', NULL);

SELECT * FROM DEPT;

--3) 특수값 삽입 : 함수 사용 가능
INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9090, SYSDATE);

SELECT * FROM EMP WHERE EMPNO = 9090;  -- 절대 권장하지 않음 

-- cf)
SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--SYSDATE : 시스템에서의 현재 시간을 반환
--CURRENT_DATE : 현재 세션에서의 현재 시간을 반환

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL; 

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';

ALTER SESSION SET TIME_ZONE = '-5:0';

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL; 

SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--4) 특정 날짜 및 시간 삽입 : 변환 함수 사용
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9092, SYSDATE);

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9093, TO_DATE(SYSDATE, 'DD-MON-RR'));

SELECT * FROM EMP;

-- 세션 정리
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

SELECT * FROM EMP;

DELETE FROM EMP WHERE EMPNO IN (9090, 9091, 9092, 9093);

--5) 스크립트 작성
-- : SQL문에 &치환을 사용하여 값을 입력하도록 요구
-- : &치환 - &변수값에 대한 위치 표시자 
SELECT * FROM DEPT;

INSERT INTO DEPT (DEPTNO, DNAME, LOC)   --회사에서 6개월 지나면 비번 바꾸라고 하는 기능이랑 비슷함.
VALUES (&DEPTNO, '&DNAME', '&LOC');

SELECT * FROM DEPT;

-- 6) 다른 테이블에서 행 복사해서 삽입
-- 서브 쿼리를 사용하여 한 번에 여러 데이터 추가하기 (동시에 한번에 넣을 순 없음)
SELECT * FROM SALGRADE;

INSERT INTO DEPT (DEPTNO)  -- 서브쿼리처럼 쓰기 (VALUES대신 SELECT 넣기)
SELECT GRADE FROM SALGRADE
WHERE GRADE = 1;

SELECT * FROM DEPT;

--UPDATE 구문 (데이터 변경)
--1) 테이블 행 갱신
-- - WHERE 절 無 : 모든 행 갱신
-- - WHERE 절 有 : 특정 행 갱신

SELECT * FROM DEPT;

UPDATE DEPT
SET DNAME = 'G'
WHERE DEPTNO = 60;

SELECT * FROM DEPT;

--2) 서브쿼리를 사용하여 여러 열 갱신 가능
-- : SET 절에 서브쿼리를 여러 개 사용하여 동시에 여러 컬럼값을 변경 가능
-- : 동시에 여러 레코드를 갱신하는 것은 아님에 유의!

CREATE TABLE CEMP
AS
SELECT * FROM EMP;

SELECT * FROM CEMP;

-- 7900 사원의 직책과 급여를 동시에 갱신 <- 7521 사원의 직책과 급여로 갱신
UPDATE CEMP
SET JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO = 7521),
    SAL = (SELECT SAL
           FROM CEMP
           WHERE EMPNO = 7521)
WHERE EMPNO = 7900;

SELECT * FROM CEMP;

--문제 : CEMP 테이블에서 사번이 7499인 사원과 동일한 직책을 가진 사원들의 SAL값을
--      7902 사원의 SAL 값으로 변경하세요.

UPDATE CEMP
SET SAL = (SELECT SAL
            FROM CEMP
            WHERE EMPNO = 7902)
WHERE JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO = 7499);


SELECT * FROM CEMP;

--3) 다른 테이블을 기반으로 행 갱신 : 서브쿼리 이용
CREATE TABLE COPY_EMP
AS
SELECT * FROM EMP;

--EMP 테이블 기반으로 하여 사원 번호가 7934인 사원의 직책과 동일한 사원의 부서 번호를 
--현재 7902 사원의 부서번호로 모두 변경한다.
UPDATE COPY_EMP
SET DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE EMPNO = 7902)
WHERE JOB = (SELECT JOB
            FROM EMP
            WHERE EMPNO = 7934);
            
--문제 : EMP 테이블을 기반으로 사원번호가 7934인 사원의 매니저와 동일한 부서번호를 가지고 있는
--      모든 사원의 부서번호를 현재 (COPY_EMP) 7902 사원의 부서번호로 모두 변경하세요.
UPDATE COPY_EMP
SET DEPYNO = (SELECT DEPTNO
                FROM COPY_EMP
                WHERE EMPNO = 7902)
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE EMPNO = (SELECT MGR
                                FROM EMP
                                WHERE EMPNO = 7934));

-- DELETE 구문 : 행 제거
-- 1) 테이블에서 행 제거
-- - WHERE절 없으면 : 테이블 모든 행 삭제
-- - WHERE절 있으면 : 특정 행 삭제
-- DELETE FROM 테이블 WHERE 절
DELETE FROM DEPT
WHERE DEPTNO = 50; -- DELETE는 FROM 생략 가능 

-- DELETE 구문은 예외적으로 FROM KEYWORD 생략 가능
DELETE DEPT
WHERE DEPTNO IN(60,70);

CREATE TABLE CDEPT
AS
SELECT * FROM DEPT;

--2) 다른 테이블을 기반으로 행 삭제 가능
DELETE COPY_EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE DNAME = 'RESEARCH');

SELECT * FROM COPY_EMP; 
                
--ROLLBACK;
--cf) TRUNCATE 구문 (DDL 구문)
-- : 테이블 구조는 모두 남겨놓은채 모든 행 제거
-- : 단! 롤백이 안되므로 조심할 것
-- 문법 - TRUNCATE TABLE 테이블명;
