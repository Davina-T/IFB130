/* Davina Tan N9741127 */

/* Use database */
USE pulselearning;

	/* TASK 2 */

/* Query 1 */
/* List the name (first and last), studentID and email of students who live in Everton Park 
or Everton Hills. Note: you can assume these are the only suburbs starting with 'Everton'. */
SELECT firstName, surname, studentID, email
FROM Student
WHERE suburb = 'Everton Park' OR suburb = 'Everton Hills';

/* Query 2 */
/* List students with buddies, in alphabetical order by surname. */
SELECT *
FROM Student
WHERE buddyID IS NOT NULL
ORDER BY surname ASC;

/* Query 3 */
/* Count how many units each tutor teaches. In the result-set, include the tutors' staffID,
firstname, surname and the number of units they teach. */
SELECT t.staffID, t.firstName, t.surname, COUNT(u.unitID) num_units
FROM tutor t, unitTutor s, unit u
WHERE t.staffID = s.staffID
AND s.unitID = u.unitID
GROUP BY (t.staffID);

/* Query 4 */
/* Produce some statistics about assignment results. The result-set should include the 
following: assignment ID, assignment name, min grade by class, avg grade by class, 
max grade by class, number of submissions. */
SELECT a.assignmentID, a.assignmentName, MIN(g.grade) min_grade, AVG(g.grade) avg_grade, 
MAX(g.grade) max_grade, COUNT(a.assignmentID) num_submissions
FROM assignment a, grade g
WHERE a.assignmentID = g.assignmentID
GROUP BY a.assignmentID, a.assignmentName;

/* Query 5 */
/* List the full name and email address of all tutors that aren't teaching any classes
next semester (Semester 2, 2018). */
SELECT firstName, surname, email
FROM tutor
WHERE staffID NOT IN (
	SELECT staffID
    FROM unitTutor s, unit u
    WHERE s.unitID = u.unitID
    AND u.semester = 2 AND u.year = 2018);            

/* Query 6 */
/* For students that slept less than 6 hours a night on average during April, list the
grades for all assignments they completed during this time. */
SELECT studentID, grade, assignmentID
FROM grade
WHERE studentID IN 
		(SELECT studentID
        FROM sleepPatterns
        WHERE MONTHNAME(date) = 'April'
        AND timeAsleep <= 6);

	/* Task 3 */
/* INSERT */
INSERT INTO unit (unitName, unitCode, year, semester)
VALUES ('Advanced Database Management', 'IFB801', 2019, '1');

/* DELETE */
/* Disable safe mode */
SET SQL_SAFE_UPDATES = 0;
DELETE FROM phoneNumber
WHERE phoneNumber REGEXP '^02.';

/* UPDATE */
UPDATE student
SET streetNumber = '72', streetName = 'Evergreen Terrace', suburb = 'Springfield'
WHERE surname = 'Smith'
AND streetNumber = '180'
AND streetName = 'Zelda Street'
AND suburb = 'Linkburb';

	/* Task 4 */
/* Create index */
CREATE INDEX assignment_index
ON assignment(assignmentName);

/* Create view */
/* Write a command to create a view to list the firstname, surname and student ID of any students that haven’t
enrolled in any units. */
CREATE VIEW students_not_enrolled AS SELECT firstName, surname, studentID
FROM student
WHERE studentID NOT IN 
			(SELECT studentID
            FROM enrolments);

	/* Task 5 */
/* a) Nikki must be able to add records to STUDENT table */
GRANT INSERT
ON pulselearning.student
TO nikki@localhost;

/* b) Nikki must be able to remove records from the STUDENT table */
GRANT DELETE
ON pulselearning.student
TO nikki@localhost;

/* c) Jake is no longer allowed to add data to the STUDENT table */
REVOKE INSERT 
ON pulselearning.student
FROM jake@localhost;

/* d) Jake is no longer allowed to delete records from the STUDENT table */
REVOKE DELETE 
ON pulselearning.student
FROM jake@localhost;             

