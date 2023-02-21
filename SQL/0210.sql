--[서브쿼리]
--: 일종의 select문 고급 기능
--: select 문을 조건절에 넣어줄 수 있음 - 조건절에 들어가는 select문을 서브쿼리라고 함
--: 최종적으로 인출하려는 값을 표기하는 부분 - 메인쿼리
--
--서브퉈리 인출값이 하나이면 단일행 서브쿼리
--                여러개이면 다중행 서브쿼리
--
--* 주의사항
--1) 서브쿼리는 반드시 괄호 안에 쓰기

SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

--2) 단일행 서브쿼리 앞에는 비교연산자(SINGLE ROW OPERATOR)가 와야 한다.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JOBES' OR COMM IS NOT NULL);
            

--3) 다중행 서브쿼리 앞에는 MULTIPLE ROW OPERATOR ( IN, ANY, ALL)가 와야 한다.
--IN 연산자: 여러 값 중 하나와 같다.
--e.g. [10번 부서 사원들의 급여와 같은 급여]를 받는 [사원의 이름과 급여 조회]
-- 1번째 조건의 결과가 3줄이 나옴 => 다중행쿼리
SELECT *
FROM EMP
WHERE DEPTNO = 10;

SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL
              FROM EMP
              WHERE DEPTNO = 10);
--문제 : 부서 번호가 10, 20, 30번인 직원들의 부서 번호별 평균 급여 중 하나와 같은 급여를 받는 사원의 사번, 이름, 급여 정보를 조회하세요.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL)) 
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--문제 : 부서 번호별로 가장 많은 급여를 받는 사원의 정보를 출력하세요 - 5분
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
                FROM EMP
                GROUP BY DEPTNO);
                
--문제 : 다른 직원의 상관으로 근무하고 있는 직원의 사번, 이름, 급여를 조회하세요.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR 
                FROM EMP);
                
-- 반대로 다른 직원의 상관이 아닌 (부하직원이 없는) 직원들의 사번, 이름 , 급여를 조회하세요
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR 
                    FROM EMP
                    WHERE MGR IS NOT NULL);
                    
--ANY 연산자: 여러 값 중 하나. 비교 연산자가 앞에 나와야 함.
--           값 하나를 리스트의 값 또는 쿼리에서 반환되는 값과 비교
--SALESMAN 직책의 급여보다 많이 받는 사원의 사원명과 급여를 조회
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL
                    FROM EMP
                    WHERE JOB ='SALESMAN');
                    
--문제 : 부서 번호가 10, 20, 30번인 직원들의 부서 번호별 평균 급여 중 하나보다 작거나 같은 급여를 받는 직원의 급여, 이름, 사번을 조회하세요.
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= ANY (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--같은 결과
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= (SELECT MAX(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
-- ALL 연산자 : 모든 값
--            : 비교연산자가 앞에 위치
-- 모든 SALESMAN의 급여보다 많이 받는 사원의 사원 명과 급여 정보를 조회
SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL --> ANY는 모든것과 비교, ALL은 전부다?? 이거 복습하기
                FROM EMP
                WHERE JOB = 'SALESMAN');
                
--문제 : 부서 번호가 10, 20, 30번인 직원들의 부서 번호별 평균 급여 모두보다 작은 급여를 받는 직원의 급여, 이름, 사번을 조회하세요.
--1. 다중 행 서브쿼리
SELECT ENAME, EMPNO, SAL
FROM EMP
WHERE SAL < ALL (SELECT AVG(SAL) 
                    FROM EMP
                    WHERE DEPTNO IN (10, 20, 30)
                    GROUP BY DEPTNO);

--2. 단일 행 서브쿼리
SELECT ENAME, EMPNO, SAL
FROM EMP
WHERE SAL < (SELECT MIN(AVG(SAL))
                    FROM EMP
                    WHERE DEPTNO IN (10, 20, 30)
                    GROUP BY DEPTNO);

-- 4) 단일행 서브쿼리 집합함수 사용 가능
-- EMP 테이블에서 부서별 평균급여가 가장 큰 부서번호와 그 평균급여를 구하시오

SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);


-- EMP 테이블에서 [직책별 평균 급여가 가장 작은 직책]과 그 평균 급여를 구하시오
SELECT MIN(AVG(SAL))
FROM EMP
GROUP BY JOB;

SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                    FROM EMP
                    GROUP BY JOB);
                    
-- 5) 서브쿼리가 메인쿼리로 반환되는 행이 없으면 '선택된 행이 없음'라는 메세지가 표시됨
--    중요/주의) 문제는 행이 있지만 해당 컬럼이 NULL인 경우도 위와 같은 메세지 표시됨 (있는데 없다고 NULL이라고 나옴)
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
            FROM EMP
            WHERE EMPNO = 9999);

