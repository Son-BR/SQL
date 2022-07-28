show databases;
use sakila;

select now(); # select : print?, ; -> 명령어의 끝

show character set;

# 연습용 db생성    #db이름
create database testdb;

# db 삭제
# drop database testdb;

# 생성한 db 선택
use testdb;

# person 테이블 생성
create table person # person: 테이블 이름
	(person_id SMALLINT UNSIGNED,
	fname VARCHAR(20),
	lname VARCHAR(20),
	eye_color ENUM('BR','BL','GR'),
	birth_date DATE,
	street VARCHAR(30),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(20),
	CONSTRAINT pk_person PRIMARY KEY (person_id) # 기본 키 제약조건
	);						
	
# 기본 키 제약조건
-- CONSTRAINT [제약 조건 이름] PRIMARY KEY (필드이름)
-- • 기본 키(primary key)로 person_id 열을 선정
-- - NOT NULL과 UNIQUE 제약 조건의 특징을 가짐
-- • 제약 조건(CONSTRAINT)
-- - 데이터의 무결성을 지키기 위해, 데이터를 입력 받을 때 실행되는 검사 규칙

# person 테이블 확인
desc person;

# favorite_food 테이블 생성
create table favorite_food
	(person_id smallint unsigned,
	food VARCHAR(20),
	# primary key(person_id, food): 2개의 primary key 설정
	constraint pk_favorite_food primary key (person_id, food),
	# 외래 키(foreign key) 제약 조건
	# favorite_food 테이블에서 person_id의 값에 person 테이블에 있는 값만 포함되도록 제한
	constraint fk_fav_food_person_id foreign key (person_id)
	# references 테이블이름 (필드이름)
	# 현재 테이블에서 참조되는 다른 테이블 이름 및 필드 이름 명시
	references person(person_id));

# favorite_food 테이블 확인
desc favorite_food;

# 테이블 수정 : ALTER
	# 숫자키 데이터 생성
		# MySQL: 자동 증가(auto-increment) 기능 제공
		# foreign key로 설정된 부분은 다른 테이블에서 변경시 에러 발생
			# 제약 조건 비활성화 -> 테이블 수정 -> 제약 조건 활성화
		# SQL 명령어로 수정

# 제약조건 비활성화
set foreign_key_checks=0;

alter table person modify person_id smallint unsigned auto_increment;

# 제약 조건 활성화
set foreign_key_checks=1;

desc person;

# 데이터 추가: INSERT문
insert into person
(person_id, fname, lname, eye_color, birth_date)
values(null,'William', 'Turner', 'BR', '1972-05-27');

# 데이터 확인 : select * from db이름; 모든 데이터(행, 컬럼) 데이터 출력
select * from person;

# 특정 열의 데이터만 출력(열이름) : SELECT 열 이름1, 열 이름2, ... FROM 테이블이름;
select person_id, fname, lname, birth_date from person;

# 특정 열의 데이터만 출력(조건) : lname의 값이 ‘Turner’인 데이터 중에서 person_id, fname, lname, birth_date 열만 출력
select person_id, fname, lname, birth_date from person where lname = 'Turner';

# 한 행씩 추가
-- insert into favorite_food (person_id, food)
-- values (1, 'pizza');
-- 
-- insert into favorite_food (person_id, food)
-- values(1, 'cookies');
-- 
-- insert into favorite_food (person_id, food)
-- values (1, 'nachos');

# 한 번에 여러 행 추가 : values(값1), (값2), … ;
insert into favorite_food (person_id, food)
values (1, 'pizza'), (1, 'cookie'), (1, 'nachos');

select * from favorite_food;

# 컬럼의 값을 알파벳 순서로 정렬 : order by 컬럼이름 ASC; ->오름차순(기본)
select food from favorite_food
where person_id = 1 order by food;

# order by 컬럼이름 DESC; -> 내림차순
select food from favorite_food
where person_id = 1 order by food DESC;

# person 테이블에 다른 데이터 추가
insert into person
(person_id, fname, lname, eye_color, birth_date,
street, city, state, country, postal_code)
values (null, 'Susan', 'Smith', 'BL', '1975-11-02',
'23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

# 데이터 확인
# person_id 필드에 자동으로 2가 저장됨 : auto_increment
select person_id, fname, lname, birth_date from person;

# 데이터 수정 : UPDATE문
# UPDATE 테이블이름 SET 필드이름1 = 값1, 필드이름2=값2, ... WHERE 필드이름=데이터값;

# William Turner의 정보 추가
update person
set street='1225 Tremon St.',
	city='Boston',
	state='MA',
	country='USA',
	postal_code = '02138'
where person_id=1;

select * from person;

# 데이터 삭제: DELETE 문
# DELETE FROM 테이블이름 WHERE 필드이름=데이터값;
	# where절 생략하면 모든 데이터 삭제, 테이블은 남음
	# 테이블 전체 삭제 : drop table 테이블명;

delete from person where person_id=2;

select * from person;