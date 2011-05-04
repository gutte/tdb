<?php

session_start();
include('init_gdata.php');
include('Calendar.php');

if (isset($_SESSION['sessionToken'])) {
    $client = Zend_Gdata_AuthSub::getHttpClient($_SESSION['sessionToken']);
    
    //  we're going after   --->     $_POST['orderdate']
    createEvent($client, $_POST['orderdate']);
}

header('Location: http://tdb.nettisetti.com/index.php');

function createEvent ($client, $date='2011-04-30', //today
    $title='träning',
    $description='', $where = '',
    $startTime = '18:00', $duration = '2')
{
    $gdataCal = new Zend_Gdata_Calendar($client);
    $newEvent = $gdataCal->newEventEntry();

    $newEvent->title = $gdataCal->newTitle($title);
    $newEvent->where = array($gdataCal->newWhere($where));
    $newEvent->content = $gdataCal->newContent("$description");

    $when = $gdataCal->newWhen();
    $when->startTime = "{$date}T{$startTime}:00.000";
    
    $newEvent->when = array($when);

    // Upload the event to the calendar server
    // A copy of the event as it is recorded on the server is returned
    $createdEvent = $gdataCal->insertEvent($newEvent);
    return $createdEvent->id->text;
}



?>
