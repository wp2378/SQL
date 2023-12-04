/*
    테이블의 데이터 조회
    
    1. 지정된 테이블의 모든 행, 모든 열을 조회한다.
        select*
        form 테이블명;
        
    2. 지정된 테이블의 모든 행, 지정된 열을 조회하기
        select 컬럼명,컬럼명,컬럼명...
        form 테이블명;

    3. select절에서 사칙연산을 수행할 수 있다.
    select 컬럼명 + 숫자, 컬럼명+컬럼명 ...
    from 테이블명;
    * 사칙연산에 사용되는 컬럼은 해당 컬럼의 값이 숫자값이어야한다.
    
    4. 컬럼에 별칭(alias) 부여하기
    select 컬럼명 as 별칭, 컬럼명 as 별칭, ...
    from 테이블명;
    
    select 컬럼명 별칭, 컬럼명 별칭, 컬럼명 별칭, ...
    from 테이블명;
    
*/

-- 지역 테이블의 모든 행, 모든 열 조회하기
SELECT *
from regions;

-- 국가 테이블의 모든 행, 모든 열 조회하기
select *
from countries;

-- 직종 테이블의 모든 행, 모든 열 조회하기
select *
from jobs;

-- 부서 테이블의 모든 행, 모든 열 조회하기
select * 
from departments;

-- 직원 테이블의 모든 행, 모든 열 조회하기
SELECT *
from employees;

-- 직종 테이블에서 직종 아이디, 최소급여, 최대급여 조회하기
SELECT job_id, min_salary, max_salary
from jobs;

-- 직원 테이블에서 직원아이디, 직원이름(first_name), 급여를 조회하기
select EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES;

-- 소재지 테이블에서 소재지 아이디, 주소, 도시명을 조회하기
select location_id, street_address, city
from locations;

-- 직원 테이블에서 직원아이디, 직원이름, 급여, 연봉을 조회하기
-- 연봉은 급여*12로 계산한다.
select employee_id, first_name, salary, salary*12
from employees;

-- 직원 테이블에서 직원아이디, 직원이름, 급여, 연봉을 조회하기
-- 연봉은 급여*12로 계산한다.
-- 연봉의 별칭은 annual_salary다.
select employee_id, first_name, salary, salary*12 as annual_salary
from employees;

-- 직종 테이블에서 직종아이디, 최고급여, 최저급여, 최고급여와 최저급여의 차이를 조회하기
-- 최고급여와 최저급여의 차이는 salary_gap 별칭을 부여한다.
select job_id, max_salary, min_salary, max_salary - min_salary as salary_gap
from jobs;

/*

    데이터 필터링하기
    
    1. where절에 조건식을 작성해서 해당 조건식을 만족시키는 행만 조회하기
    select 컬럼명, 컬럼명, 컬럼명, ...
    from 테이블명
    where 조건식;
    
    2. WHERE절에서 2개 이상의 조건식으로 데이터를 필터링할 수 있다.
    2개 이상의 조건식을 작성할때는 and, or, not 논리 연산자를 사용한다.
    select 컬럼명, 컬럼명, 컬럼명, ...
    from 테이블명
    where 조건식1 and 조건식2;
    * 조건식1과 조건식2가 모두 true로 판정되는 행만 조회된다.
    
    select 컬럼명, 컬럼명, 컬럼명, ...
    from 테이블명
    where 조건식1 or 조건식2;
    * 조건식1과 조건식2 중에서 하나라도 true로 판정되는 행만 조회된다.
    
    select 컬럼명, 컬럼명, 컬럼명, ...
    from 테이블명
    where 조건식1 and (조건식2 or 조건식3);
    * and 연산자와 or 연산자를 같이 사용할 때는 or 연산식을 괄호로 묶는다.
*/

-- 직원 테이블에서 소속부서 아이디가 60번이 직원의 아이디, 이름, 직종아이디를 조회하기
SELECT employee_id, first_name, job_id
from employees
WHERE department_id = 60;

-- 직원테이블에서 급여를 10000달러 이상 받는 아이디, 이름, 직종아이디, 급여를 조회하기
SELECT employee_id, first_name, job_id, salary
from employees
where salary >= 10000;

-- 직원 테이블에서 직종아이디가 'SA_MAN'인 아이디, 이름, 급여, 소속부서 아이디 조회하기
SELECT EMPLOYEE_ID, first_name, SALARY, DEPARTMENT_ID
FROM employees
WHERE JOB_ID = 'SA_MAN';

-- 직원 테이블에서 급여가 5000 ~10000 범위에 속하는 직원아이디, 이름, 직종아이디, 급여를 조회하기
-- 급여가 5000이상, 10000이하로 받는 직원을 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary >= 5000 and salary <= 10000; 

-- 직원 테이블에서 10번 부서, 20번 부서, 30번 부서에서 근무하는 직원 아이디, 이름 ,부서아이디를 조회하기
select employee_id, first_name, department_id
from employees
where department_id = 10 or department_id = 20 or department_id = 30;

-------------------------------------------
-- 부서테이블의 모든 부서 정보를 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS;

-- 부서테이블에서 소재지아이디가 1700번인 부서 정보 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM departments
WHERE location_id = 1700;

-- 100번 직원이 관리하는 부서정보 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE MANAGER_ID = 100;


-- 부서명이 'IT'인 부서의 정보 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

-- 소재지아이디가 1700번인 지역의 주소, 우편번호, 도시명, 국가코드를 조회하기
SELECT STREET_ADDRESS, POSTAL_CODE, CITY, COUNTRY_ID
FROM LOCATIONS
WHERE LOCATION_ID = 1700;

-- 최소급여가 2000이상 5000이하인 직종의 직종아이디, 직종제목, 최소급여, 최대급여 조회하기
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE 2000 <= MIN_SALARY AND 5000 >= MAX_SALARY;

-- 최대급여가 200000불을 초과하는 직종의 아이디, 직종제목, 최소급여, 최대급여 조회하기
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE max_salary > 20000;

-- 100번째 직원에게 보고하는 직원의 아이디, 이름, 부서아이디를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM employees
WHERE manager_id = 100;

-- 80번 부서에서 근무하고 급여를 8000불 이상 받는 직원의 아이디, 이름, 급여, 커미션포인트 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE department_id = 80 AND salary > 8000; -- 오답 SALARY >= 8000;


-- 직종아이디가 'SA_REP'이고, 커미션 포인트가 0.25이상인 직원의 아이디, 이름, 급여, 커미션포인트를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE JOB_ID = 'SA_REP' AND commission_pct > 0.25;

-- 80번 부서에 근무하고, 급여가 10000불 이상인 직원의 아이디, 이름, 급여, 연봉을 조회하기
-- 연봉 = (급여+급여*커미션)*12다
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, (salary + salary * commission_pct)*12 AS 연봉
FROM employees
WHERE department_id = 80 AND salary >10000;

-- 80번 부서에 근무하고, 147번 직원에게 보고하는 사원중에서 커미션이 0.1인 
-- 직원의 아이디, 이름, 직종, 급여, 커미션 포인트를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, COMMISSION_PCT
FROM EMPLOYEES
WHERE department_id = 80 
AND manager_id = 147; 
-- 오답 AND COMMISSION_PCT = 0.1;


