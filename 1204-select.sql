/*
    ���̺��� ������ ��ȸ
    
    1. ������ ���̺��� ��� ��, ��� ���� ��ȸ�Ѵ�.
        select*
        form ���̺��;
        
    2. ������ ���̺��� ��� ��, ������ ���� ��ȸ�ϱ�
        select �÷���,�÷���,�÷���...
        form ���̺��;

    3. select������ ��Ģ������ ������ �� �ִ�.
    select �÷��� + ����, �÷���+�÷��� ...
    from ���̺��;
    * ��Ģ���꿡 ���Ǵ� �÷��� �ش� �÷��� ���� ���ڰ��̾���Ѵ�.
    
    4. �÷��� ��Ī(alias) �ο��ϱ�
    select �÷��� as ��Ī, �÷��� as ��Ī, ...
    from ���̺��;
    
    select �÷��� ��Ī, �÷��� ��Ī, �÷��� ��Ī, ...
    from ���̺��;
    
*/

-- ���� ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
SELECT *
from regions;

-- ���� ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from countries;

-- ���� ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from jobs;

-- �μ� ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select * 
from departments;

-- ���� ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
SELECT *
from employees;

-- ���� ���̺��� ���� ���̵�, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT job_id, min_salary, max_salary
from jobs;

-- ���� ���̺��� �������̵�, �����̸�(first_name), �޿��� ��ȸ�ϱ�
select EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES;

-- ������ ���̺��� ������ ���̵�, �ּ�, ���ø��� ��ȸ�ϱ�
select location_id, street_address, city
from locations;

-- ���� ���̺��� �������̵�, �����̸�, �޿�, ������ ��ȸ�ϱ�
-- ������ �޿�*12�� ����Ѵ�.
select employee_id, first_name, salary, salary*12
from employees;

-- ���� ���̺��� �������̵�, �����̸�, �޿�, ������ ��ȸ�ϱ�
-- ������ �޿�*12�� ����Ѵ�.
-- ������ ��Ī�� annual_salary��.
select employee_id, first_name, salary, salary*12 as annual_salary
from employees;

-- ���� ���̺��� �������̵�, �ְ�޿�, �����޿�, �ְ�޿��� �����޿��� ���̸� ��ȸ�ϱ�
-- �ְ�޿��� �����޿��� ���̴� salary_gap ��Ī�� �ο��Ѵ�.
select job_id, max_salary, min_salary, max_salary - min_salary as salary_gap
from jobs;

/*

    ������ ���͸��ϱ�
    
    1. where���� ���ǽ��� �ۼ��ؼ� �ش� ���ǽ��� ������Ű�� �ุ ��ȸ�ϱ�
    select �÷���, �÷���, �÷���, ...
    from ���̺��
    where ���ǽ�;
    
    2. WHERE������ 2�� �̻��� ���ǽ����� �����͸� ���͸��� �� �ִ�.
    2�� �̻��� ���ǽ��� �ۼ��Ҷ��� and, or, not �� �����ڸ� ����Ѵ�.
    select �÷���, �÷���, �÷���, ...
    from ���̺��
    where ���ǽ�1 and ���ǽ�2;
    * ���ǽ�1�� ���ǽ�2�� ��� true�� �����Ǵ� �ุ ��ȸ�ȴ�.
    
    select �÷���, �÷���, �÷���, ...
    from ���̺��
    where ���ǽ�1 or ���ǽ�2;
    * ���ǽ�1�� ���ǽ�2 �߿��� �ϳ��� true�� �����Ǵ� �ุ ��ȸ�ȴ�.
    
    select �÷���, �÷���, �÷���, ...
    from ���̺��
    where ���ǽ�1 and (���ǽ�2 or ���ǽ�3);
    * and �����ڿ� or �����ڸ� ���� ����� ���� or ������� ��ȣ�� ���´�.
*/

-- ���� ���̺��� �ҼӺμ� ���̵� 60���� ������ ���̵�, �̸�, �������̵� ��ȸ�ϱ�
SELECT employee_id, first_name, job_id
from employees
WHERE department_id = 60;

-- �������̺��� �޿��� 10000�޷� �̻� �޴� ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
SELECT employee_id, first_name, job_id, salary
from employees
where salary >= 10000;

-- ���� ���̺��� �������̵� 'SA_MAN'�� ���̵�, �̸�, �޿�, �ҼӺμ� ���̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, first_name, SALARY, DEPARTMENT_ID
FROM employees
WHERE JOB_ID = 'SA_MAN';

-- ���� ���̺��� �޿��� 5000 ~10000 ������ ���ϴ� �������̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
-- �޿��� 5000�̻�, 10000���Ϸ� �޴� ������ ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary >= 5000 and salary <= 10000; 

-- ���� ���̺��� 10�� �μ�, 20�� �μ�, 30�� �μ����� �ٹ��ϴ� ���� ���̵�, �̸� ,�μ����̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id = 10 or department_id = 20 or department_id = 30;

-------------------------------------------
-- �μ����̺��� ��� �μ� ������ ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS;

-- �μ����̺��� ���������̵� 1700���� �μ� ���� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM departments
WHERE location_id = 1700;

-- 100�� ������ �����ϴ� �μ����� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE MANAGER_ID = 100;


-- �μ����� 'IT'�� �μ��� ���� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';

-- ���������̵� 1700���� ������ �ּ�, �����ȣ, ���ø�, �����ڵ带 ��ȸ�ϱ�
SELECT STREET_ADDRESS, POSTAL_CODE, CITY, COUNTRY_ID
FROM LOCATIONS
WHERE LOCATION_ID = 1700;

-- �ּұ޿��� 2000�̻� 5000������ ������ �������̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE 2000 <= MIN_SALARY AND 5000 >= MAX_SALARY;

-- �ִ�޿��� 200000���� �ʰ��ϴ� ������ ���̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
FROM JOBS
WHERE max_salary > 20000;

-- 100��° �������� �����ϴ� ������ ���̵�, �̸�, �μ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM employees
WHERE manager_id = 100;

-- 80�� �μ����� �ٹ��ϰ� �޿��� 8000�� �̻� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE department_id = 80 AND salary > 8000; -- ���� SALARY >= 8000;


-- �������̵� 'SA_REP'�̰�, Ŀ�̼� ����Ʈ�� 0.25�̻��� ������ ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE JOB_ID = 'SA_REP' AND commission_pct > 0.25;

-- 80�� �μ��� �ٹ��ϰ�, �޿��� 10000�� �̻��� ������ ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
-- ���� = (�޿�+�޿�*Ŀ�̼�)*12��
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, (salary + salary * commission_pct)*12 AS ����
FROM employees
WHERE department_id = 80 AND salary >10000;

-- 80�� �μ��� �ٹ��ϰ�, 147�� �������� �����ϴ� ����߿��� Ŀ�̼��� 0.1�� 
-- ������ ���̵�, �̸�, ����, �޿�, Ŀ�̼� ����Ʈ�� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, COMMISSION_PCT
FROM EMPLOYEES
WHERE department_id = 80 
AND manager_id = 147; 
-- ���� AND COMMISSION_PCT = 0.1;


