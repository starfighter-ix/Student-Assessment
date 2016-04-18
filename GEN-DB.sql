SET TERMOUT ON
PROMPT "Dropping old tables and rebuilding. Please stand by."
--SET TERMOUT OFF


DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE SUBJECT CASCADE CONSTRAINTS;
DROP TABLE COURSEWORK CASCADE CONSTRAINTS;
DROP TABLE COURSEWORKRESULT CASCADE CONSTRAINTS;
DROP TABLE EXAM CASCADE CONSTRAINTS;
DROP TABLE EXAMRESULT CASCADE CONSTRAINTS;
DROP TABLE LECTURER CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;

PROMPT "All tables have been dropped."

CREATE TABLE STUDENT(
        STUDENT_ID NUMBER(10),
        PRIMARY KEY (STUDENT_ID),
        FIRST_NAME VARCHAR(20),
        LAST_NAME VARCHAR(20),
        YEAR NUMBER(2),
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID) NUMBER(10);
);


CREATE TABLE SUBJECT(
        SUBJECT_ID NUMBER(10),
        PRIMARY KEY (SUBJECT_ID),
        NAME VARCHAR(20),
        DESCRIPTION VARCHAR(255),
        SEMESTER NUMBER(2);
);


CREATE TABLE COURSEWORK(
        COURSEWORK_ID NUMBER(10),
        PRIMARY KEY (COURSEWORK_ID),
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID) NUMBER(10),
        MAX_MARK NUMBER(10);
);


CREATE TABLE COURSEWORKRESULT(
        MARK_ACHIEVED NUMBER(10),
        STUDENT_ID REFERENCES STUDENT(STUDENT_ID)) NUMBER(10),
        COURSEWORK_ID REFERENCES COURSEWORK(COURSEWORK_ID) NUMBER(10);
);


CREATE TABLE EXAM(
        EXAM_ID NUMBER(10),
        PRIMARY KEY (EXAM_ID),
        TOTAL_MARK NUMBER(10),
        RESIT VARCHAR(3),
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID) NUMBER(10);
);


CREATE TABLE EXAMRESULT(
        MARK_ACHIEVED NUMBER(10),
        STUDENT_ID REFERENCES STUDENT(STUDENT_ID) NUMBER(10),
        EXAM_ID REFERENCES EXAM(EXAM_ID) NUMBER(10);
);

COMMIT;

SET TERMOUT OFF
PROMPT "Building tables is complete."