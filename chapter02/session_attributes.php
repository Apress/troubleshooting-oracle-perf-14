<?php

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
    echo "<p>E.g.: session_attributes.php?username=SCOTT&password=TIGER&connect_string=ORCL</p>";
    trigger_error("Invalid parameters", E_USER_ERROR);
  }

  // open connection

  $connection = oci_connect($username, $password, $connect_string);

  if (!$connection)
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }


  // set the attributes

  oci_set_client_identifier($connection, "helicon.antognini.ch");
  oci_set_client_info($connection, "Linux x86_64");
  oci_set_module_name($connection, "session_attributes.php");
  oci_set_action($connection, "test session information");

  // cause a roundtrip

  oci_commit($connection);

  // close connection

  if (!oci_close($connection))
  {
    $error = oci_error();
    trigger_error($error['message'], E_USER_ERROR);
  }

  echo "<p>execution successful</p>";

?>
