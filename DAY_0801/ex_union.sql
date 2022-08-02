# 집합 연산자

# 집합 연산 규칙
# 같은 수의 열(column)을 가져야 함
# 두 데이터셋의 각 열의 자료형은 서로 동일해야 함

select 1 as num, 'abc' as str
union
select 9 as num, 'xyz' as str;


# union 연산자 : 결합된 집합을 정렬하고 중복을 제거(파이썬의 set)

# union all 연산자 : 최종 데이터셋의 행의 수는 결합되는 집합의 행의 수의 총합과 같음(중복 제거 x)

# 집합 연산 전 테이블 구성 확인
# 두 테이블 모두, first_name, last_name이 존재하고 데이터타입도 동일

desc customer;

desc actor;

# ---------------------------------------------------------

# union all, union 연산 수행

# =========================================================

# 799행 : customer 599행, actor 200행
select 'CUST' as type1, c.first_name, c.last_name
from customer as c
union all
select 'ACTR' as type1, a.first_name, a.last_name
from actor as a;

# 행 갯수 확인
select count(first_name) from customer;
select count(first_name) from actor;

# =========================================================

# actor 테이블에 union_all 연산 수행
# 중복제거 x, 총 데이터수 400개로 늘어남

select 'ACTR' as typ, a.first_name, a.last_name
from actor as a
union all
select 'ACTR' as typ, a.first_name, a.last_name
from actor as a;

# =========================================================

# customer 테이블과 actor 테이블에서 이름이 ‘J’로 시작하고 성은 ‘D’로 시작하는 사람들의 합집합: union all (중복)

select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%'

union all

select a.first_name, a.last_name
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%';

# =========================================================

# union : 중복 데이터 제거

select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%'

union

select a.first_name, a.last_name
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%';

# =========================================================

# intersect 연산자
# MySQL 8.0 버전에서 지원 안함
# inner join으로 동일한 결과를 얻을 수 있음

select c.first_name, c.last_name
from customer as c
inner join actor as a
    on (c.first_name = a.first_name)
        and (c.last_name = a.last_name);


select c.first_name, c.last_name
from customer as c
inner join actor as a
    on (c.first_name = a.first_name)
        and (c.last_name = a.last_name)
where a.first_name like 'J%' and a.last_name like 'D%';

# ------------------------------------------------------

# 집합 연산 규칙

# =====================================================

# 복합 쿼리의 결과 정렬
# order by 절을 쿼리 마지막에 추가

select a.first_name as fname, a.last_name as lname
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%'
# 복합쿼리의 열이름
order by lname, fname;

# 열 이름 정의는 복합 쿼리의 첫 번째 쿼리에 있는 열의 이름을 사용해야 함
# 복합쿼리에 없는 열이름 -> 예외발생
select a.first_name as fname, a.last_name as lname
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%'
union all
select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%'
order by last_name, first_name;

# =====================================================

# 집합 연산의 순서
# 복합 쿼리는 위에서 아래의 순서대로 실행
# 예외 : intersect 연산자(union, union all...)가 다른 집합 연산자보다 우선 순위가 높음
# 집합 연산의 순서에 따라 연산 결과는 달라집

# 1)
select a.first_name, a.last_name
from actor as a
where a.first_name like 'J%' and a.last_name like 'D%'

# 2) 중복 허용
union all
select a.first_name, a.last_name
from actor as a
where a.first_name like 'M%' and a.last_name like 'T%'

# 3) 중복 허용 x
union
select c.first_name, c.last_name
from customer as c
where c.first_name like 'J%' and c.last_name like 'D%';

# ----------------------------------------------------------

# 학습 점검

# 성이 L로 시작하는 모든 배우와 고객의 이름과 성을 찾는 복합 쿼리 작성

select first_name, last_name from actor
where last_name like 'L%'

UNION
SELECT first_name, last_name from customer
where last_name like 'L%';