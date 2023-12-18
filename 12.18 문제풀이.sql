--employees ���̺��� ������� ��� �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES;
--�޿��� 12,000�޷� �̻� �޴� ����� �̸��� �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 12000;
--�����ȣ�� 176�� ����� ���̵�� �̸� ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID 
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 176;
--�޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� ������� ��� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 12000
AND 15000 >= SALARY; 
--2005�� 1�� 1�Ϻ��� 2005�� 6�� 30�� ���̿� �Ի��� ����� ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005/01/01'
AND '2005/07/01' > HIRE_DATE;
--�޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ����� �̸��� �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY <= 12000
AND 5000<= SALARY
AND DEPARTMENT_ID IN(20,50);
--�����ڰ� ���� ����� �̸��� �������̵� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;
--Ŀ�̼��� �޴� ��� ����� �̸��� �޿�, Ŀ�̼��� �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES  
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY,COMMISSION_PCT DESC;

--�̸��� 2��° ���ڰ� e�� ��� ����� �̸��� ��ȸ�ϱ�
SELECT FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE '_e%';
--�������̵� ST_CLERK �Ǵ� SA_REP�̰� �޿��� 2,500�޷�, 3,500�޷�, 7,000�޷� �޴� ��� ����� �̸��� �������̵�, �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN ('ST_CLERK','SA_REP')
AND SALARY IN (2500,3500,7000);

--��� ����� �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
SELECT FIRST_NAME, HIRE_DATE, TRUNC ((SYSDATE - HIRE_DATE)/12) AS �ٹ�������
FROM EMPLOYEES
ORDER BY �ٹ������� ASC;
--����� �̸��� Ŀ�̼��� ��ȸ�ϱ�, Ŀ�̼��� ���� �ʴ� ����� '����'���� ǥ���ϱ�
SELECT FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;
--��� ����� �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, 
       E.DEPARTMENT_ID, 
       D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);
--80���μ��� �Ҽӵ� ����� �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
SELECT E.FIRST_NAME,
       E.JOB_ID, 
       J.JOB_TITLE, 
       D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID
AND D.DEPARTMENT_ID = '80';
--Ŀ�̼��� �޴� ��� ����� �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
SELECT E.FIRST_NAME,
       E.JOB_ID,
       J.JOB_TITLE,
       D.DEPARTMENT_NAME,
       L.CITY
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND E.COMMISSION_PCT IS NOT NULL;
--������ �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE D.LOCATION_ID = L.LOCATION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID
AND C.REGION_ID = 1;
--����� �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, 
       D.DEPARTMENT_NAME, 
       E.SALARY, 
       S.GEADE
FROM EMPLOYEES E, DEPARTMENTS D, SALARY_GRADES S
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.SALARY > S.MIN_SALARY
AND S.MAX_SALARY > E.SALARY;

--����� �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, �ҼӺμ��� ���� ����� �ҼӺμ��� '����, �����ڸ� '����'���� ǥ���ϱ�
SELECT E.FIRST_NAME, D.DEPARTMENT_NAME, D.MANAGER_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--��� ����� �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
SELECT MAX(SALARY), MIN(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY FIRST_NAME;
--������ �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
SELECT JOB_ID, MAX(SALARY), MIN(SALARY), SUM(SALARY), AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
--�� ������ ������� ��ȸ�ؼ� ���� ������� ���� ���� 3���� ��ȸ�ϱ�, �������̵�� ����� ǥ���ϱ�
--�����ں� ������� ��ȸ�ϱ�, ������ �̸��� �� �����ڰ� �����ϴ� ����� ǥ���ϱ�
--�� �μ��� ���� �μ��̸�, ������ �̸�, �Ҽӻ�� ��, �Ҽӻ������ ��� �޿��� ��ȸ�ϱ�
--Steven King�� ���� �μ��� ���� ����� �̸��� �Ի����� ��ȸ�ϱ�
--�Ҽ� �μ��� ��ձ޿����� ���� �޿��� �޴� ����� ���̵�� ����̸�, �޿�, �� �μ��� ��� �޿��� ��ȸ�ϱ�
--Kochhar�� ������ �޿� ��� ����� �̸��� �Ի��� �޿��� ��ȸ�ϱ�, ����� Kochhar�� ���Խ�Ű�� �ʱ�
--�Ҽ� �μ��� �Ի����� ������, �� ���� �޿��� �޴� ����� �̸��� �ҼӺμ���, �޿��� ��ȸ�ϱ�
--������ ���̵�, �����ڸ�, �� �����ڰ� �����ϴ� �����, �� �����ڰ� �Ҽӵ� �μ��� ��ȸ�ϱ