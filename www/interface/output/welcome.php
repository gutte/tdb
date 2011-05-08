<?php

/*
 * welcome.php
 * 
 * Main view BEFORE authentication.
 * 
 * Introduction screen
 * & link to google authentication
 * 
 */




include('header.php');

?>

<p>Welcome</p>

<?php
//authentication link

$authSubUrl = getAuthSubUrl();
    echo "<p><a href=\"$authSubUrl\">Login to your Google account to continue</a>.</p> ";

?>

<?php 

include('footer.php');


?>
