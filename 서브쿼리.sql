/*
서브쿼리의 구분
    - 단일행 서브쿼리
        서브쿼리 실행결과로 한 행이 획득된다.(1행1열 데이터를 반환하는 서브쿼리)
        연산자
            =, !=, >=, >, <, <=, IN
    - 다중행 서브쿼리
        서브쿼리 실행결과로 여러 행이 획득된다.(N행1열 데이터를 반환하는 서브쿼리)
            IN, NOT IN, > ANT, >ALL, >= ANY, >=ALL,
                        < ANY, <ALL, <= ANY, <=ALL
    - 다중열 서브쿼리
        서브쿼리 실행결과로 여러 개의 컬럼값이 획득된다.(N행N열 데이터를 반환하는 서브쿼리)
        연산자
            IN, NOT IN
*/  

-- 단일행 서브쿼리
-- 'Neena'에게 보고받는 상사와 같은 상사에게 보고하는 직원의 아이디,이름을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAEM
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT MANATEG_ID
                    FROM EMPLOYEES
                    WHERE EMPLOYEE_ID = 101);
                    
--101번 직원보다 급여를 많이 받는 직원아이디, 이름 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 101);
                
-- 다중형 서브쿼리
-- Steven'과 같은 해에 입사한 직원의 아이이디, 이름, 입사일을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (SELECT TO_CHAR(HIRE_DATE,'YYYY')
                               FROM EMPLOYEES
                               WHERE FIRST_NAME = 'Steven');
                               
-- 60번 부서에 소속된 직원들의 급여보다 급여를 많이 받는 직원들의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM
EMPLOYEES
WHERE SALARY >ALL (SELECT SALARY
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);
                
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >ANY (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);
                
--  다중열 서브
-- 각 부서별 최저 급여를 받는직원의 아이디, 이름, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  WHERE DEPARTMENT_ID IS NOT NULL
                                  GROUP BY DEPARTMENT_ID);
                                  
/*
상호연관 서브쿼리
    서브쿼리에서 메인쿼리의 참조하면 사오연관 서브쿼리가 온다.
    형식
        SELECT OUTER.COLUNM, OUTER.COLUMN
        FROM TAVLE OUTER
        WHERE OUTER.COLUMN 연산자(SELECT INNER.COULMN
                                 FROM TABLE INNER
                                 WHERE INNTER.COULUM = OUTER.COLUMN);
    일반서크쿼리와 상호연관서브쿼리의 다른점
        서브쿼리는 메인쿼리보다 먼저 실행된다.
        서브쿼리는 딱 한번 실행된다.
        
        상호연관 서브쿼리는 메인쿼리문에서 처리되는 각 행에 대해서 한번씩 실행된다.
*/

-- 직원들 중에서 자신이 소속된 부서의 평균급여보다 급여를 많이 받는 사원의 아이디, 이름, 급여를 조회하기
SELECT X.EMPLOYEE_ID, X.FIRST_NAME, X.SALARY
FROM EMPLOYEES X
WHERE X.SALARY > (SELECT AVG(Y.SALARY)
                 FROM EMPLOYEES Y
                 WHERE Y.DEPARTMENT_ID = X.DEPARTMENT_ID);
                 
-------------------------------------------------
--EMPLOYEE_ID   FIRST__NAME    DEPARTMENT_ID   SALARLY
--100           홍길동          10              1000       서브쿼리의 X.DEPARTMENT_ID가 10로 지정된다.
--101           김유신          10              2000       서브쿼리의 X.DEPARTMENT_ID가 10로 지정된다.
--102           강감찬          20              2000       서브쿼리의 X.DEPARTMENT_ID가 20로 지정된다.
--103           이순신          20              4000       서브쿼리의 X.DEPARTMENT_ID가 20로 지정된다.
--104           유관순          30              1000       서브쿼리의 X.DEPARTMENT_ID가 20로 지정된다.
---------------------------------------------------

-- 부서아이디, 부서이름, 해당부서에 소속된 직원수를 조회하기
SELECT X.DEPARTMENT_ID, X.DEPARTMENT_NAME,
    (SELECT COUNT(*)
     FROM EMPLOYEES Y
     WHERE Y.DEPARTMENT_ID = X.DEPARTMENT_ID) CNT
FROM DEPARTMENTS X;

---------------------------------------------------
-- DEPARTMENT_ID  DEPARTMENT_NAME    CNT
-- 10	          Administration     SELECT COUNT(*) FROM DEPT Y WHERE Y.DEPT_ID = 10
-- 20	          Marketing          SELECT COUNT(*) FROM DEPT Y WHERE Y.DEPT_ID = 20
-- 30	          Purchasing         SELECT COUNT(*) FROM DEPT Y WHERE Y.DEPT_ID = 30
-- 40	          Human Resources    SELECT COUNT(*) FROM DEPT Y WHERE Y.DEPT_ID = 40
-- 50	          Shipping           SELECT COUNT(*) FROM DEPT Y WHERE Y.DEPT_ID = 50
---------------------------------------------------

-- 직원아이디, 직원이름, 상사의 아이디, 상사의 이름을 조회하기
SELECT X.EMPLOYEE_ID                        AS EMP_ID,
       X.FIRST_NAME                         AS EMP_NAME,
       X.MANAGER_ID                         AS MGR_ID,
       (SELECT Y.FIRST_NAME
        FROM EMPLOYEES Y
        WHERE Y.EMPLOYEE_ID = X.MANAGER_ID) AS MGR_NAME
FROM EMPLOYEES X;