SELECT lec.LECTURER_ID, lec.TITLE, lec.FIRST_NAME, lec.LAST_NAME

FROM LECTURER lec, SUBJECT sub, STUDENT stu

WHERE lec.SUBJECT_ID IN (

	(SELECT SUBJECT_ID

		FROM SUBJECT

		WHERE SUBJECT_ID IS NOT NULL

	)
		
);