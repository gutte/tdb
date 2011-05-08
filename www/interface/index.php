<?php

/* index.php
 * 
 * Main file controlling the user interface.
 * 
 * 
 */
session_start();

include('loader.php');

// includes of functions and classes



// if gcal connection (authentication) has not been established
if (! isset($_SESSION['sessionToken']) ) {
    
    // if token has been set
    if (isset($_GET['token'])) {
        //make session token.
        $_SESSION['sessionToken'] = 
            Zend_Gdata_AuthSub::getAuthSubSessionToken($_GET['token']);
        
        // reload index.php with header
        // exit
    } else {
    
        // display welcome screen with link to authenticate.
        include('output/welcome.php');
    }
    
} else {
    
    // get Gdata client
    $client = Zend_Gdata_AuthSub::getHttpClient($_SESSION['sessionToken']);
    
    
    
    
    // if no training calendars are associated with the user
    if (0) {
        // display "setup calender" view
        
    } else {
        
        // synchronisation of calendars
        // & parsing of activities
        
        // if sync or parsing UNsuccessful
        if(0) {
            // view for manually resolving conflicts
            // error messages..
            
        } else {
            
            // main view
            include('output/main.php');
        }
        
    }
    
}



?>
