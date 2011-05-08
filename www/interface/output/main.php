<?php

/*
 * main.php
 * 
 * Main view after succesful login and synchro.
 * 
 */




include('header.php');

?>

main.php

<p>Your calender events on my website:</p>

<?php
outputCalendar($client);
?>


<?php 

include('footer.php');


?>
