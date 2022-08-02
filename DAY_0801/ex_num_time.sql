# 숫자 데이터 처리

# =========================================================

# 산술함수 설명
-- cos(x) x의 코사인 계산
-- cot(x) x의 코탄젠트 계산
-- ln(x) x의 자연로그 계산
-- sin(x) x의 사인 계산
-- sqrt(x) x의 제곱근 계산
-- tan(x) x의 탄젠트 계산
-- exp(x) ex 를 계산
-- mod(a, b) a를 b로 나눈 나머지 구하기
-- pow(a, b) a의 b 제곱근 계산
-- sign(x) x가 음수이면 -1, 0이면 0, 양수이면 1 반환
-- abs(x) x의 절대값 계산

# ========================================================

# 숫자 자릿수 관리

# ceil() 함수: 가장 가까운 정수로 올림
select ceil(72.445); 

# floor() 함수: 가장 가까운 정수로 내림
select floor(72.445);

# round() 함수: 반올림, 소수점 자리를 정할 수 있음
select round(72.0909, 1), round(72.0909, 2);

# truncate() 함수: 원치 않는 숫자를 버림
select truncate(72.0956, 1), truncate(72.0956, 2), truncate(72.0956, 3);

# sign() 함수 : 값이 음수이면 -1, 0이면 0, 양수이면 1을 반환
select sign(-785), abs(-785), sign(456), abs(456);

# -------------------------------------------------------

# 시간 데이터 처리

# 시간대(time zone)처리
# 24개의 가상 영역으로 분할
# 협정 세계표준시(UTC: Universal Time Coordinated) 사용
# utc_timestamp() 함수 제공

# 시간 데이터 생성 방법
# 기존 date, datetime 또는 time 열에서 데이터 복사
# date, datetime 또는 time을 반환하는 내장 함수 실행
# 서버에서 확인된 시간 데이터를 문자열로 표현

# 날짜 형식의 구성 요소
-- 자료형 / 기본 형식 / 허용값
-- YYYY  /   연도   / 1000 ~ 9999
-- MM    /    월    / 01(1월) ~ 12(12월)
-- DD    /    일    / 01 ~ 31
-- HH    /   시간   / 00 ~ 23
-- MI    /    분    / 00 ~ 59
-- SS    /    초    / 00 ~ 59

# 필수 날짜 구성 요소
-- 자료형     / 기본 형식    / 허용값
-- date      / YYYY-MM-DD / 1000-01-01 ~ 9999-12-31
-- datetime  / YYYY-MM-DD / HH:MI:SS 1000-01-01 00:00:00.000000 ~ 9999-12-31 23:59:59.999999
-- timestamp / YYYY-MM-DD / HH:MI:SS 1970-01-01 00:00:00.000000 ~ 2038-01-18 22:14:07.999999
-- time      / HHH:MI:SS  / −838:59:59.000000 ~ 838:59:59.000000

# 시간 데이터의 문자열 표시
# datetime 기본 형식: YYYY-MM-DD HH:MI:SS
# datetime 열을 2022년 8월 1일 오전 09:30 으로 표현
# ‘2022-08-01 09:30:00’ 의 문자열로 구성

# MySQL 서버의 시간 데이터 처리
# datetime 형식으로 표현된 문자열에서 6개의 구성요소를 분리해서 문자열을 변환;

# ==========================================================

# cast() 함수 : 지정한 값을 다른 데이터 타입으로 변환

# cast() 함수를 이용해서 datetime값을 반환하는 쿼리 생성
select cast('2019-09-17 15:30:00' as datetime);

# date 값과 time 값을 생성
select cast('2019-09-17' as date) date_field,
cast('108:17:57' as time) time_field;

# MySQL의 문자열을 이용한 datetime 처리

# MySQL은 날짜 구분 기호에 관대
# 2019년 9월 17일 오후 3시 30분에 대한 유효한 표현 방식
# '2019-09-17 15:30:00'
# '2019/09/17 15:30:00'
# '2019,09,17,15,30,00'
# '20190917153000'
select cast('20190917153000' as datetime);

# =====================================================

# str_to_date() : 날짜 생성 함수
# 형식 문자열의 내용에 따라 datetime, date 또는 time값을 반환
# cast() 함수를 사용하기에 적절한 형식이 아닌 경우 사용

#'September 17, 2019' 문자열을 date 형식으로 변환
select str_to_date('September 17, 2019', '%M %d, %Y') as return_date;

# 날짜 형식의 구성 요소
# 요소 / 정의
-- %M / 월 이름(January ~ December)
-- %m / 숫자로 나타낸 월(01 ~12)
-- %d / 숫자로 나타낸 일(01 ~ 31)
-- %j / 일년 중 몇 번째 날(001 ~ 366)
-- %W / 요일 이름(Sunday ~ Saturday)
-- %Y / 연도, 4자리 숫자
-- %y / 연도, 2자리 숫자
-- %H / 시간 (00 ~ 23)
-- %h / 시간 (01 ~ 12)
-- %i / 분 (00 ~ 59)
-- %s / 초 (00 ~ 59)
-- %f / 마이크로초(000000 ~ 999999)
-- %p / 오전 또는 오후

# ====================================================;

# 현재 날짜/시간 생성
# 내장 함수가 시스템 시계를 확인해서 현재 날짜 및 시간을 문자열로 반환
# CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP()
select CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

# date_add() : 지정한 날짜에 일정 기간(일, 월, 년 등)을 더해서 다른 날짜를 생성(날짜)
select date_add(current_date(), interval 5 day);

# 기간 자료형
# 기간명            / 정의
-- second          / 초
-- minute          / 분
-- hour            / 시간
-- day             / 일 수
-- month           / 개월 수
-- year            / 년 수
-- minute_second   / ‘:’으로 구분된 분, 초
-- hour_second     / ‘:’으로 구분된 시, 분, 초
-- year_month      / ‘-’ 으로 구분된 년, 월

# ==================================================;

# last_day(date) : 해당월의 마지막 날짜 반환(날짜)
select last_day('2022-08-01');

# dayname(date) : 해당 날짜의 영어 요일 이름을 반환(문자열)
select dayname('2022-08-01');

# extract() : date의 구성 요소 중 일부를 추출(문자열)
# 기간 자료형으로 원하는 날짜 요소를 정의
select extract(year from '2019-09-18 22:19:05');

# datediff(date1, date2) : 두 날짜 사이의 기간(년, 주, 일)을 계산(숫자)
# 시간정보는 무시
select datediff('2019-09-03', '2019-06-21');

# ====================================================

# 변환 함수

# cast() : 데이터를 한 유형에서 다른 유형으로 변환할 때 사용
# 형태 : cast(데이터 as 타입)

select cast('1456328' as signed integer);
select cast('20220101' as date);
select cast(20220101 as char);
select cast(now() as signed);