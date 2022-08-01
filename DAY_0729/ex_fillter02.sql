# 필터링

# --------------------------------------------------------------

# 조건평가

# where절
# and 또는 or 연산자로 하나 이상의 조건을 포함

# and : 모든 조건이 true
# where fist_name = 'STEVE' and create_date > '2006-01-01'

# or: 조건 중 하나만 true이면, 해당 조건은 true
# where fist_name = 'STEVE' or create_date > '2006-01-01'

# 괄호 사용
# 여러 개의 조건을 포함하는 경우, 괄호를 써서 의도를 명확히 표현
# where (first_name = 'STEVE' or last_name = 'YOUNG') and create_date > '2006-01-01'

# not 연산자
# where not (first_name = 'STEVE' or last_name = 'YOUNG') and create_date > '2006-01-01
 
# not 연산자로 <> 사용
# where first_name <> 'STEVE' and last_name <> 'YOUNG' and create_date > '2006-01-01'

# --------------------------------------------------------------

# 조건 작성

# 하나 이상의 연산자와 결합된 표현식으로 구성
 
# 표현식
# 숫자, 테이블 또는 뷰의 열, 문자열, concat()과 같은 내장 함수,
# 서브 쿼리,(‘Boston'’', '’'New York‘, ‘Chicago'’')와 같은 표현식 목록

# 조건 연산자
 # 비교 연산자: =, !=, <, >, <>, like, in, between
 # 산술 연산자: +, -, *, /

# --------------------------------------------------------------