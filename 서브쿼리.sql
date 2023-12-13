/*
���������� ����
    - ������ ��������
        �������� �������� �� ���� ȹ��ȴ�.(1��1�� �����͸� ��ȯ�ϴ� ��������)
        ������
            =, !=, >=, >, <, <=, IN
    - ������ ��������
        �������� �������� ���� ���� ȹ��ȴ�.(N��1�� �����͸� ��ȯ�ϴ� ��������)
            IN, NOT IN, > ANT, >ALL, >= ANY, >=ALL,
                        < ANY, <ALL, <= ANY, <=ALL
    - ���߿� ��������
        �������� �������� ���� ���� �÷����� ȹ��ȴ�.(N��N�� �����͸� ��ȯ�ϴ� ��������)
        ������
            IN, NOT IN
*/  

-- ������ ��������
-- 'Neena'���� ����޴� ���� ���� ��翡�� �����ϴ� ������ ���̵�,�̸��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAEM
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT MANATEG_ID
                    FROM EMPLOYEES
                    WHERE EMPLOYEE_ID = 101);
                    
--101�� �������� �޿��� ���� �޴� �������̵�, �̸� �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 101);
                
-- ������ ��������
-- Steven'�� ���� �ؿ� �Ի��� ������ �����̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (SELECT TO_CHAR(HIRE_DATE,'YYYY')
                               FROM EMPLOYEES
                               WHERE FIRST_NAME = 'Steven');
                               
-- 60�� �μ��� �Ҽӵ� �������� �޿����� �޿��� ���� �޴� �������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
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
                
--  ���߿� ����
-- �� �μ��� ���� �޿��� �޴������� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  WHERE DEPARTMENT_ID IS NOT NULL
                                  GROUP BY DEPARTMENT_ID);
                                  
/*
��ȣ���� ��������
    ������������ ���������� �����ϸ� ������� ���������� �´�.
    ����
        SELECT OUTER.COLUNM, OUTER.COLUMN
        FROM TAVLE OUTER
        WHERE OUTER.COLUMN ������(SELECT INNER.COULMN
                                 FROM TABLE INNER
                                 WHERE INNTER.COULUM = OUTER.COLUMN);
    �Ϲݼ�ũ������ ��ȣ�������������� �ٸ���
        ���������� ������������ ���� ����ȴ�.
        ���������� �� �ѹ� ����ȴ�.
        
        ��ȣ���� ���������� �������������� ó���Ǵ� �� �࿡ ���ؼ� �ѹ��� ����ȴ�.
*/

-- ������ �߿��� �ڽ��� �Ҽӵ� �μ��� ��ձ޿����� �޿��� ���� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT X.EMPLOYEE_ID, X.FIRST_NAME, X.SALARY
FROM EMPLOYEES X
WHERE X.SALARY > (SELECT AVG(Y.SALARY)
                 FROM EMPLOYEES Y
                 WHERE Y.DEPARTMENT_ID = X.DEPARTMENT_ID);
                 
-------------------------------------------------
--EMPLOYEE_ID   FIRST__NAME    DEPARTMENT_ID   SALARLY
--100           ȫ�浿          10              1000       ���������� X.DEPARTMENT_ID�� 10�� �����ȴ�.
--101           ������          10              2000       ���������� X.DEPARTMENT_ID�� 10�� �����ȴ�.
--102           ������          20              2000       ���������� X.DEPARTMENT_ID�� 20�� �����ȴ�.
--103           �̼���          20              4000       ���������� X.DEPARTMENT_ID�� 20�� �����ȴ�.
--104           ������          30              1000       ���������� X.DEPARTMENT_ID�� 20�� �����ȴ�.
---------------------------------------------------

-- �μ����̵�, �μ��̸�, �ش�μ��� �Ҽӵ� �������� ��ȸ�ϱ�
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

-- �������̵�, �����̸�, ����� ���̵�, ����� �̸��� ��ȸ�ϱ�
SELECT X.EMPLOYEE_ID                        AS EMP_ID,
       X.FIRST_NAME                         AS EMP_NAME,
       X.MANAGER_ID                         AS MGR_ID,
       (SELECT Y.FIRST_NAME
        FROM EMPLOYEES Y
        WHERE Y.EMPLOYEE_ID = X.MANAGER_ID) AS MGR_NAME
FROM EMPLOYEES X;