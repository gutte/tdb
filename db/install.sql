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

\i db/tables/TrainingSessions.sql
\i db/tables/TrainingEvents.sql


-- Create functions

\i db/functions/New_Training_Session.sql
\i db/functions/New_Training_Event.sql
\i db/functions/Update_Training_Event.sql


-- Grant limited rights to phpuser

\i db/users/phpuser.sql


COMMIT;
