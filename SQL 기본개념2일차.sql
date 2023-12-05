/*
    중복된 행을 제거하고 한번만 조회하기
    select distinct 컬럼명, 컬럼명 ...
    form 테이블명
    * 지정된 컬럼들의 값이 서로 같은 값을 가지는 행이 한번만 조회된다.
*/

-- 직원테이블에서 직원들이 종사하는 직종아이디 조회하기
SELECT DISTINCT JOB_ID             -- DISTEINCT 중복된 값을 제외하고 화면에 출력하기
FROM EMPLOYEES;

-- 직종변경이력 테이블에서 직종을 한번이라도 변경한 적이 있는 직원의 아이디 조회하기
SELECT DISTINCT EMPLOYEE_ID        -- DISTEINCT 중복된 값을 제외하고 화면에 출력하기
FROM job_history;

/*
    조회결과를 정렬하기
    SELECT 컬럼명, 컬러명, 컬럼명, ...
    FROM 테이블명
    [WHERE 조건식]
    [ORDER BY {컬럼명|표현식} [ASC|DESC]]
    * ORDER BY절을 사용하면 조회결과를 오름차순 혹은 내림차순으로 정렬할 수 있다.
    * ORDER BY절에 컬럼명이 오면 해당 컬럼의 값을 기준으로 행들을 오름차순 혹은 내림차순으로 정렬한다.
    * 정렬방향은 ASC 혹은 DESC로 결정한다 생략하면 ASC(오름차순)이다.
    ASC 오름차순   DESC 내림차순
    
    여러 컬럼의 값을 기준으로 정렬하기 
    SELECT 컬럼명, 컬러명, 컬럼명, ...
    FROM 테이블명
    [WHERE 조건식]
    [ORDER BY {컬럼명|표현식} [ASC|DESC], {컬럼명|표현식} [ASC|DESC]]
*/

-- 직원테이블에서 직원아이디, 이름, 급여를 조회하고, 급여순으로 내림차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;       -- 내림차순이니깐 DESC

-- 직원테이블에서 60번 부서에 소속된 직원들의 아이디, 이름, 급여를 조회하고,급여순으로 오름차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE department_id = 60
ORDER BY salary ASC;        -- 오름차순이니깐 ASC

-- 직원테이블에서 50번 부서에 소속된 직원들의 직원아이디, 이름, 입사일, 급여를 조회하고 입사일을 기준으로
-- 오름차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE department_id = 50
ORDER BY HIRE_DATE ASC;     -- 오름차순이니깐 ASC

-- 직원테이블에서 직원들의 직원아이디, 이름, 급여, 부서아이디을 조회하고, 부서아이디를 기준으로 오름차순 정렬하고,
-- 부서아이디가 동일한 직원들은 급여를 기준으로 내림차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY department_id ASC, SALARY DESC;

/*
    WHERE절의 조건식에서 다양한 연산자 사용하기
    
    1. 비교연산자
        =, !=, >, <, >=, <=
        * 오라클에서 not equal을 나타내는 연산자는 !=과 <>을 사용할 수 있다.
    2. 논리연산자
        AND, OR, NOT
    3. 기타 연산자
        BETWEEN 값1 AND 값2
        
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 BETWEEN 값1 AND 값2;
        * WHERE절에 지정된 컬럼의 값이 값1보다 이상, 값2 이하인 것을 조죄하기
        * WHERE 컬럼명 BETWEEN 값1 AND 값2
          WHERE 컬럼명 >= 값1 AND 컬럼명 <= 값2
          위의 두 조건은 동일하다.
          
       IN (값1, 값2, 값3, ...)
          
       SELECT 컬럼명, 컬럼명, 컬럼명, ...
       FROM 테이블명
       WHERE 컬럼명 IN (값1, 값2, 값3, ...);
       * WHERE절에서 지정된 컬럼의 값이 값1, 값2, 값3 중 하나와 일치하면 조회한다.
       * WHERE 컬럼명 IN (값1, 값2, 값3, ...)
         WHERE 컬럼명 = 값1 OR 컬럼명 = 값2 OR 컬럼명 = 값3
        위의 두 조건은 동일하다.
        
        IS NULL 과 IS NOT NULL
        
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 IN NULL;
        + WHERE절에서 지정된 컬럼의 값이 NULL인 행을 조회한다.
        
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 IN NOT NULL;
        + WHERE절에서 지정된 컬럼의 값이 NULLDL이 아닌 행을 조회한다.
        
        LIKE '패턴'
        
        패턴문자
            '%'     0개 이상의 임의의 문자를 나타낸다.
            '_'     임의의 문자 하나를 나타낸다.
            
            제목이 '자바'로 시작하는 도서를 조회하기
                WHERE BOOK_TITLE LIKE '자바%'
                * '자바', '자바의 정석', '자바 프로그래밍'는 전부 위의 패턴과 일치한다.
            제목이 '자바'로 끝나는 도서를 조회하기
                WHERE BOOK_TITLE LIKE '%자바'
                * '자바','일주일만에 끝내는 자바', '이펙티브 자바'는 전부 위의 패턴과 일치한다.
            제목에 '자바'가 포함되어 있는 도서를 조회하기
                WHERE BOOK_TITLE LIKE '%자바%'
                * '자바', '자바의 정석', '이것이 자바다', '이펙티브 자바'는 전부 위의 패턴과 일치한다.
                
            성씨가 '김'씨인 고객을 조회하기
                WHERE NAME LIKE '김_%'
                * '김'은 위의 패턴과 일치하지 않는다.
                * '김구','김유신','김수한무거북이와두루미'는 전부 위의 패턴과 일치한다.
            '김'씨고 이름이 외자인 고객을 조회하기
                WHERE NAME LIKE '김_' 
            '김'씨고 이름이 2글자인 고객을 조회하기
                WHERE NAME LIKE '김__' 
        
*/

