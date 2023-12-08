/*
���� �Լ�

LOWER(�÷� Ȥ�� ǥ����) : �ҹ��ڷ� ��ȯ�� ���ڸ� ��ȯ�Ѵ�
UPPER(�÷� Ȥ�� ǥ����) : �빮�ڷ� ��ȯ�� ���ڸ� ��ȯ�Ѵ�.

CONCAT(�÷� Ȥ�� ǥ����, �÷� Ȥ�� ǥ����) : �� ���ڿ��� �����ؼ� ��ȯ�Ѵ�.

LENGTH(�÷� Ȥ�� ǥ����) : ���ڿ��� ���̸� ��ȯ�Ѵ�.

SUBSTR(�÷� Ȥ�� ǥ����, ������ġ, ����) : ���ڿ��� ������ġ���� ���̸�ŭ �߶� ��ȯ�Ѵ�.
                                     ������ġ�� 1���� �����Ѵ�.
                                     
INSTR(�÷� Ȥ�� ǥ����, ���ڿ�) : ������ ���ڿ��� ������ġ�� ��ȯ�Ѵ�.

TRIN(�÷� Ȥ�� ǥ����) : ���ʿ��� �¿� ������ ���ŵ� ���ڿ��� ��ȯ�Ѵ�.

LPAD(�÷� Ȥ�� ǥ����, ����, ����) : �÷� Ȥ�� ǥ������ ���̰� ������ ���̺���
                                ª���� ������ ���̸�ŭ ���ʿ� ������ ���ڰ� ä���� ���ڿ��� ��ȯ�ȴ�.
*/

-- 60�� �μ��� �Ҽӵ� �������� �̸��� �ҹ���, �빮�ڷ� ��ȸ�ϱ�
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--60�� �μ��� �Ҽӵ� �������� FIRST_NAME�� LAST_NAME�� �����ؼ� ��ȸ�ϱ�
SELECT CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 60�� �μ��� �Ҽӵ� �������� FIRST_NAME�� LAST_NAME�� �����ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME ||  ' ' || LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--60�� �μ��� �Ҽӵ� �������� �̸��� �̸��� ���̸� ��ȸ�ϱ�
SELECT FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- �̸��� 6���� �̻��� ��� �������� �������̵�� �̸��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 6;

-- SAMPLE_BOOKS���� �����̸��� ��ȸ�ϰ�, �̸��� ù��° ���ڵ� ��ȸ�ϱ�
SELECT BOOK_WRITER, SUBSTR(BOOK_WRITER,1 1)
FROM SAMPLE_BOOK;

-- ��ȭ��ȣ���� ������ ��ȸ�ϱ�
SELECT SUBSTR('22)1234-5678', 1, INSTR('031}1234-5678', ')') -1)
FROM DUAL;

-- DUAL�� ����Ŭ���� �����ϴ� DUMMY ���̺��̴�.
-- DUAL�� 1�� 1��¥�� ���̺��̴�.
-- ���� ���̺� ��ȸ���� ������ ������ ������ �� �̿��Ѵ�.
SELECT *
FROM DUAL;

SELECT TRIM('       HELLO WORLD!       ')
FROM DUAL;

-- ���ʿ��� �¿� ������ ���ŵ� ���ڿ��� ��ȸ�ϱ�
SELECT TRIM('           HELLO WORLD!    ')
FROM DUAL;

-- ������ ���̸�ŭ ���ڿ��� ���ʿ� '0'�� ä���� ��ȸ�ϱ�
SELECT LPAD('100', 10, '0')
FROM DUAL;

