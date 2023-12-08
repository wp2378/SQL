/*
문자 함수

LOWER(컬럼 혹은 표현식) : 소문자로 변환된 문자를 반환한다
UPPER(컬럼 혹은 표현식) : 대문자로 변환된 문자르 반환한다.

CONCAT(컬럼 혹은 표현식, 컬럼 혹은 표현식) : 두 문자열을 연결해서 반환한다.

LENGTH(컬럼 혹은 표현식) : 문자열의 길이를 반환한다.

SUBSTR(컬럼 혹은 표현식, 시작위치, 길이) : 문자열을 시작위치부터 길이만큼 잘라서 반환한다.
                                     시작위치는 1부터 시작한다.
                                     
INSTR(컬럼 혹은 표현식, 문자열) : 지점된 문자열이 등장위치를 반환한다.

TRIN(컬럼 혹은 표현식) : 불필요한 좌우 여백이 제거된 문자열을 반환한다.

LPAD(컬럼 혹은 표현식, 길이, 문자) : 컬럼 혹은 표현식의 길이가 지정된 길이보다
                                짧으면 부족한 길이만큼 왼쪽에 지정된 문자가 채워진 문자열이 반환된다.
*/

-- 60에 부서에 소속된 직원들의 이름을 소문자, 대문자로 조회하기
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--60번 부서에 소속된 직원들의 FIRST_NAME과 LAST_NAME을 연결해서 조회하기
SELECT CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 60번 부서에 소속된 직원들의 FIRST_NAME과 LAST_NAME을 연결해서 조회하기
SELECT FIRST_NAME ||  ' ' || LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--60번 부서에 소속되 직원들의 이름과 이름의 길이를 조회하기
SELECT FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 이름이 6글자 이상인 모든 직원들의 직원아이디와 이름을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 6;

-- SAMPLE_BOOKS에서 저자이름을 조회하고, 이름의 첫번째 글자도 조회하기
SELECT BOOK_WRITER, SUBSTR(BOOK_WRITER,1 1)
FROM SAMPLE_BOOK;

-- 전화번호에서 국번만 조회하기
SELECT SUBSTR('22)1234-5678', 1, INSTR('031}1234-5678', ')') -1)
FROM DUAL;

-- DUAL은 오라클에서 제고하는 DUMMY 테이블이다.
-- DUAL은 1행 1열짜리 테이블이다.
-- 실제 테이블 조회없이 간단한 연산을 수행할 때 이용한다.
SELECT *
FROM DUAL;

SELECT TRIM('       HELLO WORLD!       ')
FROM DUAL;

-- 불필요한 좌우 여백이 제거된 문자열을 조회하기
SELECT TRIM('           HELLO WORLD!    ')
FROM DUAL;

-- 지정된 길이만큼 문자열의 왼쪽에 '0'을 채워서 조회하기
SELECT LPAD('100', 10, '0')
FROM DUAL;

/*
숫자 함수

ROUND(컬럼 혹은 표현식, 자리수) : 지정된 자리수까지 반올리한다.

TRUNC(컬럼 혹은 표현식, 자리수) : 지정된 자리수까지 남기고 전부 버린다.

MOD(숫자1, 숫자2) : 나머지 값을 반환한다.

ABS(컬럼 혹은 표현식) : 절대값을 반환한다.

CELL(컬럼 혹은 표현식) : 지정된 값보다 크거나 같은 정수 중에서 가장 작은 정수를 반환한다.
FLOOR(컬럼 혹은 표현식) : 지정된 값보다 작거나 같은 정수 중에서 가장 큰 정수를 반환한다.
*/

SELECT ROUND(1234.5678),
       ROUND(1234.5678, 3),
       ROUND(1234.5678, 2),
       ROUND(1234.5678, 1),
       ROUND(1234.5678, 0),
       ROUND(1234.5678, -1),
       ROUND(1234.5678, -2),
       ROUND(1234.5678, -3)
FROM DUAL;    

SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 3),
       TRUNC(1234.5678, 2),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, -1),
       TRUNC(1234.5678, -2),
       TRUNC(1234.5678, -3)
FROM DUAL;  

-- 80번 부서에 소속된 직원의 아이디, 이름, 금여, 급여에 해단 #을 출력하기
--'#' 하나는 1000달러를 나타낸다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD('#', TRUNC(SALARY/10000), '#')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

