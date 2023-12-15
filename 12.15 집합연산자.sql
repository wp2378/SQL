/*
집합 연산자
    집합 연산자를 이용하면 여러 개의 SQL문 조회 결과를 연결하여 하나의 결과로 만들 수 있다.
    보통 서로 다른 테이블에서 유사한 형태의 결과를 반환하는 것을 하나의 결과로 합칠 때 사용한다.
    혹은 동일한 테이블에 대해서 서로 다른 SQL문 조회를 수행하여 결과를 하나로 합칠 때 사용한다.
    
    SELECT 컬럼, 컬럼, 컬럼,
    FROM 테이블1
    [WHERE 조건식]
    집합연산자
    SELECT 컬럼, 컬럼, 컬럼
    FROM 테이블2
    [WHERE 조건식]
    
    재약사항
        1. SELECT절의 컬럼수가 동일해야 한다.
        2. SELECT절의 동일한 위치에 존재하는 컬럼의 데이터 타입이 상호 호환 가능해야 한다.
        (데이터 타입이 동일한 경우에는 반드시 필요는 없다.)
        
     종류
        UNION
            여러 SQL문의 결과 대한 합집합이다.
            모든 중복된 행은 하나의 행으로 만든다.
        UNION ALL
            여러 SQL문의 결과 대한 합집합이다.
            중복된 행도 그래도 표시된다.
            여러 SQL문의 결과를 단순히 합쳐놓은 결과를 만든다.
        INTERSECT
            여러 SQL문의 결과에 대한 교집합이다.
            중복된 행은 하나의 행으로 만든다.
        MINUS
            앞의 SQL문의 결과에서 뒤의 SQL문의 결과에 대한 차집합이다.
            중복된 행은 하나로 만든다.
            SQL의 순서에 따라서 결과가 다른게 나온다.

*/


-- UNION과 UNION ALL
-- 커미션을 받는 직원가 커미션을 받지 않는직원들 모두 조회하기
-- 집합연사자 실습을 위한 SQL이기 때문에 좋은 식은 아님
SELECT EMPLOYEE_ID AS EMP_ID, FIRST_NAME AS EMP_NAME, COMMISSION_PCT AS EMP_COMM
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
UNION
SELECT EMPLOYEE_ID, FIRST_NAME, 0
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

-- UNION ALL
-- 직종이 변경된 적이 있는 직원과 변경된 적이 없는 직원들 모두 조회하기
-- * 직종이 변경된 적이 업슨 직원정보는 EMPLOYEE 테이블을 전체 조회하는 것으로 대신한다.
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'P' JOB_STATUS
FROM JOB_HISTORY
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'C'
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID ASC;


-- INTERSECT
-- 급여를 5000달러 이하를 받은 직원들 집합과 직종이 변경된 적이 있는 직원들 집합의 교집합 조회하기
SELECT EMPLOYEE_ID 
FROM EMPLOYEES
WHERE SALARY <= 5000
INTERSECT
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;

-- 교집합을 구하는 집합연산자는 IN 서브쿼리 혹은 EXISTS 서브쿼리로 대신할 수 있다.
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY <= 5000
AND EMPLOYEE_ID IN (SELECT EMPLOYEE_ID
                    FROM JOB_HISTORY);
                    
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE SALARY <= 5000
AND EXISTS (SELECT 'X'
            FROM JOB_HISTORY H
            WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID);

/*
EXISTS 연산자
    다중행 서브쿼리 연산자.
    
    + EXISTS (서브쿼리)에서 서브쿼리는 조건을 만족하는 데이터가 여러 건이 있다고 하더라도 조건을
      만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다.
    + 실제 프로젝트에서 특정 조건을 만족하는지 여부를 묻는 로직이 많이 사용되는데,
      COUNT(*)로 조건을 만족하는 행의 갯수를 조회하기 것은 SQL 실행 성능에 나쁘다.
      따라서, EXISTS연산자를 사용할 수 있는지 고려해야 한다.
    + EXISTS (서브쿼리)에서 SELECT절에는 업무적으로 의미없는 상수값 (1, 'X')을 반환하도록 한다.
    
    형식
        SELECT A.컬럼, A.컬럼, A.컬럼...
        FROM 테이블명 A
        WHERE EXISTS (서브쿼리)
        
        UPDATE 테이블
        SET
            컬럼명 = 값,
            컬럼명 = 값,
            ..
        WHERE EXISTS (서브쿼리)
        
        *서브쿼리의 결과를 만족하는 값이 존재하는지 여부를 확인하는 연산자다.
         조건을 만족하는 데이터가 여러 건이라 하더라도, 1건만 찾으면 더이상 검색을 하지 않는다.
         
    
*/

-- 직종 변경이 이력이 있는지 여부 체크하기              
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE 0 < (SELECT COUNT(*)
           FROM JOB_HISTORY H
           WHERE H.EMPLOYEE_ID = E. EMPLOYEE_ID);

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE EXISTS (SELECT 'X'
              FROM JOB_HISTORY H
              WHERE H.EMPLOYEE_ID = E. EMPLOYEE_ID);

-- 최근 6개월간 구매이력이 있는 고객에게 쿠폰을 지급한다.
UPDATE CUSTOMERS C
SET
    C.CUSTOMER_GIFT_COUPON = '커피쿠폰'
WHERE
    C.CUSTOMER_DELETED = 'N'
    AND EXISTS (SELECT 1
                FROM ORDERS O
                WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
                AND O.ORDER_DATE > ADD_MONTHS(SYSDATE, -6));
                
-- Neena와 같은 부서에서 일하는 직원 조회하기                
SELECT *
FROM EMPLOYEES
WHERE EXISTS (SELECT 1
              FROM EMPLOYEES
              WHERE FIRST_NAME = 'Neena');

-- WHERE 컬럼 연산자 (서브쿼리) : 컬럼값과 비교가능한 의미있는 값을 서버쿼리가 제공해야 한다.
-- WHERE 값   연산자 (서브쿼리) : 제시된 값과 비교가능한 의미있는 값을 서버쿼리가 제공해야 한다.
-- WHERE EXISTS    (서브쿼리) : 서브쿼리는 의미있는 값을 제공하지 않아도 된다.
--                            의미없는 상수값을 반환해도 된다.



-- MINUS
-- 직종이 한번도 변경된 저이 없는 직원정보 조회하기
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;


