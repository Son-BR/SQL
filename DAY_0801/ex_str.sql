-- Active: 1658998083382@@127.0.0.1@3306@testdb
# 데이터 생성, 조작과 변환

# ---------------------------------------------------------

# 문자열 데이터 처리

# =========================================================

# char
# 고정 길이 문자열 자료형
# 지정한 크기보다 문자열이 작으면 나머지 공간을 공백으로 채움
# MySQL 255글자

# varchar
# 가변 길이 문자열 자료형
# 크기만큼 데이터가 들어오지 않으면 그 크기에 맞춰 공간 할당
# 헤더에 길이 정보가 포함
# MySQL 최대 65,536 글자 허용

# text
# 매우 큰 가변 길이 문자열 저장
# MySQL: 최대 4 기가바이트 크기 문서 저장
# clob: 오라클 데이터베이스;

# =========================================================

# 테이블 생성

use testdb;

drop table if EXISTS string_tbl;

create table string_tbl 
(
char_fld char(30),
vchar_fld varchar(30),
text_fld text
);
# 문자열 데이터를 테이블에 추가
# 문자열의 길이가 해당 열의 최대 크기를 초과하면 예외 발생
insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This is char data',
'This is varchar data',
'This is text data');

# =========================================================

# varchar 문자열 처리
# update문으로 vchar_fld열 (varchar(30))에 설정 길이보다 더 긴 문자열 저장
# MySQL 6.0 이전 버전: 문자열을 최대 크기로 자르고 경고 발생
# MySQL 6.0 이후 기본 모드는 strict 모드로 예외 발생됨

# 예외 발생
update string_tbl
set vchar_fld = 'This is a piece of extremly long varchar data';

# =========================================================

# 작은 따옴표 포함
# 문자열 내부에 작은 따옴표를 포함하는 경우 (I’m, doesn’t 등 )

# escape 문자 추가

# 작은 따옴표 추가
update string_tbl
set text_fld = 'This string didn''t work, but it does now';

# 백슬래시(‘\’) 문자 추가
update string_tbl
set text_fld = 'This string didn\'t work, but it does now';

# 데이터 확인
select text_fld from string_tbl;

# quote() 내장 함수
# 전체 문자열을 따옴표로 묶고, 문자열 내의 작은 따옴표에 escape문자를 추가
select quote(text_fld)
from string_tbl;

# --------------------------------------------------------

# 문자열 조작

# ========================================================

# length() 함수 : 문자열의 개수를 반환

# 데이터 제거
delete from string_tbl;

# 새로운 데이터 추가
insert into string_tbl (char_fld, vchar_fld, text_fld)
values ('This string is 28 characters',
        'This string is 28 characters',
        'This string is 28 characters');

# char열의 길이: 빈 공간을 공백으로 채우지만, 조회할 때 char 데이터에서 공백 제거
select length(char_fld) as char_length,
length(vchar_fld) as varchar_length,
length(text_fld) as text_length
from string_tbl;

# ========================================================

# position() 함수 : 
# 부분 문자열의 위치를 반환 (MySQL의 문자열 인덱스: 1부터 시작)
# 부분 문자열을 찾을 수 없는 경우, 0을 반환

select position('characters' in vchar_fld)
from string_tbl;

# =========================================================

# locate(‘문자열’, 열이름, 시작위치) 함수
# 특정 위치의 문자부터 검색, 검색의 시작 위치 정의
select locate('is', vchar_fld, 5)
from string_tbl;

# =========================================================

# strcmp(‘문자열1’, ‘문자열2’) 함수 : string compare

# if 문자열1 < 문자열2, -1 반환
# if 문자열1 == 문자열2, 0 반환
# if 문자열1 > 문자열2, 1 반환
# '문자열1-문자열2'라고 생각 

# 기준:ASC코드값, 알파벳 대소문자 구분x

# 데이터 제거
delete from string_tbl;

# 새로운 데이터 추가
insert into string_tbl(vchar_fld)
values ('abcd'),
       ('xyz'),
       ('QRSTUV'),
       ('qrstuv'),
       ('12345');

# vchar_fld의 값을 오름 차순 정렬
select vchar_fld
from string_tbl
order by vchar_fld;

# strcmp() 예제 : 5개의 서로 다른 문자열 비교
select strcmp('12345', '12345') 12345_12345,
       strcmp('abcd', 'xyz') abcd_xyz,
       strcmp('abcd', 'QRSTUV') abcd_QRSTUV,
       strcmp('qrstuv', 'QRSTUV') qrstuv_QRSTUV,
       strcmp('12345', 'xyz') 12345_xyz,
       strcmp('xyz', 'qrstuv') xyz_qrstuv;

# =========================================================

# like 또는 regexp 연산자
# 0 또는 1의 값을 반환

use sakila;

# y로 끝나면 1을 반환

# like
select name, name like '%y' as ends_in_y
from category;

# 정규표현식(regexp)
select name, name REGEXP 'y$' ends_in_y
from category;

# =========================================================

use testdb;

# string_tbl 리셋
delete from string_tbl;

# 데이터 추가
insert into string_tbl (text_fld)
values ('This string was 29 characters');

# concat() 함수 : 문자열 추가 함수

# string_tbl의 text_fld열에 저장된 문자열 수정
# 기존 text_fld 문자열에 ', but now it is longer'문자열 추가
update string_tbl
set text_fld = concat(text_fld, ', but now it is longer');

# 데이터 확인
select text_fld from string_tbl;


# concat() 함수 활용

# 각 데이터 조각을 합쳐서 하나의 문자열 생성
# concat() 함수 내부에서 date(create_date)를 문자열로 변환

# use sakila;
# select concat(first_name, ' ', last_name,
# ' has been a customer since ', date(create_date)) as cust_narrative
# from customer;

# =========================================================

# insert(문자열, 시작위치, 길이, 새로운 문자열) 함수

select insert('goodbye world', 9, 0, 'cruel') as string;

select insert('goodbye world',1, 7, 'hello') as string;

# =========================================================

# replace(문자열, 기존문자열, 새로운 문자열) 함수
# 기존 문자열을 찾아서 제거하고, 새로운 문자열을 삽입
select replace('goodbye world', 'goodbye', 'hello') as replace_str;

# =========================================================

# substr(문자열, 시작위치, 개수) 함수
# 문자열에서 시작 위치에서 개수만큼 추출
select substr('goodbye cruel world', 9, 5);