/*
테이블 조인하기

    SELSCT *
    FROM 테이블1, 테이블2
    * 테이블의 조인은 조인 대상이되는 테이블의 이름을 FROM절에 나열하기만 하면된다.
    * 별도의 조건이 없으면 테이블1의 모든 행이 연결된 가상이 테이블이 생성된다.
    * (테이블1의 행의 갯수 + 테이블2의 행의 갯수) 만큼의 행이 조회된다.

2. 조인조건 지정하기
    
        SELECT *
        FORM 테이블1, 테이블2
        WHERE 테이블1.컬럼명 = 테이블2.컬럼명
        * 조인된 테이블의 모든 행에서 조인조건을 만족하는 행이 의미있게 연결된 행이다.
        * 조인조건을 지정하면 의미있게 연결된 행만 조회할 수 있다.
        * 조인조건의 갯수 = 조인된 테이블의 갯수 - 1
*/

-- REGIONS 테이블과 COUNTRIES 테이블 조인하기
-- ERGIONS 테이블의 모든 행과 COUNTRIES 테이블의 모든 행이 조인된다.
SELECT *
FROM REGIONS, COUNTRIES;

-- REGIONS 테이블과 COUNTRIES 테이블 조인하고, 서로 연관있는 행만 필터링하기
SELECT COUNTRIES.COUNTRY_ID,
       COUNTRIES.COUNTRY_NAME,
       REGIONS.REGION_NAME
FROM REGIONS, COUNTRIES
WHERE REGIONS.REGION_ID = COUNTRIES.REGION_ID;

-- 직원아이디, 직원이름, 직종아이디, 직종제목, 직종최소급여, 직종최대급여, 급여조회하기
-- E         E       E                                        E
--                   J        J        J           J
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.JOB_ID,
       J.JOB_TITLE,
       J.MIN_SALARY,
       J.MAX_SALARY,
       E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;

/*
등가 조인
    조인조건에서 EQUAL(=) 연산자를 사용한다.
    조인에 참여하는 테이블에서 같은 값을 사지고 있는 행끼리 조인한다.
    
    ORACLE 등가조인
    SELECT A.컬럼명,A.컬러명, B.컬럼명, B.컬럼명....
    FROM  테이블 A, 테이블 B
    WHERE A.컬럼명, JOIN B.컬렁명;
    
    ANSLS SQL 등가조인
    SELECT A.컬럼명,A.컬러명, B.컬럼명, B.컬럼명....
    FROM  테이블 A, JOIN 테이블 B
    ON A.컬럼명 = B.컬렁명;
*/

-- 직원 아이디, 직원이름, 소속부서아이디, 소속부서명을 조회하기
--  E         E       E              
--                    D            D

-- ORALCE의 등가조인
SELECT A.EMPLOYEE_ID, A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- ABSU SQL의 등가조인
SELECT A.EMPLOYEE_ID, A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A JOIN DEPARTMENTS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- 부서관리자가 지정된 부서의 부서아이디, 부서명, 부서관리자명(직원이름)을 조회하기
--                       D        D      D
--                                       E
SELECT A.DEPARTMENT_ID,
       A.DEPARTMENT_NAME,
       B.FIRST_NAME
FROM DEPARTMENTS A, EMPLOYEES B
WHERE A.MANAGER_ID IS NOT NULL
AND A.MANAGER_ID = B.EMPLOYEE_ID;

SELECT A.DEPARTMENT_ID,
       A.DEPARTMENT_NAME,
       B.FIRST_NAME
FROM DEPARTMENTS A JOIN EMPLOYEES B
ON A.MANAGER_ID = B.EMPLOYEE_ID
WHERE A.MANAGER_ID IS NOT NULL;

-- 직원아이디, 이름, 소속부서아이디, 소속부서명, 직종아이디, 직종제목, 급여를 조회하기
-- E         E    E                      E                 E
--                D            D        
--                                       J         J
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,
       E.JOB_ID, J.JOB_TITLE, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,
       E.JOB_ID, J.JOB_TITLE, E.SALARY
FROM EMPLOYEES E 
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID;

-- 직원아이디, 직원이름, 소속부서아이디, 부서명, 소재지아이디,근무지역도시명을 조회하기
-- E         E       E
--                   D            D      D
--                                       L          L
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
      -- B.DEPARTMNET_ID,
      -- B.DEPARTMNET_NAME,
      -- C.LOCATION_ID,
       C.CITY
