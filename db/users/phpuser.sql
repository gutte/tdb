

-- create php user and grant appropriate rights

CREATE ROLE "www-data";
GRANT CONNECT ON DATABASE tdb TO "www-data";

GRANT EXECUTE ON FUNCTION New_Training_Session(timestamptz, text) TO "www-data";
