-- 테이블 삭제하기
drop table sample_books;
drop table SAMPLE_CUSTOMERS;
drop table sample_products;
DROP TABLE DEPST;

-- 시퀸스 삭제하기
DROP SEQUENCE BOOKS_SEQ;
DROP SEQUENCE CUSTOMERS_SEQ;

/*
수강신청 시스템용 테이블

학과
교수
학생
과정
수강신청
*/


-- 학과테이블
CREATE TABLE DEPTS (
DEPT_NO NUMBER(3),
DEPT_NAME VARCHAR2(255) NOT NULL,

CONSTRAINT DEPT_NO_PK PRIMARY KEY (DEPT_NO)
);

-- 교수테이블
CREATE TABLE PROFESSORS (
    PROF_NO NUMBER(3),
    PROF_NAME VARCHAR2(100) NOT NULL,
    PROF_POSITION VARCHAR2 (100) NOT NULL,
    DEPT_NO NUMBER(3) NOT NULL,
    
    CONSTRAINT PROF_NO_PK PRIMARY KEY (PROF_NO),
    CONSTRAINT PROF_DEPTNO_FK FOREIGN KEY (DEPT_NO)
                                REFERENCES DEPST (DEPT_NO)
);

-- 학생테이블
CREATE TABLE STUDENST (
    STUD_NO NUMBER(3),
    STUD_NAME VARCHAR2(100) NOT NULL,
    STUD_GRADE NUMBER(1),
    DEPT_NO NUMBER(3) NOT NULL,
    PROF_NO NUMBER(3),
    
    CONSTRAINT STUD_NO PRIMARY KEY (STUD_NO),
    CONSTRAINT STUD_GRADE_CK CHECK (STUD_GRADE IN (1,2,3,4)),
    CONSTRAINT STUD_DEPTNO_FK FOREIGN KEY (DEPT_NO)
                                REFERENCES DEPST (DEPT_NO),
    CONSTRAINT STUD_PROFNO_FK FOREIGN KEY (PROF_NO)
                                REFERENCES PROFESSORS (PROF_NO)
);

-- 개설과정 테이블
CREATE TABLE COURSES (
    COURSE_NO NUMBER(3),
    COURSE_NAME VARCHAR2(255) NOT NULL,
    DEPT_NO NUMBER(3),
    PROF_NO NUMBER(3),
    
    CONSTRAINT COUR_NO_PK PRIMARY KEY (COURSE_NO),
    CONSTRAINT COUR_DEPTNO_FK FOREIGN KEY (DEPT_NO)
                                REFERENCES DEPST (DEPT_NO),
    CONSTRAINT COUR_PROFNO_FK FOREIGN KEY (PROF_NO)
                                REFERENCES PROFESSORS (PROF_NO)
);

--수강신청 테이블
CREATE TABLE REQUESTS (
    STUD_NO NUMBER(3),
    COURSE_NO NUMBER(3),
    REQ_DATE DATE DEFAULT SYSDATE,
    
    CONSTRAINT REQ_STUDNO_COURSENO_PK PRIMARY KEY (STUD_NO, COURSE_NO),
    CONSTRAINT REQ_STUDNO_FK FOREIGN KEY (STUD_NO)
                             REFERENCES STUDENST (STUD_NO),
    CONSTRAINT REQ_COURSENO_FK FOREIGN KEY (COURSE_NO)
                                REFERENCES COURSES (COURSE_NO)
);

INSERT INTO DEPTS (DEPT_NO, DEPT_NAME)
VALUES (101, '컴퓨터공학과');
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME)
VALUES (102, '전자공학과');
INSERT INTO DEPTS (DEPT_NO, DEPT_NAME)
VALUES (103, '기계공학과');

INSERT INTO PROFESSORS (PROF_NO, PROF_NAME, PROF_POSITION, DEPT_NO)
VALUES (201,'김교수', '정교수', 101);
INSERT INTO PROFESSORS (PROF_NO, PROF_NAME, PROF_POSITION, DEPT_NO)
VALUES (202,'이교수', '정교수', 102);
INSERT INTO PROFESSORS (PROF_NO, PROF_NAME, PROF_POSITION, DEPT_NO)
VALUES (203,'박교수', '정교수', 103);
INSERT INTO PROFESSORS (PROF_NO, PROF_NAME, PROF_POSITION, DEPT_NO)
VALUES (204,'강교수', '정교수', 100);

DELETE FROM DEPTS
WHERE DEPT_NO = 101;

INSERT INTO STUDENTS
(STUD_NO, STUD_NAME, STUD_GRADE, DEPT_NO, PROF_NO)
VALUES
(301, '홍길동', 1, 101, 201);
INSERT INTO STUDENTS
(STUD_NO, STUD_NAME, STUD_GRADE, DEPT_NO, PROF_NO)
VALUES
(302, '김유신', 1, 102, 203);
INSERT INTO STUDENTS
(STUD_NO, STUD_NAME, STUD_GRADE, DEPT_NO, PROF_NO)
VALUES
(303, '이순신', 1, 102, 203);
INSERT INTO STUDENTS
(STUD_NO, STUD_NAME, STUD_GRADE, DEPT_NO, PROF_NO)
VALUES
(304, '류관순', 1, 102, 203);

