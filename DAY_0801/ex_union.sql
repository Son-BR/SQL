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
