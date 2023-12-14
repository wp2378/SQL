/*
뷰(가상의 테이블)
    테이블 혹은 다른 뷰를 기반으로 생성하는 가상의 테이블이다.
    물리적인 저장공간을 가지지 않는다.
    뷰를 대상으로 INSERT, UPDATE, DELETE 작업을 수행하기 어렵다.
    뷰를 대상으로 SELECT 작업을 주로 수행한다.
    
    뷰를 활용하면 복잡한 SQL작업을 단순한 SQL문으로 대신할 수 있다.
    동일한 데이터로 다양한 결과를 얻을 수 있다.
    데이터 액세스를 제한할 수 있다.
    
    
    
    
뷰 생성하기
    CREATE OR REPLACE VIEM 뷰이름 
    AS 서브쿼리
    WITH READ ONLY;
*/

-- 부서에 대한 상세정보를 제공하는 뷰 생성하기
-- 부서아이디, 부서명, 관리자 아이디, 관리자 이름,
-- 소재지 아이디, 소재지 도시, 우편번호, 주소, 국가콛, 국가명을 포함한다.
CREATE OR REPLACE VIEW DEPT_DETAIL_VIEW
AS (SELECT D.DEPARTMENT_ID,
           D.DEPARTMENT_NAME,
           D.MANAGER_ID,
           M.FIRST_NAME,
           D.LOCATION_ID,
           L.CITY,
           L.POSTAL_CODE,
           L.STREET_ADDRESS,
           C.COUNTRY_ID,
           C.COUNTRY_NAME
    FROM DEPARTMENTS D, EMPLOYEES M, LOCATIONS L, COUNTRIES C
    WHERE D. MANAGER_ID = M.EMPLOYEE_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID)
WITH READ ONLY;

SELECT * -- 부서아이디, 부서명, 관리자이름, 소재도시명
FROM DEPT_DETAIL_VIEW
WHERE DEPARTMENT_ID = 60;

/*
인라인 뷰
    SELECT문의 FROM절에 정의된 서브쿼리(SLEECT문)으로 생성되는 가상의 테이블이다.
    오라클의 데이터베이스 객체가 아니기 때문에 SQL문이 실행되는 동안만 잠깐 생겨났다가
    사라지는 가상의 테이블이다.
    * 뷰는 CREATE문으로 생성되는 오라클의 데이터베이스 객체다.
    
    
    형식
        SELECT 컬럼명, 컬럼명
        FROM (SELECT 컬럼명, 컬럼명
              FORM 테이블명
               WHERE 조건식) A
*/

-- 부서아이디, 부서명, 사원수를 조회하기
SELECT DEPARTMENT_ID, COUNT(*) CNT
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT V.DEPT_ID, V.CNT, D.DEPARTMENT_NAME
FROM (SELECT DEPARTMENT_ID  AS DEPT_ID,
            COUNT(*)        AS CNT
      FROM EMPLOYEES  
      WHERE DEPARTMENT_ID IS NOT NULL
      GROUP BY DEPARTMENT_ID) V, DEPARTMENTS D
WHERE V.DEPT_ID = D.DEPARTMENT_ID;

-- 부서별 최저급여를 받는 사원의 아이디, 이름, 부서아이디, 급여를 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (SELECT I.DEPARTMENT_ID, MIN(I.SALARY)
                                      FROM EMPLOYEES I
                                      GROUP BY I.DEPARTMENT_ID);
                                      
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM (SELECT DEPARTMENT_ID, MIN(SALARY) MIN_SALARY
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) X, EMPLOYEES E
WHERE X.DEPARTMENT_ID = E.DEPARTMENT_ID
AND X.MIN_SALARY = E.SALARY;

/*
인덱스(색인)
    데이터 검색 속도를 향상시키기 위해서 사용되는 데이터베이스 객체다.
    인덱스에는 컬럼의 값과 ROWID(데이터의 저장위치 정보)가 저장되어 있다.
    * ROWID는 데이터행이 저장된 파일번호/블록번호/슬롯번호를 포함하고 있다.
    인덱스는 테이블과 독립접으로 존재하고, 한번 생성된 인덱스는 자동으로 유지된다. 
    
    인덱스 생성
        자동생성
            PRIMARY KEY, UNIQUE 제약조건이 적용된 컬럼은 자동으로 인덱스가 생성된다.
        수동생성
            WHERE절에 조건식으로 자주 등장하는 컬럼은 조회 성능을 향상시키기 위해서
            해당 컬럼에 대한 인덱스를 생성할 수 있다.
            
    인덱스 생성에 유리한경우
        WHERE절에 조건식으로 자주 등장하는 경우 인덱스로 생성하자.
        컬럼에 매우 다양한 값을 포함하고 있다면 인덱스를 생성하자.
        데이터가 매우 많은 테이블을 대상으로 데이터를 조회했을 때 조회작업을 할 때 마다
        전체 데이터의 2% 미만으로 데이터가 조회되는 경우 해당 컬럼을 인덱스로 생성하자.
            
*/

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 200;

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Neena';

SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = LOWER('Neena');

-- 인덱스 생성하기
CREATE INDEX ENP_FIRSTNAME_IDX
ON EMPLOYEES (FIRST_NAME);
      
      
      
      
      
      
      
      
      
      