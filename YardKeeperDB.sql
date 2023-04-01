DROP DATABASE IF EXISTS yard_keeper;
CREATE DATABASE yard_keeper;


CREATE TABLE yard_keeper.staff(
	staff_id INT PRIMARY KEY AUTO_INCREMENT, 
	first_name VARCHAR(35) NOT NULL, 
	last_name VARCHAR(35) NOT NULL, 
	is_crew_lead BOOLEAN NOT NULL
);

INSERT INTO yard_keeper.staff(first_name, last_name, is_crew_lead)
VALUES
	('Jon', 'Doe', '1'),
    ('Debbie', 'Downer', '0'),
    ('Jack', 'Nickles', '0'),
    ('Toby', 'Jorden', '0');

CREATE TABLE yard_keeper.users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(36) UNIQUE,
    user_password VARCHAR(18)
    -- location_id INT,
--     CONSTRAINT fk_users_location_id
-- 		FOREIGN KEY (location_id) REFERENCES locations(location_id)
--         ON UPDATE CASCADE
);

INSERT INTO yard_keeper.users(user_name, user_password, location_id)
	VALUES
		('New City Mall', 'super_password', '001'),
        ('Building Inc.', 'pass_word', '002');

CREATE TABLE yard_keeper.locations(
	location_id INT PRIMARY KEY UNIQUE,
	street_name VARCHAR(48) NOT NULL,
	street_number VARCHAR(48) NOT NULL,
	postal_code VARCHAR(6),
	task_id INT,
	user_id INT,
    CONSTRAINT fk_locations_task_id
		FOREIGN KEY (task_id) REFERENCES tasks(task_id)
        ON UPDATE CASCADE,
	CONSTRAINT fk_locations_user_id
		FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON UPDATE CASCADE
);

INSERT INTO yard_keeper.locations(location_id, street_name, street_number, postal_code)
VALUES 
	('001', 'Weston Rd.', '1800', 'M7J2E6'),
    ('002', 'King St. E', '201', 'M5E2X1'),
    ('003', 'King St. E', '800', 'M5E3P4');

CREATE TABLE yard_keeper.tasks(
task_id INT PRIMARY KEY AUTO_INCREMENT,
task_info VARCHAR(255),
is_complete BOOLEAN,
location_id INT,
CONSTRAINT fk_tasks_location_id
	FOREIGN KEY (location_id) REFERENCES locations(location_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO yard_keeper.tasks(task_info, is_complete)
VALUES
	('Mow the all the back lawn around the pool area', '0'),
    ('Cut all hedges in the front facing area', '0'),
    ('Mutch all front flower beds.', '0');

CREATE TABLE yard_keeper.active_tasks(
task_id INT,
is_complete BOOLEAN,
staff_id INT,
CONSTRAINT fk_active_tasks_task_id
	FOREIGN KEY (task_id) REFERENCES tasks(task_id)
    ON UPDATE CASCADE,
CONSTRAINT fk_active_tasks_is_complete
	FOREIGN KEY (is_complete) REFERENCES tasks(is_complete)
    ON UPDATE CASCADE,
CONSTRAINT fk_active_tasks_staff_id
	FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE
);

drop table locations;
-- update staff memeber
UPDATE staff SET is_crew_lead = '1' WHERE staff_id = '4';
-- update a user to add a location
UPDATE users SET location_id = '006' WHERE user_id ='2';
SELECT * from users;
SELECT * from staff;
SELECT * from locations;
SELECT * FROM staff WHERE is_crew_lead;


ALTER TABLE users ADD COLUMN location_id INT;
ALTER TABLE users ADD CONSTRAINT fk_users_location_id
		FOREIGN KEY (location_id) REFERENCES locations(location_id)
        ON UPDATE CASCADE;