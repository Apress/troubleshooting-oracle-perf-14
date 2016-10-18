/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: SessionAttributes12c.java
Author......: Christian Antognini
Date........: August 2013
Description.: This Java class shows how to set the client identifier,
              module name, and action name through JDBC. Even though this 
              class uses a JDBC API available as of Oracle Database 12.1 
              only, it can be used with older database releases (e.g. 10.2).
              For an example using the older JDBC API refer to the 
              SessionAttributes class.
Notes.......: To compile and run this class the JDBC JAR must be added to 
              the class path, e.g.:
              javac -cp ojdbc7.jar SessionAttributes12c.java
              java -cp .;ojdbc7.jar SessionAttributes12c
Parameters..: <user>      username
              <password>  password
              <jdbc url>  jdbc:oracle:thin:@host:port:sid

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class SessionAttributes12c
{
  static Connection connection = null;
  
  public static void main(String[] args)
  {
    String user;
    String password;
    String url;
    
    if (args.length != 3)
    {
      System.out.println("usage: java " + SessionAttributes12c.class.getName() + " <user> <password> <jdbc url>");
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
    byte[] buffer = new byte[2];

    System.out.println("To check the setting use the following SELECT statement:");
    System.out.println("SELECT client_identifier, module, action, ecid FROM v$session WHERE sid = " + getSessionId());
    System.out.println("Check V$SESSION, press RETURN to continue...");
    System.in.read(buffer);
    
    System.out.println("Set session information");
    connection.setClientInfo("OCSID.CLIENTID", getHostName());
    connection.setClientInfo("OCSID.MODULE", SessionAttributes12c.class.getName());
    connection.setClientInfo("OCSID.ACTION", "test session information");
//    connection.setClientInfo("OCSID.DBOP", "database operation");
//    connection.setClientInfo("OCSID.ECID", "execution context id");
//    connection.setClientInfo("OCSID.SEQUENCE_NUMBER", "42");
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
