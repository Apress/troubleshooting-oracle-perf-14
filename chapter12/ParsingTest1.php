<?php

/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ParsingTest1.php
Author......: Christian Antognini
Date........: August 2013
Description.: This file contains an implementation of test case 1.
Notes.......: Run the script ParsingTest.sql to create the required objects.
Parameters. : -

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

  // definition of internal functions

  function get_parameter($name)
  {
    if (isset($_GET[$name]))
    {
      return $_GET[$name];
    }
    else
    {
      throw new Exception("parameter not defined");
    }
  }


  // get parameters

  try
  {
    $username = get_parameter("username");
    $password = get_parameter("password");
    $connect_string = get_parameter("connect_string");
  }
  catch (Exception $e)
  {
    echo "<p>To run this script three parameters are needed:</p>";
    echo "<ul>";
    echo "<li>username</li>";
    echo "<li>password</li>";
    echo "<li>connect_string</li>";
    echo "</ul>";
    echo "<p>E.g.: ParsingTest1.php?username=SCOTT&password=TIGER&connect_string=ORCL</p>";
    trigger_error("Invalid parameters", E_USER_ERROR);
  }

  // open connection

  $connection = oci_connect($username, $password, $connect_string);

  if (!$connection)
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }

  // test
  
  for ($i = 1; $i <= 10000; $i++) 
  {
	  $statement = oci_parse($connection, "SELECT pad FROM t WHERE val = " . $i);
	  oci_execute($statement, OCI_NO_AUTO_COMMIT);
	  if ($row = oci_fetch_assoc($statement))
	  {
	    $pad = $row['PAD'];
	  }
	  oci_free_statement($statement);
  }

  // close connection

  if (!oci_close($connection))
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }

  echo "<p>execution successful</p>";

?>
