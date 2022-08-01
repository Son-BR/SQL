/*  
 * 과제 2. 노벨상 수상자
 */

use sqlclass_db;

select * from nobel;

# 1번. 1960년 Physics와 Peace 노벨 수상자 출력 
SELECT year, subject, winner
  FROM nobel
 WHERE year = 1960 AND (subject = 'Physics' or  subject='Peace');


# 2번. Albert Einstein이 수상한 연도와 제목 
SELECT year, subject
  FROM nobel
WHERE winner = 'Albert Einstein';

# 3번. 1910~1950년까지 노벨평화상 수상자 명단 
select year, winner 
from nobel 
where subject='Peace' and year between 1910 and 1950;

# 4번. 노벨상 수상자 중에서 'John'으로 시작하는 수상자 명단 
SELECT subject, winner FROM nobel
  WHERE winner LIKE 'John%';
 
# 5번. 1964년 수상자 중에서 노벨화학상과 의학상을 제외한 수상자 정보 출력 
# 이름을 기준으로 오름차순 정렬  

 SELECT * FROM nobel
  WHERE year = 1964
    AND subject NOT IN ('Chemistry','Medicine')
  order by winner asc;

# 6번. 1910년부터 1960년까지 노벨 문학상 수상자 출력 
SELECT * FROM nobel
  WHERE subject = 'Literature' and (year between 1910 and 1960);
 

 # 7번. 각 분야별 역대 수상자 수를 출력 
 select subject, count(subject) from nobel 
 group by subject order by count(subject) desc;

# 8번. 노벨 의학상이 없었던 연도 출력 
select DISTINCT year FROM nobel WHERE subject = 'Medicine';

SELECT year FROM nobel
WHERE year 
NOT IN (SELECT DISTINCT year FROM nobel WHERE subject = 'Medicine');

# 9번. 노벨 의학상이 없었던 연도의 횟수 출력 
SELECT count(distinct year) as no_medicine_count FROM nobel
WHERE year 
NOT IN (SELECT DISTINCT year FROM nobel WHERE subject = 'Medicine');
 