FROM EMPLOYEES A, DEPARTMENTS B, LOCATIONS C
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND B.LOCATION_ID = C.LOCATION_ID;

/*
비동가조인용 샘플 테이블 추가
*/
CREATE TABLE SALARY_GRADES (
    GEADE CHAR(1) PRIMARY KEY,
    MIN_SALARY NUMBER(8,2),
    MAX_SALARY NUMBER(8,2)
);

INSERT INTO SALARY_GRADES VALUES('A', 0, 2499);
INSERT INTO SALARY_GRADES VALUES('B', 2500, 4999);
INSERT INTO SALARY_GRADES VALUES('C', 5000, 9999);
INSERT INTO SALARY_GRADES VALUES('D', 10000, 19999);
INSERT INTO SALARY_GRADES VALUES('E', 3, 39999);

- COMMIT
/*
비등가조인
    조인조건을 지정할 때 조인 대상테이블에서 같은 값을 가진 데이터를 가져오는 대신,
    크거나 작은 경우의 조건으로 데이터를 조회하는 조인 방식이 비등가 조인이다.
*/
-- 직원아이디, 직원이름, 급여,               급여등급을 조회하기
-- E         E       E
--                   G(최소/최대 급여)     G
SELECT A.EMPLOYEE_ID, 
       A.FIRST_NAME,
       A.SALARY,
       B.GRADE
FROM EMPLOYEES A, SALARY_GRADES B
WHERE A.SALARY >= M.MIN_SALARY
AND A.SALLARY <= B.MAX_SALARY;
ORDER BY A.EMPLOYEE_ID ASC;

--ANSL SQL
SELECT A.EMPLOYEE_ID, 
       A.FIRST_NAME,
       A.SALARY,
       B.GRADE
FROM EMPLOYEES A
JOIN SALARY_GRADES B
ON A.SALARY >= B.MIN_SALARY AND A.SALARY <= B.MAX_SALARY
ORDER BY A.EMPLOYEE_ID ASC;

/*
포괄조인

한쪽 테이블에만 데이터가 있고, 다른 쪽 테이블에 조인조건을 만족하는 데이터가 없는 경우,
조인에 참여하지 못하기 때문에 행당 행은 조회되지 않는다.
데이터가 없는 경우에도 데이터가 있는 쪽 테이블의 모든 행을 조회하는 조인방법이다.
모든 행을 조회하는 테이블의 반대쪽 조인조건에 포괄적인 기호(+)를 추가한다.
*/

-- 부서아이디, 부서이름, 부서관리자아이디, 부서관리자이름을 조회
-- D         D       D(MANAGE_ID)
--                   E(EMPLOYEE_ID) E(FIRST_NAME)
SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME, A.MANAGER_ID, B.FIRST_NAME
FROM DEPARTMENTS A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+);

-- 직원아이디, 직원이름, 소속부서아이디, 소속부서명 조회하기
-- E         E       E
--                   D            D
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       A.DEPARTMENT_ID,
       B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+); -- 전부나와야하는 쪽에다가 (+)집어넣기

-- ANSL SQL
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       A.DEPARTMENT_ID,
       B.DEPARTMENT_NAME
FROM EMPLOYEES A
LEFT OUTER JOIN DEPARTMENTS B           -- LEFT OUTER JOIN은 선행테이블의 모든 행을 조회한다.
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

----------------------------------------------------------
-- 급여가 12000을 넘는 직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 12000;
-- 급여가 5000이상 12000이하인 직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE 5000 <= SALARY 
AND SALARY <= 12000;
-- 2007년에 입사한 직원의 아이디, 이름, 입사일을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE '2007/01/01' <= HIRE_DATE
AND HIRE_DATE <= '2008/01/01';
-- 20번 혹은 50번 부서에 소속된 직원의 이름과 부서번호를 조회하고, 이름을 알파벳순으로 정렬해서 조회하기
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50)
ORDER BY FIRST_NAME ASC;
-- 급여가 5000이상 12000이하고, 20번 혹은 50번 부서에 소속된 사원의 이름과 급여, 부서번호를 조회하기
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 5000<= SALARY
AND SALARY <= 12000
AND DEPARTMENT_ID IN (20, 50);
-- 관리자가 없는 직원의 이름과 직종, 급여를 조회하기
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;
-- 직종이 'SA_MAN'이거나 'ST_MAN'인 직원중에서 급여를 8000이상 받는 직원의 아이디, 이름, 직종, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN('SA_MAN', 'ST_MAN')
AND SALARY >= 8000;

