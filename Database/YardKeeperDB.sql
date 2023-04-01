DROP DATABASE IF EXISTS yard_keeper;
CREATE DATABASE yard_keeper;


CREATE TABLE yard_keeper.staff(
	staff_id INT PRIMARY KEY AUTO_INCREMENT, 
	first_name VARCHAR(35) NOT NULL, 
	last_name VARCHAR(35) NOT NULL, 
	is_crew_lead BOOLEAN NOT NULL
);


CREATE TABLE yard_keeper.users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(36) UNIQUE,
    user_password VARCHAR(18)
);

-- INSERT INTO yard_keeper.users(user_name, user_password, location_id)
-- 	VALUES
-- 		('New City Mall', 'super_password', '001'),
--         ('Building Inc.', 'pass_word', '002');

CREATE TABLE yard_keeper.locations(
	location_id INT PRIMARY KEY UNIQUE,
	street_name VARCHAR(48) NOT NULL,
	street_number VARCHAR(48) NOT NULL,
	postal_code VARCHAR(6)
);


CREATE TABLE yard_keeper.tasks(
task_id INT PRIMARY KEY AUTO_INCREMENT,
task_info VARCHAR(255),
is_complete BOOLEAN
);


ALTER TABLE users 
	ADD COLUMN location_id INT,
	ADD CONSTRAINT fk_users_location_id
	FOREIGN KEY (location_id) REFERENCES locations(location_id)
	ON UPDATE CASCADE
	ON DELETE CASCADE;
	
ALTER TABLE tasks 
	ADD COLUMN location_id INT, 
    ADD CONSTRAINT fk_tasks_location_id 
	FOREIGN KEY (location_id) REFERENCES locations(location_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;


ALTER TABLE locations 
	ADD COLUMN task_id INT, 
	ADD COLUMN user_id INT,
    ADD CONSTRAINT fk_locations_task_id
		FOREIGN KEY (task_id) REFERENCES tasks(task_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
	ADD CONSTRAINT fk_locations_user_id
		FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

CREATE TABLE yard_keeper.active_tasks(
task_id INT,
is_complete BOOLEAN,
location_id INT,
CONSTRAINT fk_active_tasks_task_id
	FOREIGN KEY (task_id) REFERENCES tasks(task_id)
    ON UPDATE CASCADE,
CONSTRAINT fk_active_tasks_is_complete
	FOREIGN KEY (is_complete) REFERENCES tasks(is_complete)
    ON UPDATE CASCADE,
CONSTRAINT fk_active_tasks_location_id
	FOREIGN KEY (location_id) REFERENCES locations(location_id)
    ON UPDATE CASCADE
);


-- SCRIPTS FOR TEST
SELECT task_id, is_complete, staff_id 
	FROM tasks AS t
    JOIN staff AS s
    ON s.staff_id = t.staff_id;

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
