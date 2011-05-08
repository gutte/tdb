<?php

/*
 * loader.php
 * 
 * including all functions
 * 
 */


// include Zend Gdata path (path should be included globally later)

$clientLibraryPath = '/home/gutte/Webdev/downloads/ZendGdata-1.11.5/library';
$oldPath = set_include_path(get_include_path() . PATH_SEPARATOR . $clientLibraryPath);


// load gdata classes

require_once 'Zend/Loader.php';
Zend_Loader::loadClass('Zend_Gdata');
Zend_Loader::loadClass('Zend_Gdata_AuthSub');
Zend_Loader::loadClass('Zend_Gdata_ClientLogin');
Zend_Loader::loadClass('Zend_Gdata_Calendar');

// include all functions


include('functions/Calendar.php');


?>
