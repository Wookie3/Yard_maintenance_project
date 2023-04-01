-- Sample test data for YardKeeper DB

INSERT INTO yard_keeper.staff(first_name, last_name, is_crew_lead)
VALUES
	('Jon', 'Doe', '1'),
    ('Debbie', 'Downer', '0'),
    ('Jack', 'Nickles', '0'),
    ('Toby', 'Jorden', '0');

INSERT INTO yard_keeper.users(user_name, user_password, location_id)
	VALUES
		('New City Mall', 'super_password', '001'),
        ('Building Inc.', 'pass_word', '002');
        
INSERT INTO yard_keeper.locations(location_id, street_name, street_number, postal_code)
VALUES 
	('001', 'Weston Rd.', '1800', 'M7J2E6'),
    ('002', 'King St. E', '201', 'M5E2X1'),
    ('003', 'King St. E', '800', 'M5E3P4');

INSERT INTO yard_keeper.tasks(task_info, is_complete)
VALUES
	('Mow the all the back lawn around the pool area', '0'),
    ('Cut all hedges in the front facing area', '0'),
    ('Mutch all front flower beds.', '0');

