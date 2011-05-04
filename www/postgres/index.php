<html>
<head>

</head>

<body>

<?php

// database access parameters
// alter this as per your configuration
$host = "localhost";
$db = "tdb";

// open a connection to the database server
$connection = pg_connect ("host=$host dbname=$db");
if (!$connection)
{
die("Could not open connection to database server");
}
// generate and execute a query
$query = "SELECT * FROM trainingsessions";
$result = pg_query($connection, $query) or die("Error in query: $query.
" . pg_last_error($connection));
// get the number of rows in the resultset
$rows = pg_num_rows($result);
echo "There are currently $rows records in the database.";
// close database connection
pg_close($connection);


?>

</body>
</html>
