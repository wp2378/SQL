/*
트랜잭션
    데이터베이스의 상태를 변환시키는 하나의 논리적인 기능을 수행하기 위한 작업의 단위다.
    예) 홍길동이 이순식에게 1000마원을 이제한다.
        1. 홍길동의 계좌에서 잔액을 100만원 감소시킨다. - UPDATE작업
        2. 이순신의 계좌에서 잔액을 100마원 증가시킨다. - UPDATE작업
        3. 홍길동의 최근 이체내역에 이순신에게 100만원 송금한 내용을 추가한다. ==  INSERT작업
        
        논리적인 작원의 단위(그룹, 묶음, 연산들) = 감소 UPDATE + 증가 UPDATE 9 추가 INSERT
        논리적인 작업의 단위를 구성하는 모든SQL명령이 성공적으로 완료되어야 하나의 작업 단위가 
        완료된 것이고, 이 경우에 데이터베이스를 반영시킨다.
        
    트랜잭션 관련 명령어
        COMMIT 
            논리적인 작업 단위를 구성하는 모든 작업이 성공적으로 완료되었을 때,
            데이터베이스의트랜잭션 관리자에게
            해당 작업 단위내에서 실행했던 처리 결과를 영구적으로 데이터베이스에 반영시킨다.
        ROLLBACK
        논리적인 작업 단위를 구성하는 작업 중에서 오류가 발생했을 때
        데이터베이스의 트랜잭션 관리자에게
        해당 작업 단위내에서 실행했던 처리 결과의 데이터베이스 반영을 취소시키게 한다.
        
    트랜잭션의 시작과 종료
        트랜잭션의 시작
            - 첫번째 DML, 명령문이 실행될때 새로운 트랜잭션이 시작된다.
            - COMMIT, ORLLBACK 명령을 실행하면 기존 트랜잭션이 종료되고, 새로운 트랜잭션을 시작된다.
        트랜재셕의 종료
            - COMMIT, ROLLBOOK 명령을 실행하면 기존 트랜잭션이 종료된다.
            - DBMS에 시스템 장애가 발생할 때 AUTO-ROLLBACK이 실행되면서 트랜잭션이 종료된다.
            
*/

-------------------------------------------------------------- 트랜잭션1이 시작됨
UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOSIT - 1000000
WHERE
 NO = 10;                             // 트랜잭션1의 연산이다
 
 UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOSIT + 1000000
WHERE
 NO = 20;                            // 트랜잭션1의 연산이다
 
 INSERT INTO HISTORIES
 VALUES (10,20,1000000, SYSDATE);    // 트랜잭션1의 작업이다._
 
 COMMIT;                            // 트랜잭션1의 모든 연산이 오류없이 실행되었기 때문에
                                    // 트랜잭션관리자에게 트랜잭션1의 처리결과를
                                    // 영구적으로 데이터베이스에 반영시키도록 한다.
---------------------------------------------------------------- 트랜잭션1 종료
---------------------------------------------------------------- 트랜잭션2 실행

UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOST - 50000
WHERE
    NO = 70;                        // 트랜잭션2의 연산이다
    
UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOST + 50000
WHERE
    NO = 120;                       // 트랜잭션2의 연산이다
 
INSERT INTO HISTORIES
VALUES (70, 120, 50000);            // 트랜잭션2의 연산이다       
 
 ROLLBACK;                          // 트랜잭션2의 INSERT 작업중 오류가 발생하였다.
                                    // 트랜잭션관리자에게 트랜잭션2의 처리결과를
                                    // 모두 취소시키도록 한다.
----------------------------------------------------------------- 트랜잭션2가 종료됨
----------------------------------------------------------------- 트랜잭션3이 실행됨
 
 ----------------------------------------------------------------------------------------
-- 모든 직원의 아이디, 이름, 부서번호, 부서명을 조회하기(등가조인)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME, 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 커미션을 받는 직원의 아이디, 이름, 직종아이디, 급여, 커미션을 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- 커미션을 받는 직원의 아이디, 이름, 급여, 커미션, 급여등급을 조회하기(비등가조인)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME,
       E.SALARY,
       E.COMMISSION_PCT,
       G.GEADE
FROM EMPLOYEES E, SALARY_GRADES G, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND E.SALARY > G.MIN_SALARY
AND E.SALARY < G.MAX_SALARY
AND COMMISSION_PCT IS NOT NULL;

-- 80번 부서에 소속된 직원들의 평균급여, 최저급여, 최고급여를 조회하기(그룹함수)
SELECT DEPARTMENT_ID, TRUNC (AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IN (80);

-- 80번 부서에 소속된 직원들의 직원아이디, 이름, 직종제목, 급여, 최고급여와 급여간의 차이를 조회하기(등가조인)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME,
       E.JOB_ID,
       E.SALARY,
       (J.MAX_SALARY-E.SALARY)  AS 최고급여간차이
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND DEPARTMENT_ID = 80;

-- 각 부서별 최고급여, 최저급여, 최고급여와 최저급여의 차이를 조회하기(GROUP BY)
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY), (MAX(SALARY)-MIN(SALARY)) AS 최고최저급여간의차이
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 'Executive' 부서의 모든 직원아이디, 이름, 직종아이디를 조회하기(서브쿼리 혹은 조인)
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'Executive');
                       
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME,
       E.JOB_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND DEPARTMENT_NAME = 'Executive';

-- 전체 직원의 평균급여보다 급여를 적게 받는 직원의 아이디, 이름, 급여를 조회하기(서브쿼리)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- 'Ismael'과 같은 해에 입사했고, 같은 부서에 근무하고 있는 직원의 아이디, 이름, 입사일을 조회하기(서브쿼리)
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = (SELECT TO_CHAR(HIRE_DATE, 'YYYY')
                                    FROM EMPLOYEES
                                    WHERE FIRST_NAME = 'Ismael');

-- 부서별 최고급여를 조회했을 때 최고급여가 15000을 넘는 부서의 아이디와 최고급여를 조회하기(GROUP BY, HAVING)
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 15000;

-- 'Neena'보다 급여을 많이 받는 직원의 아이디, 이름, 직종아이디, 급여를 조회하기(서브쿼리)
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE FIRST_NAME = 'Neena');

-- 급여등급별로 직원수를 조회하기(비등가조인, GROUP BY)

-- 부서별 평균급여를 계산했을 그 부서의 평균급여보다 급여를 적게 받는 직원의 아이디, 이름, 급여, 부서명을 조회하기(인라인뷰, 조인)

-- 'Ismael' 직원이 근무하는 부서의 아이디와 이름을 조회하기(서브쿼리)

-- 'Neena'에게 보고하는 직원의 아이디와 이름을 조회하기(서브쿼리)

-- 부서별 평균급여를 계산했을 때 'Ismael'이 근무하는 부서의 평균급여보다 급여를 많이 받는 부서의 아이디와 평균급여를 조회하기(GROUP BY, 인라인뷰, 서브쿼리)
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES E
WHERE E.AVG(SALARY) > (SELECT AVG(SALARY)
                       FROM EMPLOYEES E1, EMPLOYEES E2
                       WHERE E1.FIRST_NAME = E2.SALARY
                       AND FIRST_NAME = 'Ismael');
 
 
 
 
 
 
 
 
 
 
 