-- 만족하는 행이 있지만 NULL 상태인 경우는 추후 문제가 발생할 수 있으므로 문제점을 해결해야 함
-- 해결방법 ( 가장 권장하는 방법, 가장 BEST는 ①번!)
-- ① NULL 상태로 두지 않고 대체값으로 채우기 - 데이터 특성을 보고 데이터 특성에 맞게
--        충분한 논의를 거친 뒤, 값에 영향을 주지 않는 값으로 채우기 
--        문자 데이터 유형이라면 '-' 값, 숫자 데이터 유형이라면 0값, 통계적으로 인정되는 값(평균값, 중앙값, 최빈값)
--        대체값을 미리 입력해 두었으니, 최종 결과가 표시될 수 있음

-- ② NULL 처리 함수 (원본을 건들 수 없는 상황일 때) 
--    NVL, IS NOT NUL 등 사용
--    데이터의 양이나 인덱스 키 값 구성방법에 따라 데이터베이스에 부하를 줄 수 있음을 유의

-- 6) EXISTS 연산자: 테이블에 특정 행이 있는지 여부에 따라 쿼리 결과가 달라지는 질의에 사용
--                : 서브쿼리 데이터가 존재하는가를 체크해 존재 여부 (True/False)를 결과로 반환
--                : 서브쿼리 결과행을 찾으면 inner query 수행을 중단하고 True를 반환

-- 연습문제: 부서원이 없는 부서 정보 조회

-- ① 부서원이 있는 테이블 정보
SELECT *
FROM EMP
WHERE EMP.DEPTNO = DEPT.DEPTNO; 

-- ② ①의 정보가 없는 정보 조회
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT *
                  FROM EMP
                  WHERE EMP.DEPTNO = DEPT.DEPTNO);
                     
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;

--> 사원테이블을 통해 사원들이 속한 부서번호의 정보 조회
-----> 추출하고자 하는 정보의 대상 테이블은 DEPT이지만, EMP 테이블과 조인하여 부서번호를 체크
-----> 두 테이블의 관계는 1:N 관계. 그러므로 불필요하게 EMP 테이블을 모두 읽어야만 하는 상태임
-----> 최종적으로는 중복제거를 해서 올바른 결과를 얻어내고 있는 구조.

SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1
            FROM EMP E
            WHERE E.DEPTNO = D.DEPTNO);
--> 속도 빠름.. 왜..?? 내부에서 TRUE FALSE만 정해서 내보내서?
-- EXISTS 연산자를 사용한 질의문: 추출하고자 하는 대상만을 FROM 절에 놓고 
-- EMP 테이블은 체크만 하기 위해 EXISTS 절에 위치시킴 => 전체 수행 속도 대폭 상승


-- 7) 서브쿼리문에는 ORDER BY 절을 지원하지 않는다. (정렬 X)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES')
--             ORDER BY 1 DESC); --> ORDER BY 지원 안 하므로 에러 발생. 불필요함
ORDER BY SAL;    --> 정렬은 서브쿼리 끝난 뒤에 진행                
                    
--[복합쿼리]
--: 집합 연산자가 포함된 쿼리
--: 집합 연산자? 둘 이상의 구성요소 쿼리 결과를 하나의 결과로 조합
--: 종류 - UNION, UNION ALL, INTERSECT, MINUS (SET OPERATOR) (집합)
--: 집합 연산자는 모두 우선순위가 같다.
--: 명시적으로 최우선 연산자 괄호()로 순서를 지정하지 않는 한 왼쪽에서 오른쪽, 위에서 아래로 연산자를 평가함
--: 다른 집합 연산자와 함께 MINUS가 사용된 쿼리문이라면 집합의 배치에 주의

--* 집합연산자 지침
--: SELECT 절의 리스트의 표현식은 갯수가 일치해야 한다.
--: 두번째 쿼리에 있는 각 열의 데이터 유형은 첫번째 쿼리에 있는 (혹은 상응하는) 열의 데이터 유형과 일치해야 함
--: 실행순서를 변경하려면 괄호를 사용한다.
--: 최종결과를 정렬하려면 ORDER BY 절을 명령문의 맨 끝에 사용한다.

--UNION: 합집합
--     : 두 테이블의 결합. 결합시키는 두 테이블의 중복되지 않은 값을 반환
-- 연습문제: 부서번호 조회
SELECT DEPTNO
FROM EMP
UNION
SELECT DEPTNO DEPT;                    