-- 모든 학생 정보를 조회하기
-- 학번, 이름, 학년, 소속학과명, 담당교수명
SELECT S.STUD_NO, S.STUD_NAME, S.STUD_GRADE, D.DEPT_NAME, P.PROF_NAME
FROM STUDENTS S, DEPTS D, PROFESSORS P
WHERE S.DEPT_NO = D.DEPT_NO
AND S.PROF_NO = P.PROF_NO;

INSERT INTO COURSES
(COURSE_NO, COURSE_NAME, DEPT_NO, PROF_NO)
VALUES
(401, '운영체제 기초', 101, 201);
INSERT INTO COURSES
(COURSE_NO, COURSE_NAME, DEPT_NO, PROF_NO)
VALUES
(402, '데이터베이스', 101, 201);
INSERT INTO COURSES
(COURSE_NO, COURSE_NAME, DEPT_NO, PROF_NO)
VALUES
(403, '프로그래밍 실습', 101, 202);

-- 개설과정 조회하기
-- 과정번호, 과정명, 개설학과, 담당교수 조회하기
-- C       C      D       P
SELECT C.COURSE_NO, C.COURSE_NAME, D.DEPT_NAME, P.PROF_NAME
FROM COURSES C, DEPTS D, PROFESSORS P
WHERE C.DEPT_NO = D.DEPT_NO
AND C.PROF_NO = P.PROF_NO;

INSERT INTO REQUESTS (STUD_NO, COURSE_NO) VALUES(301, 401);
INSERT INTO REQUESTS (STUD_NO, COURSE_NO) VALUES(301, 402);
INSERT INTO REQUESTS (STUD_NO, COURSE_NO) VALUES(302, 401);
INSERT INTO REQUESTS (STUD_NO, COURSE_NO) VALUES(302, 402);
INSERT INTO REQUESTS (STUD_NO, COURSE_NO) VALUES(302, 403);

-- 홍길동 학생이 수강신청한 과정 조회하기
-- 과정번호, 과정명, 개설학과명, 담당교수명, 신청일 조회
/*
신청정보                  과정정보                               학과정보           교수정보
[학번, *과정번호, 신청일] - [*과정번호, 과정명, +학과번호, $교수번호 ]-[+학과정보, 학과명]-[$교수번호, 교수명]
*/

SELECT C.COURSE_NO, C.COURSE_NAME, D.DEPT_NAME, P.PROF_NAME, R.REG_DATE
FROM REQUESTS R, COURSES C, DEPTS D, PROFESSORS P
WHERE R.COURSE_NO = C.COURSE_NO --[학번, *과정번호, 신청일] - [*과정번호, 과정명, +학과번호, $교수번호 ]
AND C.DEPT_NO = D.DEPT_NO       --[*과정번호, 과정명, +학과번호, $교수번호 ]-[+학과정보, 학과명
AND C.PROF_NO = P.PROF_NO       --[*과정번호, 과정명, +학과번호, $교수번호 ]-[+학과정보, 학과명]-[$교수번호, 교수명]
AND R.STUD_NO IN (SELECT STUD_NO
                 FROM STUDENTS
                 WHERE STUD_NAME = '홍길동');
                 
/*
테이블 생성 순서
    부모테이블 -> 자식테이블

테이블 삭제 순서
    자식테이블 -> 부모테이블
    
    REQUESTS -> COURSES -> STUDENTS -> PROFESSORS -> DEPTS 순으로 삭제해야한다
             
*/

-- 테이블 삭제하기     -- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
DROP TABLE DEPTS;         -- PROFESSORS, STUDETNS, COURSES에서 참조하고 있다.
DROP TABLE PROFESSORS;    -- STUDENTS, COURSES에서 참조하고 있다.
DROP TABLE STUDENTS;      -- REQUESTS에서 참조하고있다.
DROP TABLE COURSES;       -- REQUESTS에서 참조하고있다.
DROP TABLE REQUESTS;      -- 참조하는 테이블 없음

-- CASCADE CONSTRAINTS는 이 테이블을 참조하는 자식 테이블에 외래키 제약조건을
-- 제거한 다음, 이 테이블을 삭제한다.
DROP TABLE DEPTS CASCADE CONSTRAINTS;  -- 제약조건을 무시하고 테이블을 삭제한다.
DROP TABLE PROFESSORS CASCADE CONSTRAINTS;
DROP TABLE STUDENTS CASCADE CONSTRAINTS;
DROP TABLE COURSES CASCADE CONSTRAINTS;
DROP TABLE REQUESTS CASCADE CONSTRAINTS;
DROP TABLE SALRY_GRADES CASCADE CONSTRAINTS;
/*
제약조건의 추가/삭제

* 외래키 제약조건 추가하기
ALTER TABLE 테이블명
ADD CONSTRTINT 제약조건별칭 FOREIGN KEY (컬럼명)
                          REFERENCES 부모테이블명 (컬럼명);
    
* 제약조건 삭제하기
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건별칭;

* 제약조건 비활성화하기
ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건별칭별칭;

* 제약조건 활성화하기
ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약조건별칭별칭;
    
*/