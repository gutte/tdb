

-- create php user and grant appropriate rights

CREATE ROLE "www-data";
GRANT ALL ON DATABASE tdb TO "www-data";
