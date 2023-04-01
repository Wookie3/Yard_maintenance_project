SELECT task_id, is_complete, staff_id 
	FROM tasks AS t
    JOIN staff AS s
    ON s.staff_id = t.staff_id;

SELECT title, c.name
FROM job_ads AS ja
JOIN companies as c
ON ja.company_id = c.id
WHERE hourly_pay = (SELECT MIN(hourly_pay) FROM job_ads);

-- SCRIPTS FOR USE
SELECT * FROM tasks;
SELECT * FROM locations;
-- update staff memeber
UPDATE staff SET is_crew_lead = '1' WHERE staff_id = '4';
-- update a user to add a location
UPDATE users SET location_id = '006' WHERE user_id ='2';
SELECT * from users;
SELECT * from staff;
SELECT * from locations;
SELECT * FROM staff WHERE is_crew_lead;
