/*
    �ߺ��� ���� �����ϰ� �ѹ��� ��ȸ�ϱ�
    select distinct �÷���, �÷��� ...
    form ���̺��
    * ������ �÷����� ���� ���� ���� ���� ������ ���� �ѹ��� ��ȸ�ȴ�.
*/

-- �������̺��� �������� �����ϴ� �������̵� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID             -- DISTEINCT �ߺ��� ���� �����ϰ� ȭ�鿡 ����ϱ�
FROM EMPLOYEES;

-- ���������̷� ���̺��� ������ �ѹ��̶� ������ ���� �ִ� ������ ���̵� ��ȸ�ϱ�
SELECT DISTINCT EMPLOYEE_ID        -- DISTEINCT �ߺ��� ���� �����ϰ� ȭ�鿡 ����ϱ�
FROM job_history;

/*
    ��ȸ����� �����ϱ�
    SELECT �÷���, �÷���, �÷���, ...
    FROM ���̺��
    [WHERE ���ǽ�]
    [ORDER BY {�÷���|ǥ����} [ASC|DESC]]
    * ORDER BY���� ����ϸ� ��ȸ����� �������� Ȥ�� ������������ ������ �� �ִ�.
    * ORDER BY���� �÷����� ���� �ش� �÷��� ���� �������� ����� �������� Ȥ�� ������������ �����Ѵ�.
    * ���Ĺ����� ASC Ȥ�� DESC�� �����Ѵ� �����ϸ� ASC(��������)�̴�.
    ASC ��������   DESC ��������
    
    ���� �÷��� ���� �������� �����ϱ� 
    SELECT �÷���, �÷���, �÷���, ...
    FROM ���̺��
    [WHERE ���ǽ�]
    [ORDER BY {�÷���|ǥ����} [ASC|DESC], {�÷���|ǥ����} [ASC|DESC]]
*/

-- �������̺��� �������̵�, �̸�, �޿��� ��ȸ�ϰ�, �޿������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;       -- ���������̴ϱ� DESC

-- �������̺��� 60�� �μ��� �Ҽӵ� �������� ���̵�, �̸�, �޿��� ��ȸ�ϰ�,�޿������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE department_id = 60
ORDER BY salary ASC;        -- ���������̴ϱ� ASC

-- �������̺��� 50�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �Ի���, �޿��� ��ȸ�ϰ� �Ի����� ��������
-- �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE department_id = 50
ORDER BY HIRE_DATE ASC;     -- ���������̴ϱ� ASC

-- �������̺��� �������� �������̵�, �̸�, �޿�, �μ����̵��� ��ȸ�ϰ�, �μ����̵� �������� �������� �����ϰ�,
-- �μ����̵� ������ �������� �޿��� �������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY department_id ASC, SALARY DESC;

/*
    WHERE���� ���ǽĿ��� �پ��� ������ ����ϱ�
    
    1. �񱳿�����
        =, !=, >, <, >=, <=
        * ����Ŭ���� not equal�� ��Ÿ���� �����ڴ� !=�� <>�� ����� �� �ִ�.
    2. ��������
        AND, OR, NOT
    3. ��Ÿ ������
        BETWEEN ��1 AND ��2
        
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� BETWEEN ��1 AND ��2;
        * WHERE���� ������ �÷��� ���� ��1���� �̻�, ��2 ������ ���� �����ϱ�
        * WHERE �÷��� BETWEEN ��1 AND ��2
          WHERE �÷��� >= ��1 AND �÷��� <= ��2
          ���� �� ������ �����ϴ�.
          
       IN (��1, ��2, ��3, ...)
          
       SELECT �÷���, �÷���, �÷���, ...
       FROM ���̺��
       WHERE �÷��� IN (��1, ��2, ��3, ...);
       * WHERE������ ������ �÷��� ���� ��1, ��2, ��3 �� �ϳ��� ��ġ�ϸ� ��ȸ�Ѵ�.
       * WHERE �÷��� IN (��1, ��2, ��3, ...)
         WHERE �÷��� = ��1 OR �÷��� = ��2 OR �÷��� = ��3
        ���� �� ������ �����ϴ�.
        
        IS NULL �� IS NOT NULL
        
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� IN NULL;
        + WHERE������ ������ �÷��� ���� NULL�� ���� ��ȸ�Ѵ�.
        
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� IN NOT NULL;
        + WHERE������ ������ �÷��� ���� NULLDL�� �ƴ� ���� ��ȸ�Ѵ�.
        
        LIKE '����'
        
        ���Ϲ���
            '%'     0�� �̻��� ������ ���ڸ� ��Ÿ����.
            '_'     ������ ���� �ϳ��� ��Ÿ����.
            
            ������ '�ڹ�'�� �����ϴ� ������ ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '�ڹ�%'
                * '�ڹ�', '�ڹ��� ����', '�ڹ� ���α׷���'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            ������ '�ڹ�'�� ������ ������ ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '%�ڹ�'
                * '�ڹ�','�����ϸ��� ������ �ڹ�', '����Ƽ�� �ڹ�'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            ���� '�ڹ�'�� ���ԵǾ� �ִ� ������ ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '%�ڹ�%'
                * '�ڹ�', '�ڹ��� ����', '�̰��� �ڹٴ�', '����Ƽ�� �ڹ�'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
                
            ������ '��'���� ���� ��ȸ�ϱ�
                WHERE NAME LIKE '��_%'
                * '��'�� ���� ���ϰ� ��ġ���� �ʴ´�.
                * '�豸','������','����ѹ��ź��̿͵η��'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            '��'���� �̸��� ������ ���� ��ȸ�ϱ�
                WHERE NAME LIKE '��_' 
            '��'���� �̸��� 2������ ���� ��ȸ�ϱ�
                WHERE NAME LIKE '��__' 
        
*/