/*
���� �Լ�

ROUND(�÷� Ȥ�� ǥ����, �ڸ���) : ������ �ڸ������� �ݿø��Ѵ�.

TRUNC(�÷� Ȥ�� ǥ����, �ڸ���) : ������ �ڸ������� ����� ���� ������.

MOD(����1, ����2) : ������ ���� ��ȯ�Ѵ�.

ABS(�÷� Ȥ�� ǥ����) : ���밪�� ��ȯ�Ѵ�.

CELL(�÷� Ȥ�� ǥ����) : ������ ������ ũ�ų� ���� ���� �߿��� ���� ���� ������ ��ȯ�Ѵ�.
FLOOR(�÷� Ȥ�� ǥ����) : ������ ������ �۰ų� ���� ���� �߿��� ���� ū ������ ��ȯ�Ѵ�.
*/

SELECT ROUND(1234.5678),
       ROUND(1234.5678, 3),
       ROUND(1234.5678, 2),
       ROUND(1234.5678, 1),
       ROUND(1234.5678, 0),
       ROUND(1234.5678, -1),
       ROUND(1234.5678, -2),
       ROUND(1234.5678, -3)
FROM DUAL;    

SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 3),
       TRUNC(1234.5678, 2),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, -1),
       TRUNC(1234.5678, -2),
       TRUNC(1234.5678, -3)
FROM DUAL;  

-- 80�� �μ��� �Ҽӵ� ������ ���̵�, �̸�, �ݿ�, �޿��� �ش� #�� ����ϱ�
--'#' �ϳ��� 1000�޷��� ��Ÿ����.
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD('#', TRUNC(SALARY/10000), '#')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

SELECT MOD(10,4), ABS(-10)
FROM DUAL;

SELECT CEIL(1), CEIL(1.1), CEIL(1.5), CEIL(1.9), CEIL(2)
FROM DUAL;

SELECT FLOOR(1), FLOOR(1.1), FLOOR(1.5), FLOOR(1.9), FLOOR(2)
FROM DUAL;

/*
��¥ �Լ�

SYSDATE : �ý����� ���� ���ڿ� �ð��� DATEŸ������ ��ȯ�Ѵ�.
          * �����Ͱ� �߰��� ��, �����Ͱ� ����� �� �ý����� ���� ��¥�� �ð������� �����ϴ� �뵵�� Ȱ��˴ϴ�.
SYSTIMESTAMP : �ý����� ���� ���ڿ� �ð��� TIMESTAMP Ÿ������ ��ȯ�Ѵ�.

ADD_MONTHS(��¥, ����) : ��¥�� ������ ���ڸ�ŭ�� ���� ���� ��¥�� ��ȯ�Ѵ�.

EXTRACT(���� FROM ��¥) : ��¥���� ���Ŀ� �ش��ϴ� ���� ��ȯ�Ѵ�.
                        ���� : YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
                        
LAST_DAY(��¥) : ������ ��¥�� �������� �ش� ���� ������ ���ڸ� ��ȯ�Ѵ�.

NEXT_DAY(��¥, ����) : ������ ��¥�� �������� ������ �ٰ��� ��¥�߿��� ������ ���Ͽ� �ش��ϴ� ��¥�� ��ȯ�Ѵ�.

MONTHS_BEWTEEN(��¥, ��¥) : �� ��¥ ������ �������� ��ȯ�Ѵ�.

// �ϼ� ���� ����
���� + ���� = ���ڸ�ŭ ���ڰ� ����� ���ڸ� ��ȯ�Ѵ�.
��¥ - ���� = ���ڸ�ŭ ���� ��¥�� ��ȯ�Ѵ�.
��¥ - ��¥ = �� ��¥������ �ϼ��� ��ȯ�Ѵ�.
��¥ + 1/24 = 1�ð� ������ ��¥�� ��ȯ�Ѵ�.

TRUNC(��¥) : ������ ��¥�� ��� �ð� ������ 0��0��0�ʷ� �ٲ� ��¥�� ��ȯ�ȴ�.
ROUND(��¥) : ������ ��¥�� �ð������� ����(����12��)�� ������ ���̸� �ش糯¥�� 
                                 ������ �������� �Ϸ� ������ ��¥�� ��ȯ�ȴ�.
                                 �ð������� 0�� 0�� 0�ʴ�.
*/

