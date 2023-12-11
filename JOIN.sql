/*
���̺� �����ϱ�

    SELSCT *
    FROM ���̺�1, ���̺�2
    * ���̺��� ������ ���� ����̵Ǵ� ���̺��� �̸��� FROM���� �����ϱ⸸ �ϸ�ȴ�.
    * ������ ������ ������ ���̺�1�� ��� ���� ����� ������ ���̺��� �����ȴ�.
    * (���̺�1�� ���� ���� + ���̺�2�� ���� ����) ��ŭ�� ���� ��ȸ�ȴ�.

2. �������� �����ϱ�
    
        SELECT *
        FORM ���̺�1, ���̺�2
        WHERE ���̺�1.�÷��� = ���̺�2.�÷���
        * ���ε� ���̺��� ��� �࿡�� ���������� �����ϴ� ���� �ǹ��ְ� ����� ���̴�.
        * ���������� �����ϸ� �ǹ��ְ� ����� �ุ ��ȸ�� �� �ִ�.
        * ���������� ���� = ���ε� ���̺��� ���� - 1
*/

-- REGIONS ���̺�� COUNTRIES ���̺� �����ϱ�
-- ERGIONS ���̺��� ��� ��� COUNTRIES ���̺��� ��� ���� ���εȴ�.
SELECT *
FROM REGIONS, COUNTRIES;

-- REGIONS ���̺�� COUNTRIES ���̺� �����ϰ�, ���� �����ִ� �ุ ���͸��ϱ�
SELECT COUNTRIES.COUNTRY_ID,
       COUNTRIES.COUNTRY_NAME,
       REGIONS.REGION_NAME
FROM REGIONS, COUNTRIES
WHERE REGIONS.REGION_ID = COUNTRIES.REGION_ID;

-- �������̵�, �����̸�, �������̵�, ��������, �����ּұ޿�, �����ִ�޿�, �޿���ȸ�ϱ�
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
� ����
    �������ǿ��� EQUAL(=) �����ڸ� ����Ѵ�.
    ���ο� �����ϴ� ���̺��� ���� ���� ������ �ִ� �ೢ�� �����Ѵ�.
    
    ORACLE �����
    SELECT A.�÷���,A.�÷���, B.�÷���, B.�÷���....
    FROM  ���̺� A, ���̺� B
    WHERE A.�÷���, JOIN B.�÷���;
    
    ANSLS SQL �����
    SELECT A.�÷���,A.�÷���, B.�÷���, B.�÷���....
    FROM  ���̺� A, JOIN ���̺� B
    ON A.�÷��� = B.�÷���;
*/

-- ���� ���̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
--  E         E       E              
--                    D            D

-- ORALCE�� �����
SELECT A.EMPLOYEE_ID, A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- ABSU SQL�� �����
SELECT A.EMPLOYEE_ID, A.FIRST_NAME, B.DEPARTMENT_NAME
FROM EMPLOYEES A JOIN DEPARTMENTS B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- �μ������ڰ� ������ �μ��� �μ����̵�, �μ���, �μ������ڸ�(�����̸�)�� ��ȸ�ϱ�
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

-- �������̵�, �̸�, �ҼӺμ����̵�, �ҼӺμ���, �������̵�, ��������, �޿��� ��ȸ�ϱ�
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

-- �������̵�, �����̸�, �ҼӺμ����̵�, �μ���, ���������̵�,�ٹ��������ø��� ��ȸ�ϱ�
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
�񵿰����ο� ���� ���̺� �߰�
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
������
    ���������� ������ �� ���� ������̺��� ���� ���� ���� �����͸� �������� ���,
    ũ�ų� ���� ����� �������� �����͸� ��ȸ�ϴ� ���� ����� �� �����̴�.
*/
-- �������̵�, �����̸�, �޿�,               �޿������ ��ȸ�ϱ�
-- E         E       E
--                   G(�ּ�/�ִ� �޿�)     G
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
��������

���� ���̺��� �����Ͱ� �ְ�, �ٸ� �� ���̺� ���������� �����ϴ� �����Ͱ� ���� ���,
���ο� �������� ���ϱ� ������ ��� ���� ��ȸ���� �ʴ´�.
�����Ͱ� ���� ��쿡�� �����Ͱ� �ִ� �� ���̺��� ��� ���� ��ȸ�ϴ� ���ι���̴�.
��� ���� ��ȸ�ϴ� ���̺��� �ݴ��� �������ǿ� �������� ��ȣ(+)�� �߰��Ѵ�.
*/

-- �μ����̵�, �μ��̸�, �μ������ھ��̵�, �μ��������̸��� ��ȸ
-- D         D       D(MANAGE_ID)
--                   E(EMPLOYEE_ID) E(FIRST_NAME)
SELECT A.DEPARTMENT_ID, A.DEPARTMENT_NAME, A.MANAGER_ID, B.FIRST_NAME
FROM DEPARTMENTS A, EMPLOYEES B
WHERE A.MANAGER_ID = B.EMPLOYEE_ID(+);

-- �������̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ��� ��ȸ�ϱ�
-- E         E       E
--                   D            D
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       A.DEPARTMENT_ID,
       B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID(+); -- ���γ��;��ϴ� �ʿ��ٰ� (+)����ֱ�

-- ANSL SQL
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       A.DEPARTMENT_ID,
       B.DEPARTMENT_NAME
FROM EMPLOYEES A
LEFT OUTER JOIN DEPARTMENTS B           -- LEFT OUTER JOIN�� �������̺��� ��� ���� ��ȸ�Ѵ�.
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID;

----------------------------------------------------------
-- �޿��� 12000�� �Ѵ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 12000;
-- �޿��� 5000�̻� 12000������ ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE 5000 <= SALARY 
AND SALARY <= 12000;
-- 2007�⿡ �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE '2007/01/01' <= HIRE_DATE
AND HIRE_DATE <= '2008/01/01';
-- 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ������ �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20,50)
ORDER BY FIRST_NAME ASC;
-- �޿��� 5000�̻� 12000���ϰ�, 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE 5000<= SALARY
AND SALARY <= 12000
AND DEPARTMENT_ID IN (20, 50);
-- �����ڰ� ���� ������ �̸��� ����, �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;
-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ������ ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN('SA_MAN', 'ST_MAN')
AND SALARY >= 8000;

-- ��� ������ �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT A.FIRST_NAME, 
       A.JOB_ID, 
       A.SALARY, 
       B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.MANAGER_ID = B.MANAGER_ID;

-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
SELECT A.FIRST_NAME, 
       A.JOB_ID, 
       B.JOB_TITLE, 
       A.SALARY,
       B.MIN_SALARY,
       B.MAX_SALARY
FROM EMPLOYEES A ,JOBS B
WHERE A.JOB_ID = B.JOB_ID;
-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
SELECT A.FIRST_NAME, 
       A.JOB_ID,
       B.JOB_TITLE,
       A.SALARY,
       A.SALARY - B.MIN_SALARY �޿�����
FROM EMPLOYEES A, JOBS B
WHERE A.JOB_ID = B.JOB_ID;
-- Ŀ�̼��� �޴� ��� ������ ���̵�,�����̸�,�μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       B.DEPARTMENT_NAME,
       C.LOCATION_ID
FROM EMPLOYEES A, DEPARTMENTS B, LOCATIONS C
WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND B.LOCATION_ID = C.LOCATION_ID
AND COMMISSION_PCT IS NOT NULL;
-- �̸��� A�� a�� �����ϴ� ��� ������ �̸��� �������̵�, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT A.FIRST_NAME,
       B.JOB_ID, 
       B.JOB_TITLE,
       A.SALARY,
       C.DEPARTMENT_NAME
FROM EMPLOYEES A, JOBS B, DEPARTMENTS C
WHERE A.JOB_ID = B.JOB_ID
AND A.DEPARTMENT_ID = C.DEPARTMENT_ID
AND FIRST_NAME LIKE 'A%';
-- 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ������ �߿��� 100���� �����ϴ� �������� �̸�, �������̵�, �޿�, �޿������ ��ȸ�ϱ�
SELECT A.FIRST_NAME,
       A.JOB_ID, 
       A.SALARY,
       B.GEADE
FROM EMPLOYEES A, SALARY_GRADES B, JOBS C
WHERE A.JOB_ID = C.JOB_ID
AND B.MIN_SALARY = C.MIN_SALARY
AND DEPARTMENT_ID IN(30,60,90);
-- 80�� �μ��� �Ҽӵ� �������� �̸�, �������̵�, ��������, �޿�, �޿����, �ҼӺμ����� ��ȸ�ϱ�
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
-- 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ������ ���̵�, �̸�, ������ �μ���, ���� �������̵�, ���� �ٹ��μ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       H.JOB_ID              AS ��������,
       E.JOB_ID              AS ��������,
       D1.DEPARTMENT_NAME    AS �����μ���,   
       D2.DEPARTMENT_NAME    AS ����μ���
FROM JOB_HISTORY H,            -- ���������̷�����(��������, �����ҼӺμ����̵�)
     EMPLOYEES E,              -- ��������(��������, ����ҼӺμ����̵�)
     DEPARTMENTS D1,            -- �����ҼӺμ�����
     DEPARTMENTS D2             -- ����ҼӺμ�����
WHERE H.JOB_ID = 'ST_CLERK'
AND H.EMPLOYEE_ID = E.EMPLOYEE_ID
AND H.DEPARTMENT_ID = D1.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D2.DEPARTMENT_ID;