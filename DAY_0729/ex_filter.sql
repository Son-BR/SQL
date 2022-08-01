-- Active: 1658998083382@@127.0.0.1@3306@sakila
use sakila;

# 필터링

# --------------------------------------------------------------
# 조건평가 : ex_filter02.sql 파일 참고
# --------------------------------------------------------------
# 조건작성 : ex_filter02.sql 파일 참고
# --------------------------------------------------------------

# 조건 유형
# 동등 조건(equality condition) : ‘열 = 표현/값'’'
select c.email
from customer as c
    inner join rental as r
 # on, where 2개의 동등조건
    on c.customer_id = r.customer_id
where date(r.rental_date) = '2005-06-14';

# ===========================================================

# 부등 조건(inequality condition): 두 표현이 동일하지 않음
# <> 또는 != 사용
select c.email
from customer as c
    inner join rental as r
    on c.customer_id = r.customer_id
# 부등 조건
where date(r.rental_date) <> '2005-06-14';

# ===========================================================

# 동등/부등 조건 사용 예

# 데이터를 수정할 때 사용
delete from rental
where year(rental_date) = 2004;

delete from rental
where year(rental_date) <> 2005 and year(rental_date)<>2006;

# ===========================================================

# 범위 조건 : 해당 식이 특정 범위 내에 있는지 확인
select customer_id, rental_date
from rental
where rental_date < '2005-05-25';

# 해당 날짜만 검색: date(rental_date) = ‘2005-05-25'’'

select customer_id, rental_date
from rental
# 범위 조건 (2005년 6월 14일 00:00:00~2005년 6월 16일 00:00:00)
where rental_date <= '2005-06-16'
    and rental_date >= '2005-06-14';

# 범위 조건 2005년 6월 14일부터 6월 16일까지의 데이터를 출력하기 위해 date(rental_date)를 사용: 정확한 날짜만 추출
select customer_id, rental_date
from rental
where date(rental_date) <= '2005-06-16'
    and date(rental_date) >= '2005-06-14';

# ===========================================================

# between 연산자
# 형태 : between [범위의 하한값] and [범위의 상한값]

select customer_id, rental_date
from rental
where rental_date between '2005-06-14' and '2005-06-16';

# 숫자 범위 사용 : 하한값과 상한값이 범위에 포함됨
select customer_id, payment_date, amount
from payment
 # 10도 범위에 포함
where amount between 10.0 and 11.99;

# ===========================================================

# 문자열 범위
# last_name이 ‘FA'’'와 ‘FRB'’'로 시작하는 데이터 리턴
select last_name, first_name
from customer
where last_name between 'FA' and 'FRB';

# --------------------------------------------------------------

# 멤버십 조건

# ========================================================

# OR 또는 IN() 연산
# 유한한 값의 집합으로 제한
# IN() 연산
 # 컬럼명 IN (값1, 값2, ...)
 # 지정한 컬럼의 값이 특정 값에 해당되는 조건을 만들 때 사용 (or 대신 사용)

select title, rating
from film
where rating='G' or rating='PG';

select title, rating
from film
where rating in ('G', 'PG');

# ========================================================

# 서브쿼리 사용 : 값의 집합을 생성할 수 있음
select title, rating
from film
where rating in (select rating from film where title like '%PET%');

 # 서브 쿼리 내용
-- 'PET'을 포함하는 영화 제목을 찾고, 그 영화 제목의 rating을 반환 (‘P'’', ‘PG'’')
-- 'PET%': PET로 시작하는 단어
-- '%PET'': PET로 끝나는 단어
-- '%PET%'': PET를 포함하는 단어
select title, rating from film where title like '%PET%';

# where 절 내용
# where rating in ('G', 'PG');

# ========================================================

# not in 사용 : 표현식 집합 내에 존재하지 않음

# 영화 등급이 ‘PG-13’, ‘R’, ‘NC-17’이 아닌 모든 영화를 찾음
select title, rating
from film
where rating not in ('PG-13', 'R', 'NC-17');

# --------------------------------------------------------------

# 일치 조건

# 문자열 부분 가져오기

# left(문자열, n) : 문자열의 가장 왼쪽부터 n개 가져옴
# abc
select left('abcdefg', 3);

# mid(문자열, 시작 위치, n), substr(문자, 시작 위치, n)
# bcd
select mid('abcdefg', 2, 3);

# right(문자열, n): 문자열의 가장 오른쪽부터 n개 가져옴
# fg
select right('abcdefg', 2);

# ======================================================

# 와일드 카드
# ‘_’: 정확히 한 문자 (underscore)
# ‘%’: 개수에 상관없이 모든 문자 포함

# 일치 조건 조건(matching condition) : 와일드 카드 사용시 LIKE 연산자를 사용
select last_name, first_name
from customer

# 두 번째 위치에 ‘A’, 네 번째 위치에 ‘T’를 포함하며 마지막은 ‘S’로 끝나는 문자열
where last_name like '_A_T%S';

# last_name이 ‘Q’로 시작하거나 ‘Y’로 시작하는 고객 이름 검색
select last_name, first_name
from customer
where last_name like 'Q%' or last_name like 'Y%';

# 정규 표현식 사용

# ‘^[QY]’: Q 또는 Y로 시작하는 단어 검색
select last_name, first_name
from customer

# ^:시작 $:끝
where last_name REGEXP '^[QY]';

# ---------------------------------------------------------------------------------

# NULL

# Null값의 다양한 경우 : 해당 사항 없음, 아직 알려지지 않은 값, 정의되지 않은 값

# Null 확인 방법 : is null 사용 (= null)
select rental_id, customer_id, return_date
from rental
where return_date is null;

# is not null : 열에 값이 할당되어 있는 경우 (null이 아닌 경우)
select rental_id, customer_id, return_date
from rental
where return_date is not null;

# Null과 조건 조합

# 2005년 5월에서 8월 사이에 반납되지 않은 대여 정보 검색

select rental_id, customer_id, return_date
from rental
# 반납이 되지 않은 경우, 반납 날짜의 값이 NULL
where return_date is null
# 반납 날짜가 2005년 5월~ 2005년 8월 사이가 아닌 경우
or return_date not between '2005-05-01' and '2005-09-01';

# ---------------------------------------------------------------------

# 실습

# 서브셋 조건 설정
# payment 테이블 payment_id, customer_id, amount, payment_date 컬럼
# payment_id : 101~120
# payment_date열은 날짜만

# 서브셋
select payment_id, customer_id, amount, date(payment_date) As payment_date
from payment
where (payment_id between 101 and 120);

# 1) 아래의 필터조건에 따라 반환되는 payment_id는 무엇입니까?
# customer_id가 5가 아니고
# amount가 8보다 크거나 payment_date가 2005년 8월 23일인 경우
select payment_id, customer_id, amount, date(payment_date) As payment_date
from payment
where (payment_id between 101 and 120)
and customer_id != 5 and (amount > 8 or date(payment_date) = '2005-08-23');

# 2) 다음 필터조건에 따라 반환되는 payment_id는 무엇입니까?
# customer_id는 5이고
# amount가 6보다 크거나 payment_date가 2005년 6월 19일이 아닌 payment_id
select payment_id, customer_id, amount, date(payment_date) As payment_date
from payment
where (payment_id between 101 and 120)
and customer_id=5 and not (amount > 6 or payment_date = '2005-06-19');

# 3) payment 테이블에서 금액이 1.98, 7.98 또는 9.98인 모든 행을 검색하는 쿼리
select amount from payment
where amount in (1.98, 7.98, 9.98);