--[ DML (Data Manipulation Language ] : 데이터 조작어
--: 테이블에서 새 행 추가
--: 테이블에서 기존 행을 수정
--: 테이블에서 기존 행을 삭제
--: 테이블 내부 단위

--INSERT 구문 (행 삽입)
--1) 새 행 삽입
--INSERT INTO 테이블명
--VALUES (삽입할 데이터);
DESC DEPT --> F9 클릭
--이름     널? 유형
-------- -- ------------
--DEPTNO    NUMBER(2)     --> 숫자, 2자리 넣을 수 있음
--DNAME     VARCHAR2(14)  --> 문자, 14자리 넣을 수 있음
--LOC       VARCHAR2(13)  --> 문자, 13자리 넣을 수 있음
INSERT INTO DEPT
VALUES (50, 'A', 'B');      --> 1인서트 구문에 1행 추가. 추가 및 제거 모두 1행씩만
SELECT * FROM DEPT;         --> 추가된 1행 확인 가능

--2) NULL 값을 가진 행 삽입 (권장 X)
--암시적: 열 리스트에서 열 생략
INSERT INTO DEPT (DEPTNO, DNAME)
VALUES (60, 'C');
SELECT * FROM DEPT;
--명시적: VALUE 절에서 NULL 키워드 지정
INSERT INTO DEPT
VALUES (70, 'D', NULL);
SELECT * FROM DEPT;
                    
-- 3) 특수 값 삽입 : 함수 사용 가능
INSERT INTO EMP (EMPNO, HIREDATE)
VALUES (9090, SYSDATE);

SELECT * FROM EMP WHERE EMPNO = 9090; -- 절대 권장하지 않음 

--CF)
SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--SYSDATE : 시스템에서의 현재 시간을 반환
--CURRENT_DATE : 현재 세션에서의 현재 시간을 반환

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY HH24:MI:SS';

ALTER SESSION SET TIME_ZONE = '-5:0';

SELECT SYSDATE FROM DUAL
UNION ALL
SELECT CURRENT_DATE FROM DUAL;

--4) 특정 날짜 및 시간 삽입 : 변환 함수 사용
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-RR';

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES(9091, SYSDATE);

SELECT * FROM EMP;

INSERT INTO EMP (EMPNO, HIREDATE)
VALUES(9093, TO_DATE(SYSDATE, 'DD-MON-RR'));

--세션 정리
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

DELETE FROM EMP WHERE EMPNO IN (9090, 9093);

--5) 스크립트 작성
-- : SQL문에 &치환을 사용하여 값을 입력하도록 요구
-- : &치환 - & 변수값에 대한 위치 표시자
INSERT INTO DEPT(DEPTNO, DNAME, LOC) --회사에서 6개월 지나면 비번 바꾸라고 하는 기능이랑 비슷함.
VALUES (&DEPTNO, '&DNAME', '&LOC');

--6) 다른 테이블에서 행 복사해서 삽입 
-- 서브 쿼리를 사용하여 한 번에 여러 데이터 추가하기 (동시에 한번에 넣을 순 없음)
SELECT * FROM SALGRADE;

INSERT INTO DEPT (DEPTNO) -- 서브쿼리처럼 쓰기 (VALUES대신 SELECT 넣기)
SELECT GRADE FROM SALGRADE
WHERE GRADE = 1;

SELECT * FROM DEPT;

--UPDATE 구문 (데이터 변경)
-- 1) 테이블 행 갱신
-- WHERE절 없으면 모든 행 갱신
-- WHERE절 있으면 특정 행 갱신
UPDATE DEPT
SET DNAME = 'G'
WHERE DEPTNO = 60;

--2) 서브쿼리를 사용하여 여러 열 갱신 가능
-- : SET절에 서브쿼리를 여러 개 사용하여 동시에 여러 컬럼 값을 변경 가능
-- : 동시에 여러 레코드를 갱신하는 것은 아님에 유의 !
CREATE TABLE CEMP
AS
SELECT * FROM EMP;

--7900사원읮 직책과 급여를 동시에 갱신 <- 7521 사원의 직책과 급여로 갱신
UPDATE CEMP
SET JOB = (SELECT JOB
            FROM CEMP
            WHERE EMPNO =7521),
    SAL = (SELECT SAL
            FROM CEMP
            WHERE EMPNO = 7521)
WHERE EMPNO = 7900;

-- 문제 : CEMP 테이블에서 사번이 7499인 사원과 동일한 직책을 가진 사원들의 SAL값을 7902사원의 SAL 값으로 변경하세요.
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

