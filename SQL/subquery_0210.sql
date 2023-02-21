--[서브쿼리]
-- : 일종의 select문 고급 기능
-- : select문을 조건절에 넣어줄 수 있음 - 조건절에 들어가는 select문을 서브쿼리하고 한다.
-- : 최종적으로 인출하려는 값을 표기하는 부분 - 메인쿼리
-- 
-- 서브쿼리 인출값이 하나이면 단일행 서브쿼리
--                   여러개면 다중행 서브쿼리
--                   
--* 주의사항
--1) 서브쿼리는 반드시 괄호 안에 쓰기
SELECT SAL
FROM EMP
WHERE ENAME = 'JONES';

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES');
            
--2) 단일행 서브쿼리 앞에는 SINGLE ROW OPERATOR (비교 연산자) 자 와야 한다. 
-- : =, >=, <=, >, <, ==, <>

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES' OR COMM IS NOT NULL);
            
--3) 다중행 서브쿼리 앞에는 MULTIPLE ROW OPERATOR (IN, ANY, ALL) 가 와야 한다. 
-- IN 연산자 : 여러 값 중 하나와 같다.

-- 10번 부서 사원들의 급여와 같은 급여를 받는 사원의 이름과 급여를 조회
-- 1번째 조건의 결과가 3줄이 나옴 => 다중행쿼리
SELECT SAL
FROM EMP
WHERE DEPTNO = 10;

SELECT ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT SAL
               FROM EMP
               WHERE DEPTNO = 10);
               
--문제 : 부서번호가 10, 20, 30번인 직원들의 부서번호별 평균 급여 중 하나와 같은 급여를 받는
--       사원의 사번, 이름, 급여 정보를 조회하세요.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL IN (SELECT TRUNC(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--문제 : 부서번호별로 가장 많은 급여를 받는 사원의 정보를 출력하세요 - 5분
SELECT MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)
            FROM EMP
            GROUP BY DEPTNO);
            
            
--문제 : 다른 직원의 상관으로 근무하고 있는 직원의 사번, 이름, 급여를 조회하세요 - 5분
SELECT MGR
FROM EMP;

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO IN (SELECT MGR
                 FROM EMP);
                 
--반대로 다른 직원의 상관이 아닌 (부하직원이 없는) 직원들의 사번, 이름, 급여를 조회하세요 - 3분
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP);

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP
                    WHERE MGR IS NOT NULL);

--ANY 연산자 : 여러 값 중 하나 
--           : 비교 연산자가 앞에 나와야 함.
--           : 값 하나를 리스트의 값 또는 쿼리에서 반환되는 값과 각각 비교
--           
--SALESMAN 직책의 급여보다 많이 받는 사원의 사원명과 급여를 조회

SELECT SAL
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ANY (SELECT SAL
            FROM EMP
            WHERE JOB = 'SALESMAN');

--문제 : 부서번호가 10, 20, 30번인 직원들의 부서번호별 평균 급여 중 하나보다 작거나 같은 급여를 받는
--       직원의 급여, 이름, 사번을 조회하세요.

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

-- 같은 결과
SELECT SAL, ENAME, EMPNO
FROM EMP
WHERE SAL <= (SELECT MAX(AVG(SAL))
                FROM EMP
                WHERE DEPTNO IN (10, 20, 30)
                GROUP BY DEPTNO);
                
--ALL 연산자 : 모든 값
--           : 비교 연산자가 앞에 위치

--모든 SALESMAN의 급여보다 많이 받는 사원의 사원명과 급여 정보를 조회
SELECT SAL
FROM EMP
WHERE JOB = 'SALESMAN';

SELECT ENAME, SAL
FROM EMP
WHERE SAL > ALL (SELECT SAL  --> ANY는 모든것과 비교, ALL은 전부다?? 이거 복습하기
                FROM EMP
                WHERE JOB = 'SALESMAN');

--문제 : 부서번호가 10, 20, 30번인 직원들의 부서번호별 평균급여 모두보다 작은 급여를 받는
--       직원의 사번, 급여, 이름을 조회하세요 - 8분
--① 다중행 서브쿼리
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
--② 단일행 서브쿼리
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL < (SELECT MIN(AVG(SAL))
             FROM EMP
             WHERE DEPTNO IN (10, 20, 30)
             GROUP BY DEPTNO);
             
