# join

# 다중 테이블 쿼리
# 대부분의 쿼리는 여러 테이블을 필요로 함(연결수단:외래 키 foreign key)

# 고객의 성과 이름, 주소를 검색할 경우
# customer 테이블의 first_name, last_name 열을 검색
# address 테이블의 address 열을 검색
# 연결 수단: address_id는 두 테이블에 공통으로 포함

# join의 종류
# self, right, full, inner(디폴트), cross, left...ADD

# ====================================================

# 교차 조인(cross join)
# 한 테이블의 모든 행들과 다른 테이블의 모든 행을 결합
# join의 조건이 없이 모든 행을 결홥
# 3행x3행=총 9개행
# select (조회 컬럼) from 테이블명1 [cross] join 테이블명2;

# customer 및 address 테이블을 join (교차 조인)
select c.first_name, c.last_name, a.address
from customer as c join address as a;


# ====================================================

# 내부조인(inner join) : 일반적인 join 유형(디폴트)
# 일치하지 않는 데이터는 검색하지 않음
# SELECT <열 목록> FROM <기준 테이블> 
# [INNER] JOIN <참조할 테이블> ON <조인 조건> [WHERE 검색 조건]

# 내부조인 예제

# customer 테이블의 address_id와 address 테이블의 address_id가 같은 경우에만 join

# 열목록
select c.first_name, c.last_name, a.address
# 기준테이블
from customer as c 
# 참조할 테이블(inner 생략가능)
inner join address as a
# 조건
on c.address_id = a.address_id;


# ====================================================

# 외부 조인(outer join)
# 한쪽 테이블에만 존재하는 데이터들을 다른 테이블에 결합하는 방식
# SELECT <열 목록> FROM <첫 번째 테이블(LEFT)>
# <LEFT | RIGHT | FULL> [OUTER] JOIN <두 번째 테이블(RIGHT)>
#ON <조인 조건> [WHERE 검색조건];

# ----------------------------------------------------

# ANSI join 문법
# 교재 : ANSI SQL 표준의 SQL92 버전 사용

# 이전 문법 : 내부 조인 및 필터 조건: WHERE절에 표기
# 조인 조건과 필터 조건을 구분하기 어려움
select c.first_name, c.last_name, a.address
from customer as c join address as a
where c.address_id = a.address_id and a.postal_code = 52137;

# SQL92 문법 표기 : Join 조건->ON 절, 필터 조건->WHERE 절
select c.first_name, c.last_name, a.address, a.postal_code
from customer as c join address as a
on c.address_id = a.address_id
where a.postal_code = 52137;

# ----------------------------------------------------

# 세 개 이상 테이블 조인

# customer테이블, address 테이블, city 테이블 사용
# 고객이 사는 도시를 반환하는 쿼리 작성

# city테이블 구조 확인
desc city;

# ====================================================

select c.first_name, c.last_name, ct.city
from customer as c

# customer 테이블과 address 테이블 inner join
# address_id를 사용하여 연결
inner join address as a
on c.address_id = a.address_id

# address 테이블과 city 테이블 inner join
# city_id를 사용하여 연결
inner join city as ct
on a.city_id = ct.city_id;

# ====================================================

# 서브쿼리 사용
select c.first_name, c.last_name, addr.address, addr.city, addr.district
from customer as c

# 서브쿼리와 customer테이블 join
inner join

# 서브쿼리(별칭:addr)
(select a.address_id, a.address, ct.city, a.district
from address as a
inner join city ct
# 서브쿼리 join 조건
on a.city_id = ct.city_id
where a.district = 'California'
) as addr

# join 조건
on c.address_id = addr.address_id;

# ====================================================

# 테이블 재사용
# 여러 테이블을 join할 경우, 같은 테이블을 두 번 이상 join 할 수 있음

# 조인 테이블: film, film_actor, actor 테이블
# 두 명의 특정 배우가 출연한 영화 제목 검색

# 각각의 배우가 출연한 영화 목록
select f.title
from film as f

inner join film_actor as fa
on f.film_id = fa.film_id

inner join actor a
on fa.actor_id = a.actor_id

where ((a.first_name = 'CATE' and a.last_name = 'MCQUEEN')
or (a.first_name = 'CUBA' and a.last_name = 'BIRCH'));

# 두 배우가 같이 출연한 영화 목록
# film 테이블에서 film_actor 테이블에 두 행(두 배우)가 있는 모든 행을 검색
# 같은 테이블을 여러 번 사용하기 때문에 테이블 별칭 사용(테이블 재사용)

select f.title
from film as f

inner join film_actor as fa1
on f.film_id = fa1.film_id
# film, film_actor, actor 내부 조인 #1
inner join actor a1 
on fa1.actor_id = a1.actor_id

inner join film_actor as fa2
on f.film_id = fa2.film_id
# film, film_actor, actor 내부 조인 #2
inner join actor a2 
on fa2.actor_id = a2.actor_id

where (a1.first_name = 'CATE' and a1.last_name = 'MCQUEEN')
and (a2.first_name = 'CUBA' and a2.last_name = 'BIRCH');

# ------------------------------------------------------

# 셀프 조인

# customer 테이블 생성 및 데이터 추가
use sqlclass_db;

# 기존의 테이블 지우기
# drop table if exists customer;

# 테이블 생성
create table customer
    (customer_id smallint unsigned,
    first_name varchar(20),
    last_name varchar(20),
    birth_date date,
    spouse_id smallint unsigned,
    constraint primary key (customer_id));

# 테이블 확인
desc customer;

# 테이블에 데이터 추가
insert into customer (customer_id, first_name, last_name, birth_date, spouse_id)
VALUES
(1, 'John', 'Mayer', '1983-05-12', 2),
(2, 'Mary', 'Mayer', '1990-07-30', 1),
(3, 'Lisa', 'Ross', '1989-04-15', 5),
(4, 'Anna', 'Timothy', '1988-12-26', 6),
(5, 'Tim', 'Ross', '1957-08-15', 3),
(6, 'Steve', 'Donell', '1967-07-09', 4);

insert into customer (customer_id, first_name, last_name, birth_date)
values (7, 'Donna', 'Trapp', '1978-06-23');

# 테이블 확인
select * from customer;

# 셀프 조인 예제
select 
    cust.customer_id,
    cust.first_name,
    cust.last_name,
    cust.birth_date,
    cust.spouse_id,
    
    # 새롭게 보여줄 열을 추가
    spouse.first_name as spouse_firstname,
    spouse.last_name as spouse_lastname

from customer as cust
    
# self-join: customer 테이블을 spouse로 가칭 사용
join customer as spouse
# 조인조건
on cust.spouse_id = spouse.customer_id;

# ----------------------------------------------------------

# 실습

# JOHN이라는 이름의 배우가 출연한 모든 영화의 제목을 출력
use sakila;

SELECT f.title from film as f

inner join film_actor as fa
on f.film_id=fa.film_id

inner join actor as a
on fa.actor_id=a.actor_id

WHERE a.first_name='JOHN';

# ========================================================

# 같은 도시에 있는 모든 주소를 반환하는 쿼리 작성

select 
    a1.address as addr1,
    a2.address as addr2,
    a1.city_id, a1.district
# 셀프조인 : a1, a2 각각 다른 가칭 사용
from address as a1

inner join address as a2

where (a1.city_id = a2.city_id) 
    and (a1.address_id != a2.address_id);
