/*
단일행 함수 - 기타 함수

NVL(컬럼, 대체값)
    NVL함수는 NULL값을 다른 값으로 변환한다.
    지정된 컬럼의 값이 NULL아닌 경우에는 해당 컬럼의 값을 반화한다.
    해당 컬럼과 대체값은 데이터 타입이 동일한 타입이어야한다.
    
NVL2(컬럼, 대체값1, 대체값2)
    지정된 컬럼의 값이 NULL이 아니면, 대체값1이 반환되고, NULL이면 대체갑2가 반환된다.
    대체값1과 대체값2는 데이터 타입이 동일한 타입이어야 한다.

*/

-- 모든 직운의 아이디, 이름, 급여, 커미션을 조회한다.
-- 커미션이 NULL이면 0을 반환한다.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, NVL(COMMISSION_PCT, 0) COMM
FROM EMPLOYEES;

-- 모든 직원의 아이디, 이름, 급여, 커미션, 커미션이 포함된 급여를 초회하기
-- 커미션이 포함된 급여 = 급여 + (급여*커미션)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT,
       SALARY + (SALARY*NVL(COMMISSION_PCT, 0))
FROM EMPLOYEES;

-- 모든 부서의 부서아이디, 이름, 관리자아이디를 조회하기
-- 단, 관리자가 지정된지 않은 부서는 '관리자없음'으로 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, NVL(TO_CHAR(MANAGER_ID), '관리자없음')
FROM DEPARTMENTS;

/*
    단일행 함수 - 기타함수

DECODE 함수
    DECODE(컬럼, 비교값1, 값1,
                비교값2, 값2
                비교값3, 값4
                값4)
    * 지정된 컬럼의 값이 비교값1과 같으면 값1이 반환된다.
                   비교값2와 같으면 값2가 반환된다.
                   비교값3가 같으면 값3이 반환된다.
                   일치하는 값이 없으면 기본값이 반환된다.
    * DECODEM함수는 컬럼의 값과 비교값간의 EQUALS 비교만 가능하다               
    
                   
                   
CASE ~ WHEN 표현식
    CASE
        WHEN 조건식1 THEN 값1
        WHEN 조건식2 THEN 값2
        WHEN 조건식3 THEN 값3
        ELSE 값4
    END
    * 조건식1이 TRUE로 판정되면 THEN이 최종값이 된다.
    * 모든 조건식이 FALSE로 판정되면 ELSE의 값4가 최종값이 된다.
    * 조건식에서는 =, >, >=, <, <=, != 등의 다양한 연산자를 사용해서 작성할 수 있다.
    * DECODE함수에 비교했을 때 더 다양한 조건을 적용할 수 있다.
    
    CASE 컬럼
        WHEN 비교값1 THEN 값1
        WHEN 비교값2 THEN 값2
        WHEN 비교값3 THEN 값3
        ELSE 값4
    END
    * 지정된 컬럼의 값이 비교값들 중 하나와 일치하면 해당 THEN의 값이 최종값이 된다.
    * 모든 비교값과 일치하지 않으면 ELSE의 값4가 최종값이 된다.
    * DECODE 함수와 기능면에서 동일하다.
*/

-- 모든 직원테이블에서 급여가 5000이하면 보너스를 1000지급하고,
--                 급여가 10000이하면 보너스를 2000지급하고,
--                 그 외는 3000을 지급한다.
-- 모든 직원에 대해서 직원아이디, 이름, 급여, 보너스를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,
        CASE
            WHEN SALARY <= 5000 THEN 1000
            WHEN SALARY <= 10000 THEN 2000
            ELSE 3000
        END BONUS
FROM EMPLOYEES;

-- 모든 직원에 대해서 부서 아이디를 기준으로 팀을 지정하기,
-- 10, 20, 30 부서는 A팀, 40, 50, 60번 부서는 B팀, 그 외는 C팀
-- 직원아이디, 이름, 부서아이디, 팀명을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME,DEPARTMENT_ID,
        CASE
            WHEN DEPARTMENT_ID IN(10, 20, 30) THEN 'A'
            WHEN DEPARTMENT_ID IN(40, 50, 60) THEN 'B'
            ELSE 'C'
        END AS TEAM
FROM EMPLOYEES;

-- 지역 테이블에서 지역아이디별로 지역명을 조회하기
-- 1은 유럽, 2는 아메리카, 3은 아시아, 4는 아프리카 및 중동
SELECT REGION_ID,
        CASE
            WHEN REGION_ID = 1 THEN '유럽'
            WHEN REGION_ID = 2 THEN '아메리카'
            WHEN REGION_ID = 3 THEN '아시아'
            WHEN REGION_ID = 4 THEN '아프리카 및 중동'
        END REGION_NAME
FROM REGIONS;

SELECT REGION_ID,
        CASE REGIOND_ID
            WHEN 1 THEN '유럽'
            WHEN 2 THEN '아메리카'
            WHEN 3 THEN '아시아'
            WHEN 4 THEN '아프리카 및 중동'
        END REGION_NAME
FROM REGIONS;

-- DECODE를 이용해서
-- 지역 테이블에서 지역아이디별로 지역명을 조회하기
-- 1은 유럽, 2는 아메리카, 3은 아시아, 4는 아프리카 및 중동
SELECT REGION_ID,
       DECODE(REGION_ID, 1, '유럽',
                         2, '아메리카',
                         3, '아시아',
                         4, '아프리카 및 중동') AS REGION_NAME
FROM REGIONS;

-- 부서 테이블에서 부서아이디, 부서명, 관리자 이름을 조회하기
-- 괸리자가 지정되어 있지 않으면 없음으로 조횐다.
SELECT B.DEPARTMENT_ID, B.DEPARTMENT_NAME,
        CASE
            WHEN B.MANAGER_ID IS NOT NULL THEN (SELECT A.FIRST_NAME 
                                                FROM EMPLOYEES A 
                                                WHERE A.EMPLOYEE_ID = B.MANAGER_ID)
            ELSE '없음'
        END MANAGER_NAME
FROM DEPARTMENTS B;