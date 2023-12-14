/*
��(������ ���̺�)
    ���̺� Ȥ�� �ٸ� �並 ������� �����ϴ� ������ ���̺��̴�.
    �������� ��������� ������ �ʴ´�.
    �並 ������� INSERT, UPDATE, DELETE �۾��� �����ϱ� ��ƴ�.
    �並 ������� SELECT �۾��� �ַ� �����Ѵ�.
    
    �並 Ȱ���ϸ� ������ SQL�۾��� �ܼ��� SQL������ ����� �� �ִ�.
    ������ �����ͷ� �پ��� ����� ���� �� �ִ�.
    ������ �׼����� ������ �� �ִ�.
    
    
    
    
�� �����ϱ�
    CREATE OR REPLACE VIEM ���̸� 
    AS ��������
    WITH READ ONLY;
*/

-- �μ��� ���� �������� �����ϴ� �� �����ϱ�
-- �μ����̵�, �μ���, ������ ���̵�, ������ �̸�,
-- ������ ���̵�, ������ ����, �����ȣ, �ּ�, ������, �������� �����Ѵ�.
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

SELECT * -- �μ����̵�, �μ���, �������̸�, ���絵�ø�
FROM DEPT_DETAIL_VIEW
WHERE DEPARTMENT_ID = 60;

/*
�ζ��� ��
    SELECT���� FROM���� ���ǵ� ��������(SLEECT��)���� �����Ǵ� ������ ���̺��̴�.
    ����Ŭ�� �����ͺ��̽� ��ü�� �ƴϱ� ������ SQL���� ����Ǵ� ���ȸ� ��� ���ܳ��ٰ�
    ������� ������ ���̺��̴�.
    * ��� CREATE������ �����Ǵ� ����Ŭ�� �����ͺ��̽� ��ü��.
    
    
    ����
        SELECT �÷���, �÷���
        FROM (SELECT �÷���, �÷���
              FORM ���̺��
               WHERE ���ǽ�) A
*/

-- �μ����̵�, �μ���, ������� ��ȸ�ϱ�
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

-- �μ��� �����޿��� �޴� ����� ���̵�, �̸�, �μ����̵�, �޿��� ��ȸ�ϱ�
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
�ε���(����)
    ������ �˻� �ӵ��� ����Ű�� ���ؼ� ���Ǵ� �����ͺ��̽� ��ü��.
    �ε������� �÷��� ���� ROWID(�������� ������ġ ����)�� ����Ǿ� �ִ�.
    * ROWID�� ���������� ����� ���Ϲ�ȣ/��Ϲ�ȣ/���Թ�ȣ�� �����ϰ� �ִ�.
    �ε����� ���̺�� ���������� �����ϰ�, �ѹ� ������ �ε����� �ڵ����� �����ȴ�. 
    
    �ε��� ����
        �ڵ�����
            PRIMARY KEY, UNIQUE ���������� ����� �÷��� �ڵ����� �ε����� �����ȴ�.
        ��������
            WHERE���� ���ǽ����� ���� �����ϴ� �÷��� ��ȸ ������ ����Ű�� ���ؼ�
            �ش� �÷��� ���� �ε����� ������ �� �ִ�.
            
    �ε��� ������ �����Ѱ��
        WHERE���� ���ǽ����� ���� �����ϴ� ��� �ε����� ��������.
        �÷��� �ſ� �پ��� ���� �����ϰ� �ִٸ� �ε����� ��������.
        �����Ͱ� �ſ� ���� ���̺��� ������� �����͸� ��ȸ���� �� ��ȸ�۾��� �� �� ����
        ��ü �������� 2% �̸����� �����Ͱ� ��ȸ�Ǵ� ��� �ش� �÷��� �ε����� ��������.
            
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

-- �ε��� �����ϱ�
CREATE INDEX ENP_FIRSTNAME_IDX
ON EMPLOYEES (FIRST_NAME);
      
      
      
      
      
      
      
      
      
      