SELECT MOD(10,4), ABS(-10)
FROM DUAL;

SELECT CEIL(1), CEIL(1.1), CEIL(1.5), CEIL(1.9), CEIL(2)
FROM DUAL;

SELECT FLOOR(1), FLOOR(1.1), FLOOR(1.5), FLOOR(1.9), FLOOR(2)
FROM DUAL;

/*
날짜 함수

SYSDATE : 시스템의 현재 일자와 시간을 DATE타입으로 반환한다.
          * 데이터가 추가될 때, 데이터가 변경될 때 시스템의 현재 날짜와 시간정보를 저장하는 용도로 활용됩니다.
SYSTIMESTAMP : 시스템의 현재 일자와 시간을 TIMESTAMP 타입으로 반환한다.

ADD_MONTHS(날짜, 숫자) : 날짜에 지정된 숫자만큼의 월을 더한 날짜를 반환한다.

EXTRACT(포맷 FROM 날짜) : 날짜에서 형식에 해당하는 값을 반환한다.
                        형식 : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
                        
LAST_DAY(날짜) : 지정된 날짜를 기준으로 해당 월의 마지막 일자를 반환한다.

NEXT_DAY(날짜, 요일) : 지정된 날짜를 기준으로 앞으로 다가올 날짜중에서 지정된 요일에 해당하는 날짜를 반환한다.

MONTHS_BEWTEEN(날짜, 날짜) : 두 날짜 사이의 개월수를 반환한다.

// 일수 관련 연산
날자 + 숫자 = 숫자만큼 일자가 경과된 날자를 반환한다.
날짜 - 숫자 = 숫자만큼 이전 날짜를 반환한다.
날짜 - 날짜 = 두 날짜사이의 일수를 반환한다.
날짜 + 1/24 = 1시간 이후의 날짜를 반환한다.

TRUNC(날짜) : 지정된 날짜의 모든 시간 정보를 0시0분0초로 바꾼 날짜가 반환된다.
ROUND(날짜) : 지정된 날짜의 시간정보를 정오(오후12시)를 지나기 전이면 해당날짜가 
                                 정오를 지났으면 하루 증가된 날짜가 반환된다.
                                 시간정보는 0시 0분 0초다.
*/

-- 시스템의 현재 일자와 시간을 DATE, TIMESTAMP 형으로 조회하기
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE,                 -- 오늘
    ADD_MONTHS(SYSDATE, 1),     -- 1달 후
    ADD_MONTHS(SYSDATE, 2),     -- 2달 후
    ADD_MONTHS(SYSDATE, 3)      -- 3달 후
FROM DUAL;

-- 오늘이 12월31일 이라고 가정하고, 2달후의 날짜를 조회하면 2월28일 혹은 2월29일이 반환된다.
SELECT ADD_MONTHS('2023/12/31', 2) FORM DUAL;

-- 시스템의 현재 일자와 시간 정보에서 년, 월, 일, 시, 분, 초 조회하기
SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE),
       EXTRACT(HOUR FROM SYSTIMESTAMP),
       EXTRACT(MINUTE FROM SYSTIMESTAMP),
       EXTRACT(SECOND FROM SYSTIMESTAMP)
FROM DUAL;

-- 현재 일자가 속한 월의 마지막 일자 조회하기
SELECT LAST_DAY(SYSDATE),
       LAST_DAY('2024/01/01'),
       LAST_DAY('2024/02/01')
FROM DUAL;

-- 현재 일자를 기준으로 다음 월요일을 조회하기
SELECT NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;

