<?php
/*
 * index.php
 */


//setup gdata

session_start();
include('init_gdata.php');
include('Calendar.php');




?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
	<title>tdb - test</title>
	<meta http-equiv="content-type" content="text/html;charset=utf-8" />
	<meta name="generator" content="Geany 0.19.1" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    
    <script type="text/javascript" src="calendarDateInput.js"></script>
</head>

<body>

<?php

if (! isset($_SESSION['sessionToken']) && isset($_GET['token'])) {
    $_SESSION['sessionToken'] = 
    Zend_Gdata_AuthSub::getAuthSubSessionToken($_GET['token']);
} else if (! isset($_SESSION['sessionToken']) && ! isset($_GET['token'])) {
    $authSubUrl = getAuthSubUrl();
    echo "<a href=\"$authSubUrl\">Login to your Google account to continue</a>. ";
}

if (isset($_SESSION['sessionToken'])) {
    
    $client = Zend_Gdata_AuthSub::getHttpClient($_SESSION['sessionToken']);
    
    ?>
    <div id="left">
    <p>Your calender events on my website:</p>
    <?php
    outputCalendar($client);
    ?>
    </div>
    <div id="right">
        <p>Add a sporting event to your calendar.</p>
        <form name="input" action="newEvent.php" method="post">
        
        <script>DateInput('orderdate', true, 'YYYY-MM-DD')</script>
        
        <input type="submit" value="Create" />
        
        </form>
    
    
    </div>
    <?php
}


?>
</body>

</html>