-- 직원테이블에서 급여가 3000이상 5000이하인 직원의 아이디, 이름, 직종아이디, 급여를 조회하고,
-- 급여순으로 오름참순 정렬하기
SELECT EMPLOYEE_ID, FRIST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY BETWEEN 3000 AND 5000
ORDER BY SALARY ASC;

-- 직원테이블에서 2005년도에 입사한 직원의 아이디, 이름, 입사일을 조회하고, 입사일순으로 오름차순 정렬하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005/01/01' AND '2005/12/31'
ORDER BY hire_date ASC;

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY hire_date ASC;

-- 직원테이블에서 소속부서가 10번 이거나 20번이거나 30번고 급여를 3000이하로 받는 
--직원의 아이디, 이름, 급여, 소속부서아이디 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, salary, DEPARTMENT_ID
FROM employees
WHERE department_id IN (10,20,30)
AND SALARY <= 3000;

-- 부서테이블에서 관리자가 저장되어있지 않은 부서아이디아 부서이름을 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM departments
WHERE manager_id IS NULL;

-- 부서테이블에서 관리자가 지정된 부서의 아이디와 이름을 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, manager_id
FROM DEPARTMENTS
WHERE manager_id IS NOT NULL;

-- 직원테이블에서 소속부서가 결정되지 않은 직원의 아이디, 이름, 직종을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- 직원테이블에서 직종아이디가 'SA'로 시작하는 직원의 아이디, 이름, 직종아이디를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';

-------------------------------------------

-- 직원들이 수행하는 직종 아이디를 중복없이 전부 조회하기
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- 다른 직원들에게 보고 받는 매니저들의 아이디를 중복없이 전부 조회하기
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;


-- 보고할 상사없는 직원의 아이디, 이름, 직위를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE manager_id IS NULL;

-- 커미션을 받는 직원들 중에서 급여를 10000달러 이상 받는 직원의 아이디, 이름, 급여, 커미션을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE commission_pct IS NOT NULL
AND SALARY >= 10000;

-- 2004년도에 직종이 변경된 직원의 아이디, 해당 직종의 업무 시작일, 종료일, 직종아이디를 조회하기
SELECT EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID
FROM JOB_HISTORY
WHERE START_DATE BETWEEN '2004-01-01' AND '2004-12-31';

-- 한번이라도 직종이 변경된 적이 있는 직원들의 직원 아이디를 중복없이 조회하기
SELECT DISTINCT EMPLOYEE_ID        -- DISTEINCT 중복된 값을 제외하고 화면에 출력하기
FROM job_history;

-- 직원 중에서 100번 상사에게 보고하고, 커미션을 받으며, 급여를 10000달러 이상 받는 직원의 아이디, 이름, 직종아이디, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = 100 
AND COMMISSION_PCT IS NOT NULL;
--AND SALARY >= 10000                -- 이거빼먹었음 ㅇㅇ

-- 직원 중에서 2006년 상반기에 입사한 직원의 아이디, 이름, 입사일을 조회하고, 입사일 순으로 오름차순 정렬하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006-01-01' AND '2006-06-30'   
-- WHWER HIRE DATE >= '2006-01-01' AND HIRE_DATE , '2006-07-01'
ORDER BY HIRE_DATE ASC;

-- 직원 중에서 소속부서가 50, 60, 80번 부서 중의 하나에 속하고, 100번 직원에게 보고하는 직원의 아이디, 이름, 직종아이디, 부서아이디를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50,60,80) AND MANAGER_ID = 100;

-- 직원 중에서 직종아이디가  'CLERK'로 끝나고, 급여를 2000불 이상 받는 직원의 아이디, 이름, 급여, 직종아이디를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%CLERK' AND SALARY >= 2000;

-- 부서 소재지 정보에서 일본에 위치하고 있는 소재지의 아이디, 주소, 우편번호, 도시명을 조회하기
SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY
FROM LOCATIONS
WHERE COUNTRY_ID = 'JP';

-- 부서 소재지 정보에서 우편번호가 누락된 소재지의 아이디, 주소, 도시명을 조회하기
SELECT location_id, street_address, city 
FROM LOCATIONS
WHERE postal_code is null;

-- 직원 중에서 이름이 'S'로 시작하는 직원의 아이디, 이름을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';

-- 50번 부서의 소속된 직원들의 직원아이디, 이름, 급여를 조회하고 급여순으로 오름차순 정렬하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY SALARY ASC;



