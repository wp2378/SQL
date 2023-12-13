/*
시퀸스
    일련번호를 제공하는 오라클객체다.
    
    생성하기 
        CREAT SEQUENCE 시퀸스명;
    삭제하기
        DROP SEQUENCE 시퀸스명;
    수정하기
        ALTER SEQUENCE 시퀸스명
        
    시퀸스 생성 예시
        CREATE SEQUENCE 시퀸스명
        * 시작값:1, 증가치:1, 최소값:1, 최대값:999999999
        * 캐시사이즈 : 20
        
        CREATE SEQUENCE 시퀸스명
            STRAT WITH   1000
            INCREMENT BY 100
            NOCACHE;
        * 시작값:1000, 증가치:100, 최소값:1, 최대값:999999999
        * 캐시 사용하지 않음
*/

-- 새로운 시퀸스를 생성하기
CREATE SEQUENCE BOOKS_SEQ;

-- 새 일련번호 조회
SELECT BOOKS_SEQ.NEXTVAL
FROM DUAL;

-- INSERT구문에서 시퀸스 활용하기
INSERT INTO SAMLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_RPICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '시퀸스 활용하기', '홍길동', 10000);

INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_RPICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '이것이 자바다', '홍길동', 10000, BOOKS_SEQ.CURRVAL || 'png';