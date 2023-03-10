drop table Student;
drop table Student_login;

create table Student (
	stuid varchar2(20) constraint Student_id_pk primary key, 
	stuname varchar2(15) constraint Student_name_nn not null,
	gender varchar2(15) constraint Student_gender_nn not null,
	korea number(4) constraint Student_korea_nn not null,
	english number(4) constraint Student_english_nn not null,
	math number(4) constraint Student_math_nn not null,
	science number(4) constraint Student_science_nn not null
);

insert into Student
values('2023e7188', '손흥민', '남자', 50, 56, 40, 48);

insert into Student
values('2023e7189', '홍길동', '남자',67, 98, 45, 67);

insert into Student
values('2023e7190', '김연아', '여자',90, 100, 89, 97);

commit;

select * from Student;

create table Student_login (
	id varchar2(20) constraint Student_login_id_pk primary key,
	passwd varchar2(20) constraint Student_login_passwd_nn not null,
	name varchar2(15) constraint Student_login_name_nn not null
);


insert into Student_login
values ('teacher1', '6789', '선생님1');

insert into Student_login
values ('teacher2', '4567', '선생님2');

commit;

select * from Student_login;