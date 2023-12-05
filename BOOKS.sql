/*
    ���̺� �����ϱ�
    
    CREATE TABLE ���̺��� {
        �÷��� ������Ÿ�� ��������,
        �÷��� ������Ÿ��,
        �÷��� ������Ÿ��(������),
        �÷��� ������Ÿ�� DEFAULT �⺻��
    };
*/

/*
    CREATE TABLE
        ���̺��� ������Ű�� SQL ���ɾ��.
    SAMPLE_BOOKS
        ���� ������ ���̺��� �̸��̴�.
    BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_PRICE,
    BOOK_STOCK, BOOK_REG_DATE
        ���� ������ ���̺��� �÷��̸��̴�.
    NUMBER
        �ش� �÷��� ������Ÿ���� ���������� �����Ѵ�.
    VARCHAR2
        �ش� �÷��� ������Ÿ���� �������̹��������� �����Ѵ�.
    DATE
        �ش� �÷��� ������ Ÿ���� ��¥������ �����Ѵ�.
    PRIMARY KEY
        �ش� �÷��� ���̺����� ���� �ĺ��ϱ� ���� ���� ������ �⺻Ű �÷����� �����Ѵ�.
        �ش� �÷��� NULL�� ������� ������, ���� ���̺� ��ü���� �����ϴ�.
    NOT NULL
        �ش� �÷��� NULL�� ���¸� ���� �� ����.
    DEFAULT 10
        ���ο� ���� �߰��� �� �ش� �÷��� ���� �������� ������ 10�� �⺻������ ����ȴ�.
    DEFAULT SYSDATE
        ���ο� ���� �߰��� �� �ش��÷��� ���� �������� ������ �ý����� ���� ��¥�� ����ȴ�.
*/

CREATE TABLE SAMPLE_BOOKS (
    BOOK_NO             NUMBER(6) PRIMARY KEY,
    BOOK_TITLE          VARCHAR2(255) NOT NULL,
    BOOK_WRITER         VARCHAR2(255),
    BOOK_PRICE          NUMBER(7, 0) NOT NULL,
    BOOK_STOCK          NUMBER(3, 0) DEFAULT 10,
    BOOK_REG_DATE       DATE         DEFAULT SYSDATE
);
/*
    ���̺��� �ű� �� �߰��ϱ�
    
    INSERT INTO ���̺���(�÷���, �÷���, �÷���)
    VALUES              (��,��,��)
    * �ű� ���� �߰��� �� ���� ����� �÷��� ���� �����ϴ� ����̴�.
    * ������ �÷����� NULL ���� ����ǰų�, �⺻���� ����ȴ�.
    * ���̺��� �÷� ������ ������� ���� ������ �÷��� ���� ������ ���� �����Ѵ�.
    * ���� ����ȯ�濡���� �� ����� ����Ѵ�.
    
    INSERT INTO ���̺���
    VALUES (��, ��, ��, ��, ��);
    * �ű� ���� �߰��� �� �÷����� �����ϴ� ����̴�
    * �ű� ���� ��� �÷��� ���ؼ� ���� �����ؾ� �Ѵ�.
        (������ ���� ������ NULL�� ���������� ���´�.)
    * ���̺��� �÷������� ������ ������ ���� �����ؾ� �Ѵ�.    
    
*/


-- �ű� å ���� �߰��ϰ���
INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_PRICE)
VALUES
(10,'�ڹ��� ����','���ø�', 32000);

INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_PRICE, BOOK_STOCK)
VALUES
(12, '�̰��� �ڹٴ�', '�ſ뱺', 35000, 25);

INSERT INTO SAMPLE_BOOKS
VALUES(14, '����Ƽ�� �ڹ�', '����ö', 18000, 10, SYSDATE);

INSERT INTO SAMPLE_BOOKS
(BOOK_NO, book_title, book_writer, book_price)
VALUES
(50, 'AAA', 'BBB', 15000);

-- INSERT ������ �������� �����ͺ��̽��� ���������� �����Ų�� 
commit;

/*
    ������ �����ϱ�
    
    UPDATE ���̺���
    SET 
        �÷��� = ���氪,
        �÷��� = ���氪,
        ...
    [WHERE ���ǽ�]
    * ���̺����� ������ �÷��� ���� ���氪���� �����Ų��.
    * WHERE���� �����ϸ� ���̺��� ��� ���� ���ؼ� �÷��� ���� ����ȴ�.
    * WHERE���� �ִ� ��� ���ǽ��� �����ϴ� �� ���ؼ��� ������ �÷��� ���� ����ȴ�.
*/

-- ���� ���̺����� å��ȣ�� 10�� å�� ��������� 9������ �����ϱ�
UPDATE sample_books
SET
    book_stock = 9
WHERE book_no = 10;

-- ���� ���̺����� å��ȣ�� 12�� å�� ������ 10%�����ϰ�, ��������� 1���ҽ�Ų��.
UPDATE sample_books
SET
    BOOK_PRICE = BOOK_PRICE * 0.9,
    BOOK_STOCK = BOOK_STOCK - 1
WHERE BOOK_NO = 50;

-- ���� ���̺��� ���� ���� ������ �����ͺ��̽��� ���������� �ݿ��ȴ�.
COMMIT;

/*
    ���̺��� �� �����ϱ�

    DELETE FROM ���̺���
    [WHERE ���ǽ�]
    
    * WHERE���� �����ϸ� ���̺��� ��� ���� �����ȴ�.
    * WHERE���� ������ ���ǽ��� �����ϴ� �ุ �����ȴ�.
*/
/*
   *���� ���̺����� å��ȣ�� 10���� å������ �����ϱ�
   *���� ���̺����� å������'�ڹ��� ����'�� å������ �����ϱ�
   *WHERE���� ���ǽ��� ������ Ư�� �� �ϳ��� �����ǵ��� ���ǽ��� �ۼ�����.
    (Ư�� �� �ϳ��� �����ǵ��� �ϱ����ؼ��� ���ǽ��� �ش� ���̺�����
    �⺻Ű ���������� ����� �÷��� �˻��������� ���Ǿ�� �Ѵ�. 
    
    ���̺� �����ϱ�
    TRUNCATE TABLE ���̺���
    
    * ���̺��� �����͸� ���� �����ϰ�, ����ϰ� �ִ� ������ �ݳ��Ѵ�.
    * ���� ���̺� ���������� ������ ���°� �ȴ�.
*/

-- ���� ���̺����� å��ȣ�� 10�� å����(��)�� �����ϱ�
DELETE FROM SAMPLE_BOOKS
WHERE BOOK_NO = 10;

-- ���� ���̺��� ��� ������ �����ϱ�
TRUNCATE TABLE SAMPLE_BOOKS;
