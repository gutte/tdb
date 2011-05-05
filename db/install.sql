$ psql

-- Create a user:
CREATE ROLE tdb WITH SUPERUSER;
SET ROLE TO tdb;

-- Create the database:
CREATE DATABASE tdb;

-- Connect to the database you just created:
\c tdb

-- Install the languages we need for our stored procedures:
CREATE LANGUAGE plpgsql;
CREATE LANGUAGE plperl;
CREATE LANGUAGE plperlu;


-- use a transaction for the imports

BEGIN;


-- Create tables

\i tables/TrainingSessions.sql
\i tables/TrainingEvents.sql


-- Create functions

\i functions/New_Training_Session.sql
\i functions/New_Training_Event.sql
\i functions/Update_Training_Event.sql


-- Grant limited rights to phpuser

\i users/phpuser.sql


COMMIT;
