/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: SessionAttributes.java
Author......: Christian Antognini
Date........: August 2008
Description.: This Java class shows how to set the client identifier,
              module name, and action name through JDBC.
Notes.......: To compile and run this class the JDBC JAR must be added to 
              the class path, e.g.:
              javac -cp ojdbc5.jar SessionAttributes.java
              java -cp .;ojdbc5.jar SessionAttributes
Parameters..: <user>      username
              <password>  password
              <jdbc url>  jdbc:oracle:thin:@host:port:sid

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------
11.08.2013 Remove static references to class name
**************************************************************************/

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import oracle.jdbc.OracleConnection;

public class SessionAttributes
{
  static Connection connection = null;
  
  public static void main(String[] args)
  {
    String user;
    String password;
    String url;
    
    if (args.length != 3)
    {
      System.out.println("usage: java " + SessionAttributes.class.getName() + " <user> <password> <jdbc url>");
      return;
    }
    else
    {
      user = args[0];
      password = args[1];
      url = args[2];
    }

    try
    {
      connect(user, password, url);
      test();
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      disconnect();
    }
  }
  
  private static void test() throws Exception
  {
    String metrics[];
    byte[] buffer = new byte[2];

    System.out.println("To check the setting use the following SELECT statement:");
    System.out.println("SELECT client_identifier, module, action FROM v$session WHERE sid = " + getSessionId());
    System.out.println("Check V$SESSION, press RETURN to continue...");
    System.in.read(buffer);
    
    System.out.println("Set session information");
    metrics = new String[OracleConnection.END_TO_END_STATE_INDEX_MAX];
    metrics[OracleConnection.END_TO_END_CLIENTID_INDEX] = getHostName();
    metrics[OracleConnection.END_TO_END_MODULE_INDEX] = SessionAttributes.class.getName();
    metrics[OracleConnection.END_TO_END_ACTION_INDEX] = "test session information";
    metrics[OracleConnection.END_TO_END_ECID_INDEX] = "execution context id";
    ((OracleConnection)connection).setEndToEndMetrics(metrics, (short)0);
    getSessionId(); // db call to send the information to the server
    System.out.println("Check V$SESSION, press RETURN to continue...");
    System.in.read(buffer);
  }
  
  private static void connect(String user, String password, String url) throws Exception
  {
    try
    {
      DriverManager.registerDriver (new oracle.jdbc.OracleDriver());
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot register driver >>> " + e.getMessage());
    }

    try
    {
      connection = DriverManager.getConnection(url, user, password);
      connection.setAutoCommit(false);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot establish the connection >>> " + e.getMessage());
    }
  }
  
  private static long getSessionId()
  {
    long ret = -1;
    String sql = "SELECT sid FROM v$session WHERE audsid = userenv('sessionid')";
    Statement statement = null;
    ResultSet resultSet = null;
    
    try
    {
      statement = connection.createStatement();
      resultSet = statement.executeQuery(sql);
      if (resultSet.next())
      {
        ret = resultSet.getLong("sid");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      try { resultSet.close(); } catch (Exception e) { }
      try { statement.close(); } catch (Exception e) { }
    }
    
    return ret;
  }

  private static void disconnect()
  {
    try
    {
      if (connection != null)
      {
        connection.close();
      }
    }
    catch (SQLException e)
    {
    }
  }

  private static String getHostName() throws UnknownHostException
  {
    return InetAddress.getLocalHost().getHostName();
  }

}