-- 모든 직원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
SELECT A.FIRST_NAME, 
       A.JOB_ID, 
       A.SALARY, 
       B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.MANAGER_ID = B.MANAGER_ID;

-- 모든 직원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
SELECT A.FIRST_NAME, 
       A.JOB_ID, 
       B.JOB_TITLE, 
       A.SALARY,
       B.MIN_SALARY,
       B.MAX_SALARY
FROM EMPLOYEES A ,JOBS B
WHERE A.JOB_ID = B.JOB_ID;
-- 모든 직원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
SELECT A.FIRST_NAME, 
       A.JOB_ID,
       B.JOB_TITLE,
       A.SALARY,
       A.SALARY - B.MIN_SALARY 급여차이
FROM EMPLOYEES A, JOBS B
WHERE A.JOB_ID = B.JOB_ID;
-- 커미션을 받는 모든 직원의 아이디,직원이름,부서이름, 소속부서의 소재지(도시명)을 조회하기
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       B.DEPARTMENT_NAME,
       C.LOCATION_ID
FROM EMPLOYEES A, DEPARTMENTS B, LOCATIONS C
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND B.LOCATION_ID = C.LOCATION_ID
AND COMMISSION_PCT IS NOT NULL;
-- 이름이 A나 a로 시작하는 모든 직원의 이름과 직종아이디, 직종제목, 급여, 소속부서명을 조회하기
SELECT A.FIRST_NAME,
       B.JOB_ID, 
       B.JOB_TITLE,
       A.SALARY,
       C.DEPARTMENT_NAME
FROM EMPLOYEES A, JOBS B, DEPARTMENTS C
WHERE A.JOB_ID = B.JOB_ID
AND A.DEPARTMENT_ID = C.DEPARTMENT_ID
AND FIRST_NAME LIKE 'A%';
-- 30, 60, 90번 부서에 소속되어 있는 직원들 중에서 100에게 보고하는 직원들의 이름, 직종아이디, 급여, 급여등급을 조회하기
SELECT A.FIRST_NAME,
       A.JOB_ID, 
       A.SALARY,
       B.GEADE
FROM EMPLOYEES A, SALARY_GRADES B, JOBS C
WHERE A.JOB_ID = C.JOB_ID
AND B.MIN_SALARY = C.MIN_SALARY
AND DEPARTMENT_ID IN(30,60,90);
-- 80번 부서에 소속된 직원들의 이름, 직종아이디, 직종제목, 급여, 급여등급, 소속부서명을 조회하기
SELECT A.FIRST_NAME,
       B.JOB_ID,
       B.JOB_TITLE,
       A.SALARY,
       C.GEADE,
       D.DEPARTMENT_NAME
FROM EMPLOYEES A, JOBS B, SALARY_GRADES C, DEPARTMENTS D
WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID
AND A.JOB_ID = B.JOB_ID
AND A.SALARY >= C.MIN_SALARY AND A.SALARY <= C.MAX_SALARY
AND A.DEPARTMENT_ID = 80;
-- 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 직원의 아이디, 이름, 변경전 부서명, 현재 직종아이디, 현재 근무부서명을 조회하기
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       H.JOB_ID              AS 이전직종,
       E.JOB_ID              AS 현재직종,
       D1.DEPARTMENT_NAME    AS 이전부서명,   
       D2.DEPARTMENT_NAME    AS 현재부서명
FROM JOB_HISTORY H,            -- 직종변경이력정보(예전직종, 이전소속부서아이디)
     EMPLOYEES E,              -- 직원정보(현재직종, 현재소속부서아이디)
     DEPARTMENTS D1,            -- 예전소속부서정보
     DEPARTMENTS D2             -- 현재소속부서정보
WHERE H.JOB_ID = 'ST_CLERK'
AND H.EMPLOYEE_ID = E.EMPLOYEE_ID
AND H.DEPARTMENT_ID = D1.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D2.DEPARTMENT_ID;