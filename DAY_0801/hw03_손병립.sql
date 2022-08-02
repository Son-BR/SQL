-- Active: 1658998083382@@127.0.0.1@3306@shoppingmall
# SQL 과제 #3

# 1. 아래 2개의 테이블을 생성하고, 주어진 문제에 대한 sql문장을 작성하시오.
# 제출물: hw03.sql, hw03.ipynb 또는 hw03.py

#데이터베이스 이름: shoppingmall
CREATE DATABASE shoppingmall;

use shoppingmall;

drop table user_table;
drop table buy_table;

# 테이블 이름: user_table
create table user_table
(userID CHAR(8) PRIMARY KEY,
userName VARCHAR(10) not null,
birthYear int not null,
addr CHAR(2) not null,
mobile1 CHAR(3),
mobile2 CHAR(8),
height SMALLINT,
mDate DATE);


# user_table 데이터
insert into user_table
(userID, userName, birthYear, addr, mobile1, mobile2, height, mDate)
values ('KHD', '강호동', 1970, '경북', '011', '22222222', 182, 20070707),
('KJD', '김제동', 1974, '경남', NULL, NULL, 173, 20130303),
('KYM', '김용만', 1967, '서울', '010', '44444444', 177, 20150505),
('KKJ', '김국진', 1965, '서울', '019', '33333333', 171, 20090909),
('LHJ', '이휘재', 1972, '경기', '011', '88888888', 180, 20060404),
('LKK', '이경규', 1960, '경남', '018', '99999999', 170, 20041212),
('NHS', '남희석', 1971, '충남', '016', '66666666', 180, 20170404),
('PSH', '박수홍', 1970, '서울', '010', '00000000', 183, 20120505),
('SDY', '신동엽', 1971, '경기', NULL, NULL, 176, 20081010),
('YJS', '유재석', 1972, '서울', '010', '11111111', 178, 20080808);

# 테이블 이름: buy_table
create table buy_table
(num int auto_increment not null,
userID CHAR(8) not null,
prodName char(8) not null,
groupName CHAR(4),
price INT not null,
amount SMALLINT not null,
constraint primary key (num),
constraint foreign key (userID)
references user_table(userID)
);

# buy_table 데이터
insert into buy_table(userID, prodName, groupName, price, amount)
VALUES ('KHD', '운동화', null, 30, 2),
('KHD', '노트북', '전자', 1000, 1),
('KYM', '모니터', '전자', 200, 1),
('PSH', '모니터', '전자', 200, 5),
('KHD', '청바지', '의류', 50, 3),
('PSH', '메모리', '전자', 80, 10),
('LHJ', '책', '서적', 15, 2),
('KJD', '책', '서적', 15, 5),
('LHJ', '청바지', '의류', 50, 1),
('PSH', '운동화', NULL, 30, 2),
('LHJ', '책', '서적', 15, 1),
('PSH', '운', NULL, 30, 2);

select * from buy_table;

# 2. 두 테이블을 내부 조인(buy_table.useID와 user_table.userID)한 다음, 아래의 결과와 같이 출력이 되도록 SQL 쿼리를 작성하시오.

# 1) 내부 조인한 결과에 ‘연락처’ 컬럼 추가
select userName, b.prodName, addr, concat(mobile1,mobile2) as 연락처
from user_table as u
inner join buy_table as b
on u.userID=b.userID;

# 2) userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
select b.userID, u.userName, prodName, u.addr, concat(u.mobile1,u.mobile2)
from buy_table as b
inner join user_table as u
on b.userID='KYM' and u.userID='KYM';

# 3) 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
select u.userID, u.userName, b.prodName, u.addr, concat(mobile1,mobile2) as 연락
from user_table as u
inner join buy_table as b
order by userID;

# 4) 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력
# ( distinct 사용 )

select distinct u.userID, userName, addr from user_table as u
inner join buy_table as b
on b.userID=u.userID
ORDER BY u.userID;

# 5) 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력이
select u.userID, userName, addr, concat(mobile1,mobile2) as 연락 from user_table as u
inner join buy_table as b
on b.userID=u.userID
where addr='경북' or addr='경남'
order by u.userID;