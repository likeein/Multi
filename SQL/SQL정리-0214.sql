--정리 : SQL
--
--QUERY : SELECT 
--
--4    SELECT 컬럼명, 컬럼명, *, f(x), ||, 'STRING', ALLIAS, DISTINCT, 연산
--1    FROM 테이블명, 테이블명, .... n 
--2    WHERE condition -> 연산자 (비교/논리/BETWEEN A AND B/IN/LIKE/IS NULL) -> NOT 부정
--3    GROUP BY 컬럼명, 컬럼명 ....
--5    HAVING condition -> WHERE절 연산자와 같은 연산자
--6    ORDER BY 컬럼명(컬럼명/ ALIAS/POSITION) <ASC/DESC>, 컬럼명{첫번째 컬럼 1차 정렬, 다음 두번째 컬럼으로 2차 정렬}

--DML : INSERT, UPDATE, DELETE (ROLLBACK 가능)
--TCL : COMMIT, ROLLBACK, SAVEPOINT
--DDL : CREATE, ALTER, DROP, RENAME, TRUNCATE, COMMENT (AUTO COMMIT 발생 -> ROLLBACK 불가능)
--DCL : GRANT, REVOKE