--4) 단일 행 서브쿼리 집합함수 사용 가능
--EMP 테이블에서 부서별 평균급여가 가장 큰 부서번호와 그 평균급여를 구하시오
SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;


SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);

--문제 : EMP 테이블에서 직책별 평균 급여가 가장 작은 직책과 그 평균급여를 구하시오
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB
HAVING AVG(SAL) = (SELECT MIN(AVG(SAL))
                    FROM EMP
                    GROUP BY JOB);
                    
--5) 서브쿼리가 메인쿼리로 반환되는 행이 없으면 '선택된 행이 없음' 이라는 메시지가 표시됨.
--   중요/주의)문제는 행이 있지만 해당 컬럼이 NULL인 경우도 '선택된 행이 없음' 이라는 메시지가 표시됨에 유의 
SELECT ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
              FROM EMP
              WHERE EMPNO = 9999);
              
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP);

--만족하는 행이 있지만 NULL 상태인 경우는 추후 문제가 발생할 수 있으므로 문제점을 해결해야 함.
--해결하는 방법
--① NULL 상태로 두지 않고 대체값으로 채우기
--  문자데이터 유형이라면 '-' 값, 숫자 데이터 유형 0값, 통계적으로 인정되는 값 (평균값, 중앙값, 최빈값 등) 
--  : 대체값을 미리 입력해두면 최종 결과과 표시될 수 있음.
--  
--② NULL 처리 함수
--  : 데이터의 양이나 인덱스 키 값 구성방법에 따라 데이터베이스에 부하를 유의


SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE EMPNO NOT IN (SELECT MGR
                    FROM EMP
                    WHERE MGR IS NOT NULL);

--6) EXISTS 연산자 : 테이블에 특정 행이 있는지 여부에 따라 쿼리 결과가 달라지는 질의에 사용하는 연산자
--                  : 서브쿼리 데이터가 존재하는가를 체크해 존재 여부 (True/False)를 결과로 반환
--                  : 서브쿼리 결과행을 찾으면 inner query 수행을 중단하고 True 를 반환 

-- ① 부서원이 없는 부서정보를 조회
SELECT * 
FROM DEPT
WHERE NOT EXISTS (SELECT *
                    FROM EMP
                    WHERE EMP.DEPTNO = DEPT.DEPTNO);

SELECT D.DEPTNO, D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;

-- ② ①의 정보가 없는 정보 조회
SELECT *
FROM DEPT
WHERE NOT EXISTS (SELECT *
                  FROM EMP
                  WHERE EMP.DEPTNO = DEPT.DEPTNO);
                     
SELECT DISTINCT(D.DEPTNO), D.DNAME
FROM DEPT D, EMP E
WHERE D.DEPTNO = E.DEPTNO;


--사원 테이블을 통해 사원들이 속한 부서번호의 정보를 조회
--=> 추출하고자 하는 정보의 대상 테이블은 DEPT이지만 EMP 테이블과 조인하여 부서번호를 체크해야 함.
--   두 테이블의 관계는 1:N 관계임. 그러므로 불필요하게 EMP 테이블을 모두 읽어야만 하는 상태임.
--   최종적으로는 중복제거를 해서 올바른 결과를 얻어내고 있는 구조.

SELECT D.DEPTNO, D.DNAME
FROM DEPT D
WHERE EXISTS (SELECT 1
               FROM EMP E
               WHERE E.DEPTNO = D.DEPTNO);

--EXISTS 연산자를 사용한 질의문
-- : 추출하고자 하는 대상만을 FROM 절에 놓고 EMP 테이블은 체크만 하기 위해 EXISTS 절에 위치시킨 상태
--   그러면 전체 수행속도가 대폭 감소

-- 7) 서브쿼리문에는 ORDER BY 절을 지원하지 않는다. (에러 발생함) (정렬 X)
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT SAL
             FROM EMP
             WHERE ENAME = 'JONES')  --> ORDER BY 지원 안 하므로 에러 발생. 불필요함
ORDER BY SAL;  --> 정렬은 서브쿼리 끝난 뒤에 진행 

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