-- �ý����� ���� ���ڿ� �ð��� DATE, TIMESTAMP ������ ��ȸ�ϱ�
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;

SELECT SYSDATE,                 -- ����
    ADD_MONTHS(SYSDATE, 1),     -- 1�� ��
    ADD_MONTHS(SYSDATE, 2),     -- 2�� ��
    ADD_MONTHS(SYSDATE, 3)      -- 3�� ��
FROM DUAL;

-- ������ 12��31�� �̶�� �����ϰ�, 2������ ��¥�� ��ȸ�ϸ� 2��28�� Ȥ�� 2��29���� ��ȯ�ȴ�.
SELECT ADD_MONTHS('2023/12/31', 2) FORM DUAL;

-- �ý����� ���� ���ڿ� �ð� �������� ��, ��, ��, ��, ��, �� ��ȸ�ϱ�
SELECT EXTRACT(YEAR FROM SYSDATE),
       EXTRACT(MONTH FROM SYSDATE),
       EXTRACT(DAY FROM SYSDATE),
       EXTRACT(HOUR FROM SYSTIMESTAMP),
       EXTRACT(MINUTE FROM SYSTIMESTAMP),
       EXTRACT(SECOND FROM SYSTIMESTAMP)
FROM DUAL;

-- ���� ���ڰ� ���� ���� ������ ���� ��ȸ�ϱ�
SELECT LAST_DAY(SYSDATE),
       LAST_DAY('2024/01/01'),
       LAST_DAY('2024/02/01')
FROM DUAL;

-- ���� ���ڸ� �������� ���� �������� ��ȸ�ϱ�
SELECT NEXT_DAY(SYSDATE, '������')
FROM DUAL;

