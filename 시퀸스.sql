/*
������
    �Ϸù�ȣ�� �����ϴ� ����Ŭ��ü��.
    
    �����ϱ� 
        CREAT SEQUENCE ��������;
    �����ϱ�
        DROP SEQUENCE ��������;
    �����ϱ�
        ALTER SEQUENCE ��������
        
    ������ ���� ����
        CREATE SEQUENCE ��������
        * ���۰�:1, ����ġ:1, �ּҰ�:1, �ִ밪:999999999
        * ĳ�û����� : 20
        
        CREATE SEQUENCE ��������
            STRAT WITH   1000
            INCREMENT BY 100
            NOCACHE;
        * ���۰�:1000, ����ġ:100, �ּҰ�:1, �ִ밪:999999999
        * ĳ�� ������� ����
*/

-- ���ο� �������� �����ϱ�
CREATE SEQUENCE BOOKS_SEQ;

-- �� �Ϸù�ȣ ��ȸ
SELECT BOOKS_SEQ.NEXTVAL
FROM DUAL;

-- INSERT�������� ������ Ȱ���ϱ�
INSERT INTO SAMLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_RPICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '������ Ȱ���ϱ�', 'ȫ�浿', 10000);

INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_RPICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '�̰��� �ڹٴ�', 'ȫ�浿', 10000, BOOKS_SEQ.CURRVAL || 'png';