-- �������̺��� �޿��� 3000�̻� 5000������ ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϰ�,
-- �޿������� �������� �����ϱ�
SELECT EMPLOYEE_ID, FRIST_NAME, JOB_ID, SALARY
FROM employees
WHERE SALARY BETWEEN 3000 AND 5000
ORDER BY SALARY ASC;

-- �������̺��� 2005�⵵�� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϰ�, �Ի��ϼ����� �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005/01/01' AND '2005/12/31'
ORDER BY hire_date ASC;

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY hire_date ASC;

-- �������̺��� �ҼӺμ��� 10�� �̰ų� 20���̰ų� 30���� �޿��� 3000���Ϸ� �޴� 
--������ ���̵�, �̸�, �޿�, �ҼӺμ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, salary, DEPARTMENT_ID
FROM employees
WHERE department_id IN (10,20,30)
AND SALARY <= 3000;

-- �μ����̺��� �����ڰ� ����Ǿ����� ���� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM departments
WHERE manager_id IS NULL;

-- �μ����̺��� �����ڰ� ������ �μ��� ���̵�� �̸��� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, manager_id
FROM DEPARTMENTS
WHERE manager_id IS NOT NULL;

-- �������̺��� �ҼӺμ��� �������� ���� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- �������̺��� �������̵� 'SA'�� �����ϴ� ������ ���̵�, �̸�, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';

-------------------------------------------

-- �������� �����ϴ� ���� ���̵� �ߺ����� ���� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- �ٸ� �����鿡�� ���� �޴� �Ŵ������� ���̵� �ߺ����� ���� ��ȸ�ϱ�
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;


-- ������ ������ ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE manager_id IS NULL;

-- Ŀ�̼��� �޴� ������ �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM employees
WHERE commission_pct IS NOT NULL
AND SALARY >= 10000;

-- 2004�⵵�� ������ ����� ������ ���̵�, �ش� ������ ���� ������, ������, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID
FROM JOB_HISTORY
WHERE START_DATE BETWEEN '2004-01-01' AND '2004-12-31';

-- �ѹ��̶� ������ ����� ���� �ִ� �������� ���� ���̵� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT EMPLOYEE_ID        -- DISTEINCT �ߺ��� ���� �����ϰ� ȭ�鿡 ����ϱ�
FROM job_history;

-- ���� �߿��� 100�� ��翡�� �����ϰ�, Ŀ�̼��� ������, �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = 100 
AND COMMISSION_PCT IS NOT NULL;
--AND SALARY >= 10000                -- �̰Ż��Ծ��� ����

-- ���� �߿��� 2006�� ��ݱ⿡ �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϰ�, �Ի��� ������ �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2006-01-01' AND '2006-06-30'   
-- WHWER HIRE DATE >= '2006-01-01' AND HIRE_DATE , '2006-07-01'
ORDER BY HIRE_DATE ASC;

-- ���� �߿��� �ҼӺμ��� 50, 60, 80�� �μ� ���� �ϳ��� ���ϰ�, 100�� �������� �����ϴ� ������ ���̵�, �̸�, �������̵�, �μ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50,60,80) AND MANAGER_ID = 100;

-- ���� �߿��� �������̵�  'CLERK'�� ������, �޿��� 2000�� �̻� �޴� ������ ���̵�, �̸�, �޿�, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%CLERK' AND SALARY >= 2000;

-- �μ� ������ �������� �Ϻ��� ��ġ�ϰ� �ִ� �������� ���̵�, �ּ�, �����ȣ, ���ø��� ��ȸ�ϱ�
SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY
FROM LOCATIONS
WHERE COUNTRY_ID = 'JP';

-- �μ� ������ �������� �����ȣ�� ������ �������� ���̵�, �ּ�, ���ø��� ��ȸ�ϱ�
SELECT location_id, street_address, city 
FROM LOCATIONS
WHERE postal_code is null;

-- ���� �߿��� �̸��� 'S'�� �����ϴ� ������ ���̵�, �̸��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';

-- 50�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿��� ��ȸ�ϰ� �޿������� �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY SALARY ASC;