-- 현재 일자와 지정된 날짜 사이이 개월 수를 조회하기
SELECT MONTHS_BETWEEN(SYSDATE, '2023/06/01')
       TRUNC(MONTHS_BETWEEN(SYSDATEM '2023/06/01')
FROM DUAL;

-- 현재 일자를 기준으로 7일전, 3일전, 3일 후, 7일 후 날짜를 조회하기
SELECT SYSDATE - 7,
       SYSDATE - 3,
       SYSDATE + 3,
       SYSDATE + 7
FORM DUAL;

-- 지정된 날짜를 기준으로 7일전의 날짜를 조회하기
SELECT TP_DATE('2023/12/01'), TRUNC(TO_DATE('2023/12/01')) - 7
FROM DUAL;

-- 지정된 날짜를 기준으로 1달전, 1달 후의 날짜를 조회하기
SELECT ADD_MONTHS(TO_DATE('2023/12/01'), - 1),
       ADD_MONTHS(TO_DATE('2023/12/01'), 1)
FROM DUAL;

-- 오늘 기준으로 7일전의 날짜를 조회하기
SELECT TRUNC(SYSDATE) - 7
FROM DUAL;

-- 오늘 기준으로 1달전의 날짜를 조회하기
SELECT ADD_MONTHS(TRUNC(SYSDATE), - 1)
FROM DUAL;

-- 오늘 기준으로 7일동안의 주문내역을 조회하기(오늘은 포함되지 않음)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= TRUNC(SYSDATE) - 3 AND TRUNC(SYSDATE) < TRUNC(SYSDATE);

-- 오늘기준으로 1개월동안의 주문내역을 조회하기(오늘은 포함되지 않음)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= ADD_MONTHS(TRUNC(SYSDATE), -1) AND TRUNC(SYSDATE) < TRUNC(SYSDATE);


SELECT SYSDATE,
       SYSDATE + 1/24,  -- 1시간 후
       SYSDATE + 3/24,  -- 3시간 후
       SYSDATE + 6/24   -- 6시간 후
FROM DUAL;

/*
변환함수

묵시적 변환
    변환함수를 사용하지 않아도 데이터의 타입이 자동으로 변하는 것이다.
    '문자' -> 날짜 : '문자'가 유효한 날짜 형식의 문자인 경우 날짜로 변경된다.
    '문자' -> 숫자 : '문자'가 숫자로만 구성되어 있으면 숫자로 변경된다.
    
    SELECT *
    FROM EMPLOOYEES
    WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE < '2005/07/01';
    * 위의 SQL에서  HIRE_DATE가 DATE타입의 컬럼이기 때문에 '2005/01/01'문자가 DATE타입의 값으로 자동으로 변환된다.
    * '2005/01/01'이나 '2005-01-01'의 형식인 경우 자동으로 변환된다.
    
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = '10';
     * 위의 SQL문에서 DEPARTMENT_ID가 NUMBER타입의 컬럼이기 때분에'10'문자가 NUMBER타입의 값으로 자동으로 변환된다.
명시적 변환
    변환함수를 사용해서 '문자' <-->날짜, '문자'<-->숫자 간의 데이터변환을 하는 것이다.
    
    TO_DATE('날짜형식의 문자열', '패턴')
    예) TO_DATE('2023/01/01')
        * 문자열이 날짜형식의 텍스트이기 때문에 패턴을 지정하지 않아도 DATE타입으로 변환된다.
        TO_DATE('20230101, 'YYYYMMDD')
        * 문자열이 일반적이니 날짜 형식이 아닌 경우에는 패턴을 지정해야 한다.
    TO_CHAR(날짜, '표맷')
        날짜를 지정된 포맷형식의 텍스트를 변환한다.
        날짜 변환 형식
            AM          *오전*
            PM          *오후*
            YYYY, YY    *2022*
            MM          월
            D           1~7 (1:일요일, 7:토요일)
            DAY         요일
            DD          1~31
            HH          12시간제 시간
            HH24        24시간제 시간
            MI          분
            SS          초
         * 날짜 변환 형식은 대소문자를 구분하지 않는다.   
*/

-- 문자를 날짜로 변환하기
SELECT TO_DATE('2023/01/01'),
       TO_DATE('20230101'),
       TO_DATE('2023 01 01'),
       TO_DATE('2023/01/01 22:41:10', 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;

-- 날짜를 문자로 변환하기
SELECT TO_CHAR(SYSDATE, 'YYYY'),    -- 124 AS AAAAAAAAAAAAAAAAAAA 문자는 앞에서부터 출력, 숫자는 뒤에서부터 출력하기에 2023은 문자인것을 알수있다
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'AM'),
       TO_CHAR(SYSDATE, 'HH'),
       TO_CHAR(SYSDATE, 'HH24')
FROM DUAL;

-- 직원테이블에서 2005년도 입사한 직원의 아이디, 이름, 입사일자를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005';

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-01-01' AND HIRE_DATE < '2006-01-01';

-- 숫자를 ,가 포함된 문자로 변환한다.
SELECT TO_CHAR(100000, '999,999')
FROM DUAL;

-- 문자를 숫자로 변환한다.
SELECT TO_NUMBER('10000'), TO_NUMBER('100,000', '999,999')
FROM DUAL;












