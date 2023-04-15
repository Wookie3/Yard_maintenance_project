-- SCRIPTS
USE yard_keeper;
SELECT * from staff;
SELECT * from sign_out;
SELECT * from users;
SELECT * FROM locations;
SELECT * FROM tasks;

-- see all tasks for a given location
SELECT task_id AS Task, task_info AS Description, is_complete AS 'Complete' from tasks WHERE location_id = 103;

-- see all item that are signed out:
SELECT item_id AS ID, item_type AS 'Type', time_updated AS 'Last Updated' 
FROM sign_out WHERE is_out;
-- see who has what signed out currently
SELECT item_id AS 'Item ID', item_type AS 'Type', time_updated AS 'Updated', s.first_name AS 'First' , s.last_name AS 'Last' , s.staff_id AS 'Staff ID'
FROM sign_out as so
JOIN staff as s
ON so.staff_id = s.staff_id
WHERE is_out
;

-- see all incomplete tasks and the street address
SELECT task_id AS 'Task', task_info AS 'Description', l.street_name AS 'Street Name', l.street_number AS 'No.'
	FROM tasks AS t
    JOIN locations AS l
    ON t.location_id = l.location_id
    WHERE NOT is_complete;
    
-- see what users own what locations

SELECT location_id AS 'Location ID', street_name AS 'Street Name', street_number AS 'No.', u.user_name AS 'Customer'
	FROM locations AS l
    JOIN users as u
    ON u.user_id = l.user_id
    ORDER BY u.user_name
;



-- sign out items
UPDATE yard_keeper.sign_out 
SET staff_id= 3, 
time_updated = current_timestamp(), 
is_out = 1 
WHERE item_id= 2020;
SELECT * FROm sign_out;
UPDATE yard_keeper.sign_out
SET staff_id= 1,
time_updated = current_timestamp(),
is_out = 1 
WHERE item_id= 2030;

-- sign in an itmem
UPDATE yard_keeper.sign_out
SET staff_id= DEFAULT, 
is_out = 0, 
time_updated = current_timestamp() 
WHERE item_id= 2030;


-- add a new location
INSERT INTO yard_keeper.locations(location_id, street_name, street_number, postal_code, user_id)
VALUES 
	('104', 'Easton Rd.', '1100', 'M7B2E8', 1);
-- add a new tasks for the new location
INSERT INTO tasks(task_info, location_id)
	VALUES
		('Trim hedgeds in back yard', 104),
        ('Plant 2 trees in front by walkway stairs', 104)
;
SELECT * FROM tasks;

-- complete a task
UPDATE yard_keeper.tasks
SET is_complete = 1, 
time_complete = current_timestamp()
WHERE task_id = 3;
SELECT * FROM tasks;

-- delete a complete task
START TRANSACTION;
DELETE FROM yard_keeper.tasks WHERE task_id = 3 AND is_complete;
SELECT * FROM tasks;
-- COMMIT;
ROLLBACK;

-- add a new user
INSERT INTO users(user_name, user_password)
	VALUES
		('Property Owners Co.', 'p@ssw0rd')
;
SELECT * FROM users;
-- update a locations info to the new user
UPDATE locations SET user_id = 4 WHERE location_id = 104;
SELECT * FROM locations;
-- add a new staff member
INSERT INTO staff(first_name, last_name, is_crew_lead, is_admin)
	VALUES
		('Steve',  'Smith', 0, 0)
;
-- premote staff memeber to crew lead
UPDATE staff SET is_crew_lead = 1 WHERE staff_id = 4;
SELECT * FROM staff;



SELECT * FROM tasks;
SELECT * FROM locations;
