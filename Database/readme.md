# Yard Keeper Database
### Files 
First file "YardKeeperDB.sql" is to create the database and populate it with some simple sample data.
Second file "db_scripts.sql" contains all the scripts for using the database as well as the select statements.

## Description

This database is meant to facilitate the day to day operations of a landscape service business.
The main three tables are for tracking and completing tasks at different addresses around the city. A customer (user) will add tasks at their properties (locations) where they will need to be completed by the company staff. 
The other two tables are linked through a joining table (sign_out) and are an equipment table (items) along with a sign out table (sign_out).

Some of the included select statements would be examples of what company staff would need to have access to. Such as a list of how many tasks need to be completed at each location or a list of all the equipment in the items table that has been signed out. There is also a view included for seeing the items currently signed out along with their item_type and staff information of who has it.
There are script examples for the day-to-day operations that would be performed by the company such as adding a new location or task and deleting a complete task. 

I originally wanted to pursue the scheduling side of this application as well as day-to-day operations of a landscape company. 
I decided to focus only on the company operations and landscape tasks instead, I felt this gave me a good chance to learn the course concepts properly.

Below is an image of my EER diagram


![DB_EER](https://drive.google.com/uc?id=1bmUN9Q_Z_HObQOelJYL4QNPSY_8Maork)
