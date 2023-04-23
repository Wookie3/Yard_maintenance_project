-- SCRIPTS
USE yard_keeper;
SHOW TABLES;
SELECT * from staff;
SELECT * FROM items;
SELECT * from sign_out;
SELECT * from users;
SELECT * FROM locations;
SELECT * FROM tasks;



-- sign out an item
INSERT INTO yard_keeper.sign_out(item_id, time_out, time_in, staff_id)
	VALUES
		(2002, current_timestamp(), DEFAULT, 10),
        (2001, current_timestamp(), DEFAULT, 13),
        (2003, current_timestamp(), DEFAULT, 12)
	;
UPDATE items SET is_out = 1 WHERE item_id IN (2001, 2002, 2003);

SELECT * from sign_out;
SELECT * FROM items;

-- sign in an item
UPDATE items SET is_out = 0 WHERE item_id = 2003;
UPDATE sign_out SET time_in = current_timestamp() WHERE log_id = 304;
SELECT * from sign_out;
SELECT * FROM items;

-- see all item that are signed out:
SELECT item_id AS ID, item_type AS 'Type', time_updated AS 'Last Updated' 
FROM items WHERE is_out
;

-- see who has what signed out currently
SELECT so.item_id AS 'Item ID',time_out AS 'Signed Out', time_in AS 'Signed In', s.first_name AS 'First' , s.last_name AS 'Last' , s.staff_id AS 'Staff ID'
	FROM sign_out AS so
    JOIN staff AS s ON so.staff_id = s.staff_id WHERE time_in IS NOT NULL
    ;
    
    
-- creating a view; join 3 tables to show item type, when item was signed out and by what staff.
DROP VIEW IF EXISTS currently_signed_out;
CREATE VIEW currently_signed_out AS
SELECT so.item_id AS 'Item ID', i.item_type AS 'Type', so.time_out AS 'Signed Out', so.time_in AS 'Signed In', s.first_name AS 'First' , s.last_name AS 'Last' , s.staff_id AS 'Staff ID'
	FROM staff as s
    JOIN sign_out AS so ON so.staff_id = s.staff_id
    JOIN items as i on i.item_id = so.item_id
	WHERE so.time_in IS NOT NULL
;

SELECT * FROM currently_signed_out;


-- see all incomplete tasks and the address
SELECT task_id AS 'Task', task_info AS 'Description', l.street_name AS 'Street Name', l.street_number AS 'No.', l.postal_code AS 'Postal Code'
	FROM tasks AS t
    JOIN locations AS l
    ON t.location_id = l.location_id
    WHERE NOT is_complete;
    
-- see what users own what locations
SELECT location_id AS 'Location ID', street_name AS 'Street Name', street_number AS 'No.', u.user_name AS 'Customer'
	FROM locations AS l
    JOIN users as u
    ON u.user_id = l.user_id
    ORDER BY u.user_name ASC
;


-- add a new location
INSERT INTO yard_keeper.locations(location_id, street_name, street_number, postal_code, user_id)
VALUES 
	('106', 'Easton Rd.', '1100', 'M7B2E8', 1)
;

-- add a new tasks for the new location
INSERT INTO tasks(task_info, location_id)
	VALUES
		('Trim hedges in backyard', 106),
        ('Cut back all overgrown trees in backyard', 106),
        ('Recut garden edging in front beds along walkway to front door', 105),
        ('Plant 2 trees in front by walkway stairs', 104)
;

--  delete location then roll it back 
START TRANSACTION;
DELETE FROM yard_keeper.locations WHERE location_id = 101;
SELECT * FROM locations;
-- tasks location field will be null 
SELECT * FROM tasks;
ROLLBACK;

-- complete a task
UPDATE yard_keeper.tasks
SET is_complete = 1, 
time_complete = current_timestamp()
WHERE task_id = 8;
SELECT * FROM tasks;

-- see how many tasks are at each location, order most to least
SELECT count(task_id) AS 'Total tasks', location_id AS 'Location' FROM tasks GROUP BY location_id ORDER BY count(task_id) DESC;

-- see how many incomplete tasks are at each location, order most to least
SELECT count(task_id) AS 'Total tasks', location_id FROM tasks  WHERE is_complete = 0 GROUP BY location_id ORDER BY count(task_id) DESC;

-- see all tasks for a given location
SELECT task_id AS 'Task ID', task_info AS 'Description', is_complete AS 'Complete' from tasks WHERE location_id = 103;


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
-- promote staff member to crew lead (drives truck and is incharge of a maintenance crew)
UPDATE staff SET is_crew_lead = 1 WHERE staff_id = 13;
SELECT * FROM staff;



EXPLAIN  SELECT * FROM tasks;
SELECT * FROM locations;
