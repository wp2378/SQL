/*
Ʈ�����
    �����ͺ��̽��� ���¸� ��ȯ��Ű�� �ϳ��� ������ ����� �����ϱ� ���� �۾��� ������.
    ��) ȫ�浿�� �̼��Ŀ��� 1000������ �����Ѵ�.
        1. ȫ�浿�� ���¿��� �ܾ��� 100���� ���ҽ�Ų��. - UPDATE�۾�
        2. �̼����� ���¿��� �ܾ��� 100���� ������Ų��. - UPDATE�۾�
        3. ȫ�浿�� �ֱ� ��ü������ �̼��ſ��� 100���� �۱��� ������ �߰��Ѵ�. ==  INSERT�۾�
        
        ������ �ۿ��� ����(�׷�, ����, �����) = ���� UPDATE + ���� UPDATE 9 �߰� INSERT
        ������ �۾��� ������ �����ϴ� ���SQL����� ���������� �Ϸ�Ǿ�� �ϳ��� �۾� ������ 
        �Ϸ�� ���̰�, �� ��쿡 �����ͺ��̽��� �ݿ���Ų��.
        
    Ʈ����� ���� ��ɾ�
        COMMIT 
            ������ �۾� ������ �����ϴ� ��� �۾��� ���������� �Ϸ�Ǿ��� ��,
            �����ͺ��̽���Ʈ����� �����ڿ���
            �ش� �۾� ���������� �����ߴ� ó�� ����� ���������� �����ͺ��̽��� �ݿ���Ų��.
        ROLLBACK
        ������ �۾� ������ �����ϴ� �۾� �߿��� ������ �߻����� ��
        �����ͺ��̽��� Ʈ����� �����ڿ���
        �ش� �۾� ���������� �����ߴ� ó�� ����� �����ͺ��̽� �ݿ��� ��ҽ�Ű�� �Ѵ�.
        
    Ʈ������� ���۰� ����
        Ʈ������� ����
            - ù��° DML, ��ɹ��� ����ɶ� ���ο� Ʈ������� ���۵ȴ�.
            - COMMIT, ORLLBACK ����� �����ϸ� ���� Ʈ������� ����ǰ�, ���ο� Ʈ������� ���۵ȴ�.
        Ʈ������� ����
            - COMMIT, ROLLBOOK ����� �����ϸ� ���� Ʈ������� ����ȴ�.
            - DBMS�� �ý��� ��ְ� �߻��� �� AUTO-ROLLBACK�� ����Ǹ鼭 Ʈ������� ����ȴ�.
            
*/

-------------------------------------------------------------- Ʈ�����1�� ���۵�
UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOSIT - 1000000
WHERE
 NO = 10;                             // Ʈ�����1�� �����̴�
 
 UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOSIT + 1000000
WHERE
 NO = 20;                            // Ʈ�����1�� �����̴�
 
 INSERT INTO HISTORIES
 VALUES (10,20,1000000, SYSDATE);    // Ʈ�����1�� �۾��̴�._
 
 COMMIT;                            // Ʈ�����1�� ��� ������ �������� ����Ǿ��� ������
                                    // Ʈ����ǰ����ڿ��� Ʈ�����1�� ó�������
                                    // ���������� �����ͺ��̽��� �ݿ���Ű���� �Ѵ�.
---------------------------------------------------------------- Ʈ�����1 ����
---------------------------------------------------------------- Ʈ�����2 ����

UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOST - 50000
WHERE
    NO = 70;                        // Ʈ�����2�� �����̴�
    
UPDATE ACCOUNTS
SET
    DEPOSIT = DEPOST + 50000
WHERE
    NO = 120;                       // Ʈ�����2�� �����̴�
 
INSERT INTO HISTORIES
VALUES (70, 120, 50000);            // Ʈ�����2�� �����̴�       
 
 ROLLBACK;                          // Ʈ�����2�� INSERT �۾��� ������ �߻��Ͽ���.
                                    // Ʈ����ǰ����ڿ��� Ʈ�����2�� ó�������
                                    // ��� ��ҽ�Ű���� �Ѵ�.
----------------------------------------------------------------- Ʈ�����2�� �����
----------------------------------------------------------------- Ʈ�����3�� �����
 
 ----------------------------------------------------------------------------------------
-- ��� ������ ���̵�, �̸�, �μ���ȣ, �μ����� ��ȸ�ϱ�(�����)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME, 
       D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Ŀ�̼��� �޴� ������ ���̵�, �̸�, �������̵�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- Ŀ�̼��� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼�, �޿������ ��ȸ�ϱ�(������)
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

-- 80�� �μ��� �Ҽӵ� �������� ��ձ޿�, �����޿�, �ְ�޿��� ��ȸ�ϱ�(�׷��Լ�)
SELECT DEPARTMENT_ID, TRUNC (AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IN (80);

-- 80�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, ��������, �޿�, �ְ�޿��� �޿����� ���̸� ��ȸ�ϱ�(�����)
SELECT E.EMPLOYEE_ID, 
       E.FIRST_NAME,
       E.JOB_ID,
       E.SALARY,
       (J.MAX_SALARY-E.SALARY)  AS �ְ�޿�������
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
AND DEPARTMENT_ID = 80;

-- �� �μ��� �ְ�޿�, �����޿�, �ְ�޿��� �����޿��� ���̸� ��ȸ�ϱ�(GROUP BY)
SELECT DEPARTMENT_ID, MAX(SALARY), MIN(SALARY), (MAX(SALARY)-MIN(SALARY)) AS �ְ������޿���������
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 'Executive' �μ��� ��� �������̵�, �̸�, �������̵� ��ȸ�ϱ�(�������� Ȥ�� ����)
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

-- ��ü ������ ��ձ޿����� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�(��������)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- 'Ismael'�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϰ� �ִ� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�(��������)
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = (SELECT TO_CHAR(HIRE_DATE, 'YYYY')
                                    FROM EMPLOYEES
                                    WHERE FIRST_NAME = 'Ismael');

-- �μ��� �ְ�޿��� ��ȸ���� �� �ְ�޿��� 15000�� �Ѵ� �μ��� ���̵�� �ְ�޿��� ��ȸ�ϱ�(GROUP BY, HAVING)
SELECT DEPARTMENT_ID, MAX(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING MAX(SALARY) > 15000;

-- 'Neena'���� �޿��� ���� �޴� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�(��������)
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE FIRST_NAME = 'Neena');

-- �޿���޺��� �������� ��ȸ�ϱ�(������, GROUP BY)

-- �μ��� ��ձ޿��� ������� �� �μ��� ��ձ޿����� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿�, �μ����� ��ȸ�ϱ�(�ζ��κ�, ����)

-- 'Ismael' ������ �ٹ��ϴ� �μ��� ���̵�� �̸��� ��ȸ�ϱ�(��������)

-- 'Neena'���� �����ϴ� ������ ���̵�� �̸��� ��ȸ�ϱ�(��������)

-- �μ��� ��ձ޿��� ������� �� 'Ismael'�� �ٹ��ϴ� �μ��� ��ձ޿����� �޿��� ���� �޴� �μ��� ���̵�� ��ձ޿��� ��ȸ�ϱ�(GROUP BY, �ζ��κ�, ��������)
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES E
WHERE E.AVG(SALARY) > (SELECT AVG(SALARY)
                       FROM EMPLOYEES E1, EMPLOYEES E2
                       WHERE E1.FIRST_NAME = E2.SALARY
                       AND FIRST_NAME = 'Ismael');
 
 
 
 
 
 
 
 
 
 
 