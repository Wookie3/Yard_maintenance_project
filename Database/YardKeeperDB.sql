START TRANSACTION;
DROP DATABASE IF EXISTS yard_keeper;
CREATE DATABASE yard_keeper;
USE yard_keeper;

DROP TABLE IF EXISTS yard_keeper.staff;
CREATE TABLE yard_keeper.staff(
	staff_id INT PRIMARY KEY AUTO_INCREMENT, 
	first_name VARCHAR(35) NOT NULL, 
	last_name VARCHAR(35) NOT NULL, 
	is_crew_lead BOOLEAN DEFAULT 0,
    is_admin BOOLEAN DEFAULT 0
);

INSERT INTO yard_keeper.staff(first_name, last_name, is_crew_lead, is_admin)
VALUES
	('Jon', 'Doe', '1', '0'),
    ('Debbie', 'Downer', '0', '0'),
    ('Jack', 'Nickles', '0', '0'),
    ('Toby', 'Jorden', '0', '1')
;
DROP TABLE IF EXISTS yard_keeper.sign_out;
CREATE TABLE yard_keeper.sign_out(
	item_id INT PRIMARY KEY UNIQUE,
    item_type VARCHAR(48) NOT NULL,
	time_updated DATETIME,
    is_out BOOLEAN DEFAULT 0,
    staff_id INT DEFAULT NULL,
    CONSTRAINT fk_sign_out_staffid
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
);

INSERT INTO yard_keeper.sign_out(item_id, item_type, time_updated)
VALUES
	(2010, 'truck', current_timestamp()),
    (2020, 'truck', current_timestamp()),
    (2030, 'truck', current_timestamp()),
    (2040, 'tool_chest', current_timestamp()),
    (2050, 'mower', current_timestamp())
;



CREATE TABLE yard_keeper.users(
	user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(36) UNIQUE,
    user_password VARCHAR(28)
);

INSERT INTO yard_keeper.users(user_name, user_password)
	VALUES
		('New City Mall', 'super_password'),
        ('Building Inc.', 'pass_word'),
        ('Greenbelt Properties', 'pa55w0rd')
;

CREATE TABLE yard_keeper.locations(
	location_id INT PRIMARY KEY UNIQUE,
	street_name VARCHAR(48) NOT NULL,
	street_number VARCHAR(12) NOT NULL,
	postal_code VARCHAR(6),
    user_id INT,
	CONSTRAINT fk_locations_user_id
	FOREIGN KEY (user_id) REFERENCES users(user_id)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);


INSERT INTO yard_keeper.locations(location_id, street_name, street_number, postal_code, user_id)
VALUES 
	('101', 'Weston Rd.', '1800', 'M7J2E6', '001'),
    ('102', 'King St. E', '201', 'M5E2X1', '002'),
    ('103', 'King St. E', '800', 'M5E3P4', '002'),
    ('104', 'Front St. W', '550', 'M6J2E4', '003'),
    ('105', 'Queen St. W', '106', 'M7F1R6', '003')
;


DROP TABLE IF EXISTS yard_keeper.tasks;
CREATE TABLE yard_keeper.tasks(
	task_id INT PRIMARY KEY AUTO_INCREMENT,
	task_info VARCHAR(255),
    time_added DATETIME DEFAULT CURRENT_TIMESTAMP,
    time_complete DATETIME DEFAULT NULL,
	is_complete BOOLEAN DEFAULT 0,
    location_id INT,
    CONSTRAINT fk_tasks_location_id 
	FOREIGN KEY (location_id) REFERENCES locations(location_id)
	ON UPDATE CASCADE
    ON DELETE SET NULL
);



INSERT INTO yard_keeper.tasks(task_info, is_complete, location_id)
VALUES
	('Mow the all the back lawn around the pool area', '0', 101),
    ('Cut all hedges in the front facing area', '0', 101),
    ('Mutch all front flower beds.', '0', 103),
    ('Mow back lawn', '0', 102),
    ('Multch front beds', '0', 103),
    ('Multch back beds', '0', 103)
;
COMMIT;
