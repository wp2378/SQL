/*
���� ������
    ���� �����ڸ� �̿��ϸ� ���� ���� SQL�� ��ȸ ����� �����Ͽ� �ϳ��� ����� ���� �� �ִ�.
    ���� ���� �ٸ� ���̺��� ������ ������ ����� ��ȯ�ϴ� ���� �ϳ��� ����� ��ĥ �� ����Ѵ�.
    Ȥ�� ������ ���̺� ���ؼ� ���� �ٸ� SQL�� ��ȸ�� �����Ͽ� ����� �ϳ��� ��ĥ �� ����Ѵ�.
    
    SELECT �÷�, �÷�, �÷�,
    FROM ���̺�1
    [WHERE ���ǽ�]
    ���տ�����
    SELECT �÷�, �÷�, �÷�
    FROM ���̺�2
    [WHERE ���ǽ�]
    
    ������
        1. SELECT���� �÷����� �����ؾ� �Ѵ�.
        2. SELECT���� ������ ��ġ�� �����ϴ� �÷��� ������ Ÿ���� ��ȣ ȣȯ �����ؾ� �Ѵ�.
        (������ Ÿ���� ������ ��쿡�� �ݵ�� �ʿ�� ����.)
        
     ����
        UNION
            ���� SQL���� ��� ���� �������̴�.
            ��� �ߺ��� ���� �ϳ��� ������ �����.
        UNION ALL
            ���� SQL���� ��� ���� �������̴�.
            �ߺ��� �൵ �׷��� ǥ�õȴ�.
            ���� SQL���� ����� �ܼ��� ���ĳ��� ����� �����.
        INTERSECT
            ���� SQL���� ����� ���� �������̴�.
            �ߺ��� ���� �ϳ��� ������ �����.
        MINUS
            ���� SQL���� ������� ���� SQL���� ����� ���� �������̴�.
            �ߺ��� ���� �ϳ��� �����.
            SQL�� ������ ���� ����� �ٸ��� ���´�.

*/


-- UNION�� UNION ALL
-- Ŀ�̼��� �޴� ������ Ŀ�̼��� ���� �ʴ������� ��� ��ȸ�ϱ�
-- ���տ����� �ǽ��� ���� SQL�̱� ������ ���� ���� �ƴ�
SELECT EMPLOYEE_ID AS EMP_ID, FIRST_NAME AS EMP_NAME, COMMISSION_PCT AS EMP_COMM
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
UNION
SELECT EMPLOYEE_ID, FIRST_NAME, 0
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL;

-- UNION ALL
-- ������ ����� ���� �ִ� ������ ����� ���� ���� ������ ��� ��ȸ�ϱ�
-- * ������ ����� ���� ���� ���������� EMPLOYEE ���̺��� ��ü ��ȸ�ϴ� ������ ����Ѵ�.
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'P' JOB_STATUS
FROM JOB_HISTORY
UNION ALL
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'C'
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID ASC;


-- INTERSECT
-- �޿��� 5000�޷� ���ϸ� ���� ������ ���հ� ������ ����� ���� �ִ� ������ ������ ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID 
FROM EMPLOYEES
WHERE SALARY <= 5000
INTERSECT
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;

-- �������� ���ϴ� ���տ����ڴ� IN �������� Ȥ�� EXISTS ���������� ����� �� �ִ�.
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY <= 5000
AND EMPLOYEE_ID IN (SELECT EMPLOYEE_ID
                    FROM JOB_HISTORY);
                    
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE SALARY <= 5000
AND EXISTS (SELECT 'X'
            FROM JOB_HISTORY H
            WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID);

/*
EXISTS ������
    ������ �������� ������.
    
    + EXISTS (��������)���� ���������� ������ �����ϴ� �����Ͱ� ���� ���� �ִٰ� �ϴ��� ������
      �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.
    + ���� ������Ʈ���� Ư�� ������ �����ϴ��� ���θ� ���� ������ ���� ���Ǵµ�,
      COUNT(*)�� ������ �����ϴ� ���� ������ ��ȸ�ϱ� ���� SQL ���� ���ɿ� ���ڴ�.
      ����, EXISTS�����ڸ� ����� �� �ִ��� ����ؾ� �Ѵ�.
    + EXISTS (��������)���� SELECT������ ���������� �ǹ̾��� ����� (1, 'X')�� ��ȯ�ϵ��� �Ѵ�.
    
    ����
        SELECT A.�÷�, A.�÷�, A.�÷�...
        FROM ���̺�� A
        WHERE EXISTS (��������)
        
        UPDATE ���̺�
        SET
            �÷��� = ��,
            �÷��� = ��,
            ..
        WHERE EXISTS (��������)
        
        *���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� �����ڴ�.
         ������ �����ϴ� �����Ͱ� ���� ���̶� �ϴ���, 1�Ǹ� ã���� ���̻� �˻��� ���� �ʴ´�.
         
    
*/

-- ���� ������ �̷��� �ִ��� ���� üũ�ϱ�              
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE 0 < (SELECT COUNT(*)
           FROM JOB_HISTORY H
           WHERE H.EMPLOYEE_ID = E. EMPLOYEE_ID);

SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE EXISTS (SELECT 'X'
              FROM JOB_HISTORY H
              WHERE H.EMPLOYEE_ID = E. EMPLOYEE_ID);

-- �ֱ� 6������ �����̷��� �ִ� ������ ������ �����Ѵ�.
UPDATE CUSTOMERS C
SET
    C.CUSTOMER_GIFT_COUPON = 'Ŀ������'
WHERE
    C.CUSTOMER_DELETED = 'N'
    AND EXISTS (SELECT 1
                FROM ORDERS O
                WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
                AND O.ORDER_DATE > ADD_MONTHS(SYSDATE, -6));
                
-- Neena�� ���� �μ����� ���ϴ� ���� ��ȸ�ϱ�                
SELECT *
FROM EMPLOYEES
WHERE EXISTS (SELECT 1
              FROM EMPLOYEES
              WHERE FIRST_NAME = 'Neena');

-- WHERE �÷� ������ (��������) : �÷����� �񱳰����� �ǹ��ִ� ���� ���������� �����ؾ� �Ѵ�.
-- WHERE ��   ������ (��������) : ���õ� ���� �񱳰����� �ǹ��ִ� ���� ���������� �����ؾ� �Ѵ�.
-- WHERE EXISTS    (��������) : ���������� �ǹ��ִ� ���� �������� �ʾƵ� �ȴ�.
--                            �ǹ̾��� ������� ��ȯ�ص� �ȴ�.



-- MINUS
-- ������ �ѹ��� ����� ���� ���� �������� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;


