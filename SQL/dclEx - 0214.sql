--+DCL (Data Control Language)
--
--+오라클 DB 사용자
--1) SYS : 소유자
--2) SYSTEM : DBA
--3) SCOTT : END-USER (최종 사용자) => 가장 권한이 없는 사용자
--
--+ 권한 
--1) SYSTEM : 시스템에 영향을 미치는 권한 
--            GRANT 권한 TO 사용자명;
--            REVOKE 권한 FROM 사용자명;
--            : SYS가 권한을 가지고 있음.
--
--2) OBJECT : 해당 OBJECT에만 영향을 미치는 권한
--            GRANT 권한 ON OBJECT명 TO 사용자명;
--            REVOKE 권한 ON OBJECT명 FROM 사용자명;
--            : 해당 OBJECT 생성자가 권한을 가짐.

--==================================================
-- 명령프롬프트
SHOW USER

-- USER1 만듬 (갑자기 지워버리셔서 못함)
CREATE USER USER1
IDENTIFIED BY TIGER;

GRANT CONNECT, RESOURCE TO USER1;

-- SELECT 문으로 특정 객체를 조회할 때 권한이 없는 사용자에게는 존재조차 밝여주지 않도록 처리
-- 보안성을 높임
GRANT SELECT ON EMP TO USER1;


-- 권한 회수
REVOKE SELECT, UPDATE ON COPY_EMP FROM USER1; 

--계정관리
CONN SYS/6789 AS SYSDBA

--계정 삭제
DROP USER USER1;

--PW 변경
ALTER USER USER1
IDENTIFIED BY LION;

--비번 변경 요구
CREATE USER USER2
IDENTIFIED BY TIGER
PASSWORD EXPIRE
ACCOUNT UNLOCK;

--[실습] 계정이 존재는 하지만 접근은 안되게 하고 싶을 때 (로그린 금지)
--USER2가 로그인이 안되도록 해보세요
ALTER USER USER2
ACCOUNT LOCK;
