/*
������ �Լ� - ��Ÿ �Լ�

NVL(�÷�, ��ü��)
    NVL�Լ��� NULL���� �ٸ� ������ ��ȯ�Ѵ�.
    ������ �÷��� ���� NULL�ƴ� ��쿡�� �ش� �÷��� ���� ��ȭ�Ѵ�.
    �ش� �÷��� ��ü���� ������ Ÿ���� ������ Ÿ���̾���Ѵ�.
    
NVL2(�÷�, ��ü��1, ��ü��2)
    ������ �÷��� ���� NULL�� �ƴϸ�, ��ü��1�� ��ȯ�ǰ�, NULL�̸� ��ü��2�� ��ȯ�ȴ�.
    ��ü��1�� ��ü��2�� ������ Ÿ���� ������ Ÿ���̾�� �Ѵ�.

*/

-- ��� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�Ѵ�.
-- Ŀ�̼��� NULL�̸� 0�� ��ȯ�Ѵ�.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, NVL(COMMISSION_PCT, 0) COMM
FROM EMPLOYEES;

-- ��� ������ ���̵�, �̸�, �޿�, Ŀ�̼�, Ŀ�̼��� ���Ե� �޿��� ��ȸ�ϱ�
-- Ŀ�̼��� ���Ե� �޿� = �޿� + (�޿�*Ŀ�̼�)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT,
       SALARY + (SALARY*NVL(COMMISSION_PCT, 0))
FROM EMPLOYEES;

-- ��� �μ��� �μ����̵�, �̸�, �����ھ��̵� ��ȸ�ϱ�
-- ��, �����ڰ� �������� ���� �μ��� '�����ھ���'���� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, NVL(TO_CHAR(MANAGER_ID), '�����ھ���')
FROM DEPARTMENTS;

/*
    ������ �Լ� - ��Ÿ�Լ�

DECODE �Լ�
    DECODE(�÷�, �񱳰�1, ��1,
                �񱳰�2, ��2
                �񱳰�3, ��4
                ��4)
    * ������ �÷��� ���� �񱳰�1�� ������ ��1�� ��ȯ�ȴ�.
                   �񱳰�2�� ������ ��2�� ��ȯ�ȴ�.
                   �񱳰�3�� ������ ��3�� ��ȯ�ȴ�.
                   ��ġ�ϴ� ���� ������ �⺻���� ��ȯ�ȴ�.
    * DECODEM�Լ��� �÷��� ���� �񱳰����� EQUALS �񱳸� �����ϴ�               
    
                   
                   
CASE ~ WHEN ǥ����
    CASE
        WHEN ���ǽ�1 THEN ��1
        WHEN ���ǽ�2 THEN ��2
        WHEN ���ǽ�3 THEN ��3
        ELSE ��4
    END
    * ���ǽ�1�� TRUE�� �����Ǹ� THEN�� �������� �ȴ�.
    * ��� ���ǽ��� FALSE�� �����Ǹ� ELSE�� ��4�� �������� �ȴ�.
    * ���ǽĿ����� =, >, >=, <, <=, != ���� �پ��� �����ڸ� ����ؼ� �ۼ��� �� �ִ�.
    * DECODE�Լ��� ������ �� �� �پ��� ������ ������ �� �ִ�.
    
    CASE �÷�
        WHEN �񱳰�1 THEN ��1
        WHEN �񱳰�2 THEN ��2
        WHEN �񱳰�3 THEN ��3
        ELSE ��4
    END
    * ������ �÷��� ���� �񱳰��� �� �ϳ��� ��ġ�ϸ� �ش� THEN�� ���� �������� �ȴ�.
    * ��� �񱳰��� ��ġ���� ������ ELSE�� ��4�� �������� �ȴ�.
    * DECODE �Լ��� ��ɸ鿡�� �����ϴ�.
*/

-- ��� �������̺��� �޿��� 5000���ϸ� ���ʽ��� 1000�����ϰ�,
--                 �޿��� 10000���ϸ� ���ʽ��� 2000�����ϰ�,
--                 �� �ܴ� 3000�� �����Ѵ�.
-- ��� ������ ���ؼ� �������̵�, �̸�, �޿�, ���ʽ��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,
        CASE
            WHEN SALARY <= 5000 THEN 1000
            WHEN SALARY <= 10000 THEN 2000
            ELSE 3000
        END BONUS
FROM EMPLOYEES;

-- ��� ������ ���ؼ� �μ� ���̵� �������� ���� �����ϱ�,
-- 10, 20, 30 �μ��� A��, 40, 50, 60�� �μ��� B��, �� �ܴ� C��
-- �������̵�, �̸�, �μ����̵�, ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME,DEPARTMENT_ID,
        CASE
            WHEN DEPARTMENT_ID IN(10, 20, 30) THEN 'A'
            WHEN DEPARTMENT_ID IN(40, 50, 60) THEN 'B'
            ELSE 'C'
        END AS TEAM
FROM EMPLOYEES;

-- ���� ���̺��� �������̵𺰷� �������� ��ȸ�ϱ�
-- 1�� ����, 2�� �Ƹ޸�ī, 3�� �ƽþ�, 4�� ������ī �� �ߵ�
SELECT REGION_ID,
        CASE
            WHEN REGION_ID = 1 THEN '����'
            WHEN REGION_ID = 2 THEN '�Ƹ޸�ī'
            WHEN REGION_ID = 3 THEN '�ƽþ�'
            WHEN REGION_ID = 4 THEN '������ī �� �ߵ�'
        END REGION_NAME
FROM REGIONS;

SELECT REGION_ID,
        CASE REGIOND_ID
            WHEN 1 THEN '����'
            WHEN 2 THEN '�Ƹ޸�ī'
            WHEN 3 THEN '�ƽþ�'
            WHEN 4 THEN '������ī �� �ߵ�'
        END REGION_NAME
FROM REGIONS;

-- DECODE�� �̿��ؼ�
-- ���� ���̺��� �������̵𺰷� �������� ��ȸ�ϱ�
-- 1�� ����, 2�� �Ƹ޸�ī, 3�� �ƽþ�, 4�� ������ī �� �ߵ�
SELECT REGION_ID,
       DECODE(REGION_ID, 1, '����',
                         2, '�Ƹ޸�ī',
                         3, '�ƽþ�',
                         4, '������ī �� �ߵ�') AS REGION_NAME
FROM REGIONS;

-- �μ� ���̺��� �μ����̵�, �μ���, ������ �̸��� ��ȸ�ϱ�
-- �����ڰ� �����Ǿ� ���� ������ �������� ��Ⱥ��.
SELECT B.DEPARTMENT_ID, B.DEPARTMENT_NAME,
        CASE
            WHEN B.MANAGER_ID IS NOT NULL THEN (SELECT A.FIRST_NAME 
                                                FROM EMPLOYEES A 
                                                WHERE A.EMPLOYEE_ID = B.MANAGER_ID)
            ELSE '����'
        END MANAGER_NAME
FROM DEPARTMENTS B;