<?php

/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: RowPrefetching.php
Author......: Christian Antognini
Date........: December 2013
Description.: This program provides an example of implementing the row
              prefetching with PHP.
Notes.......: The table T created with row_prefetching.sql must exist.
Parameters. : <user> <password> <service name>

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
    $fetch_size = get_parameter("fetch_size");
  }
  catch (Exception $e)
  {
    echo "<p>To run this script four parameters are needed:</p>";
    echo "<ul>";
    echo "<li>username</li>";
    echo "<li>password</li>";
    echo "<li>connect_string</li>";
    echo "<li>fetch_size</li>";
    echo "</ul>";
    echo "<p>E.g.: RowPrefetching.php?username=SCOTT&password=TIGER&connect_string=ORCL&fetch_size=42</p>";
    trigger_error("Invalid parameters", E_USER_ERROR);
  }

  // open connection

  $connection = oci_connect($username, $password, $connect_string);

  if (!$connection)
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }

  oci_set_client_identifier($connection, "cha");

  // test
 
  $sql = "SELECT id, pad FROM t";
  $statement = oci_parse($connection, $sql);
  oci_set_prefetch($statement, $fetch_size);
  oci_execute($statement, OCI_NO_AUTO_COMMIT);
  while ($row = oci_fetch_assoc($statement))
  {
    $id = $row['ID'];
    $pad = $row['PAD'];
    // process data
  }
  oci_free_statement($statement);

  // close connection

  if (!oci_close($connection))
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }

  echo "<p>execution successful</p>";

?>