-- ���� ���ڿ� ������ ��¥ ������ ���� ���� ��ȸ�ϱ�
SELECT MONTHS_BETWEEN(SYSDATE, '2023/06/01')
       TRUNC(MONTHS_BETWEEN(SYSDATEM '2023/06/01')
FROM DUAL;

-- ���� ���ڸ� �������� 7����, 3����, 3�� ��, 7�� �� ��¥�� ��ȸ�ϱ�
SELECT SYSDATE - 7,
       SYSDATE - 3,
       SYSDATE + 3,
       SYSDATE + 7
FORM DUAL;

-- ������ ��¥�� �������� 7������ ��¥�� ��ȸ�ϱ�
SELECT TP_DATE('2023/12/01'), TRUNC(TO_DATE('2023/12/01')) - 7
FROM DUAL;

-- ������ ��¥�� �������� 1����, 1�� ���� ��¥�� ��ȸ�ϱ�
SELECT ADD_MONTHS(TO_DATE('2023/12/01'), - 1),
       ADD_MONTHS(TO_DATE('2023/12/01'), 1)
FROM DUAL;

-- ���� �������� 7������ ��¥�� ��ȸ�ϱ�
SELECT TRUNC(SYSDATE) - 7
FROM DUAL;

-- ���� �������� 1������ ��¥�� ��ȸ�ϱ�
SELECT ADD_MONTHS(TRUNC(SYSDATE), - 1)
FROM DUAL;

-- ���� �������� 7�ϵ����� �ֹ������� ��ȸ�ϱ�(������ ���Ե��� ����)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= TRUNC(SYSDATE) - 3 AND TRUNC(SYSDATE) < TRUNC(SYSDATE);

-- ���ñ������� 1���������� �ֹ������� ��ȸ�ϱ�(������ ���Ե��� ����)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= ADD_MONTHS(TRUNC(SYSDATE), -1) AND TRUNC(SYSDATE) < TRUNC(SYSDATE);


SELECT SYSDATE,
       SYSDATE + 1/24,  -- 1�ð� ��
       SYSDATE + 3/24,  -- 3�ð� ��
       SYSDATE + 6/24   -- 6�ð� ��
FROM DUAL;

/*
��ȯ�Լ�

������ ��ȯ
    ��ȯ�Լ��� ������� �ʾƵ� �������� Ÿ���� �ڵ����� ���ϴ� ���̴�.
    '����' -> ��¥ : '����'�� ��ȿ�� ��¥ ������ ������ ��� ��¥�� ����ȴ�.
    '����' -> ���� : '����'�� ���ڷθ� �����Ǿ� ������ ���ڷ� ����ȴ�.
    
    SELECT *
    FROM EMPLOOYEES
    WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE < '2005/07/01';
    * ���� SQL����  HIRE_DATE�� DATEŸ���� �÷��̱� ������ '2005/01/01'���ڰ� DATEŸ���� ������ �ڵ����� ��ȯ�ȴ�.
    * '2005/01/01'�̳� '2005-01-01'�� ������ ��� �ڵ����� ��ȯ�ȴ�.
    
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = '10';
     * ���� SQL������ DEPARTMENT_ID�� NUMBERŸ���� �÷��̱� ���п�'10'���ڰ� NUMBERŸ���� ������ �ڵ����� ��ȯ�ȴ�.
����� ��ȯ
    ��ȯ�Լ��� ����ؼ� '����' <-->��¥, '����'<-->���� ���� �����ͺ�ȯ�� �ϴ� ���̴�.
    
    TO_DATE('��¥������ ���ڿ�', '����')
    ��) TO_DATE('2023/01/01')
        * ���ڿ��� ��¥������ �ؽ�Ʈ�̱� ������ ������ �������� �ʾƵ� DATEŸ������ ��ȯ�ȴ�.
        TO_DATE('20230101, 'YYYYMMDD')
        * ���ڿ��� �Ϲ����̴� ��¥ ������ �ƴ� ��쿡�� ������ �����ؾ� �Ѵ�.
    TO_CHAR(��¥, 'ǥ��')
        ��¥�� ������ ���������� �ؽ�Ʈ�� ��ȯ�Ѵ�.
        ��¥ ��ȯ ����
            AM          *����*
            PM          *����*
            YYYY, YY    *2022*
            MM          ��
            D           1~7 (1:�Ͽ���, 7:�����)
            DAY         ����
            DD          1~31
            HH          12�ð��� �ð�
            HH24        24�ð��� �ð�
            MI          ��
            SS          ��
         * ��¥ ��ȯ ������ ��ҹ��ڸ� �������� �ʴ´�.   
*/

-- ���ڸ� ��¥�� ��ȯ�ϱ�
SELECT TO_DATE('2023/01/01'),
       TO_DATE('20230101'),
       TO_DATE('2023 01 01'),
       TO_DATE('2023/01/01 22:41:10', 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;

-- ��¥�� ���ڷ� ��ȯ�ϱ�
SELECT TO_CHAR(SYSDATE, 'YYYY'),    -- 124 AS AAAAAAAAAAAAAAAAAAA ���ڴ� �տ������� ���, ���ڴ� �ڿ������� ����ϱ⿡ 2023�� �����ΰ��� �˼��ִ�
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'AM'),
       TO_CHAR(SYSDATE, 'HH'),
       TO_CHAR(SYSDATE, 'HH24')
FROM DUAL;

-- �������̺��� 2005�⵵ �Ի��� ������ ���̵�, �̸�, �Ի����ڸ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005';

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005-01-01' AND HIRE_DATE < '2006-01-01';

-- ���ڸ� ,�� ���Ե� ���ڷ� ��ȯ�Ѵ�.
SELECT TO_CHAR(100000, '999,999')
FROM DUAL;

-- ���ڸ� ���ڷ� ��ȯ�Ѵ�.
SELECT TO_NUMBER('10000'), TO_NUMBER('100,000', '999,999')
FROM DUAL;












