SET TERMOUT ON
PROMPT Dropping old tables and rebuilding. Please stand by.

-- Drop all existing sequences
begin
for s in (select sequence_name from user_sequences) loop
execute immediate ('drop sequence '||s.sequence_name);
end loop;
end;
/


DROP TABLE STUDENT CASCADE CONSTRAINTS;
DROP TABLE SUBJECT CASCADE CONSTRAINTS;
DROP TABLE COURSEWORK CASCADE CONSTRAINTS;
DROP TABLE COURSEWORKRESULT CASCADE CONSTRAINTS;
DROP TABLE EXAM CASCADE CONSTRAINTS;
DROP TABLE EXAMRESULT CASCADE CONSTRAINTS;
DROP TABLE LECTURER CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;

PROMPT All tables have been dropped.

--Block to create the subject table
CREATE TABLE SUBJECT(
        SUBJECT_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (SUBJECT_ID),
        NAME VARCHAR(20) NOT NULL,
        DESCRIPTION VARCHAR(255) NOT NULL,
        SEMESTER NUMBER(2) NOT NULL
);

PROMPT Subject table created.

CREATE SEQUENCE Subject_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Subject_seq_tr
BEFORE INSERT ON SUBJECT FOR EACH ROW
BEGIN
SELECT Subject_seq.NEXTVAL INTO :NEW.SUBJECT_ID FROM DUAL;
END;
/

PROMPT Subject sequence created.

-- End subject block

--Block to create the student table
CREATE TABLE STUDENT(
        STUDENT_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (STUDENT_ID),
        FIRST_NAME VARCHAR(20) NOT NULL,
        LAST_NAME VARCHAR(20) NOT NULL,
        YEAR NUMBER(2) NOT NULL,
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID)
);

PROMPT Student table created.

CREATE SEQUENCE Student_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Student_seq_tr
BEFORE INSERT ON STUDENT FOR EACH ROW
BEGIN
SELECT Student_seq.NEXTVAL INTO :NEW.STUDENT_ID FROM DUAL;
END;
/

PROMPT Student sequence created.

--End student block

--Block to create the CW table
CREATE TABLE COURSEWORK(
        COURSEWORK_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (COURSEWORK_ID),
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID),
        MAX_MARK NUMBER(10) NOT NULL
);

PROMPT Coursework table created.

CREATE SEQUENCE COURSEWORK_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER CW_seq_tr
BEFORE INSERT ON COURSEWORK FOR EACH ROW
BEGIN
SELECT COURSEWORK_seq.NEXTVAL INTO :NEW.COURSEWORK_ID FROM DUAL;
END;
/

PROMPT Coursework sequence created.

--End the CW block

--Block to create the CWR table
CREATE TABLE COURSEWORKRESULT(
        MARK_ACHIEVED NUMBER(10) NOT NULL,
        STUDENT_ID REFERENCES STUDENT(STUDENT_ID),
        COURSEWORK_ID REFERENCES COURSEWORK(COURSEWORK_ID)
);

PROMPT Coursework result table created.
PROMPT No CWR sequence.

--End CWR block

--Block to create the Lecturer table
CREATE TABLE LECTURER(
        LECTURER_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (LECTURER_ID),
        TITLE VARCHAR(10) NOT NULL,
        FIRST_NAME VARCHAR(20) NOT NULL,
        LAST_NAME VARCHAR(20) NOT NULL,
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID),
        COURSEWORK_ID REFERENCES COURSEWORK(COURSEWORK_ID)
);

PROMPT Lecturer table created.

CREATE SEQUENCE Lec_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Lec_seq_tr
BEFORE INSERT ON LECTURER FOR EACH ROW
BEGIN
SELECT Lec_seq.NEXTVAL INTO :NEW.LECTURER_ID FROM DUAL;
END;
/

PROMPT Lecturer sequence created.

--End lecturer block

--Block to create exam table
CREATE TABLE EXAM(
        EXAM_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (EXAM_ID),
        TOTAL_MARK NUMBER(10) NOT NULL,
        RESIT VARCHAR(3) NOT NULL,
        SUBJECT_ID REFERENCES SUBJECT(SUBJECT_ID)
);

PROMPT Exam table created.

CREATE SEQUENCE Exam_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Exam_seq_tr
BEFORE INSERT ON EXAM FOR EACH ROW
BEGIN
SELECT Exam_seq.NEXTVAL INTO :NEW.EXAM_ID FROM DUAL;
END;
/

PROMPT Exam sequence created.

--End exam block

--Block to create EXR table
CREATE TABLE EXAMRESULT(
        MARK_ACHIEVED NUMBER(10) NOT NULL,
        STUDENT_ID REFERENCES STUDENT(STUDENT_ID),
        EXAM_ID REFERENCES EXAM(EXAM_ID)
);

PROMPT Exam result table created.
PROMPT No exam result sequence.

--End EXR block

--Block to create question table
CREATE TABLE QUESTION(
        QUESTION_ID NUMBER(10) NOT NULL,
        PRIMARY KEY (QUESTION_ID),
        MAX_MARK NUMBER(10) NOT NULL,
        AUTHOR VARCHAR (50) NOT NULL,
        EXAM_ID REFERENCES EXAM(EXAM_ID),
        LECTURER_ID REFERENCES LECTURER(LECTURER_ID)
);

PROMPT Question table created.

CREATE SEQUENCE Q_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER Q_seq_tr
BEFORE INSERT ON QUESTION FOR EACH ROW
BEGIN
SELECT Q_seq.NEXTVAL INTO :NEW.QUESTION_ID FROM DUAL;
END;
/

PROMPT Question sequence created.

--End question block

COMMIT;

SET TERMOUT OFF
PROMPT Building tables is complete.