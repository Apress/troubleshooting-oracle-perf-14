/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ConnectionUtil.java
Author......: Christian Antognini
Date........: August 2008
Description.: The class contained in this file is used by the Java
              implementation of test case 1, 2 and 3 respectively.
Notes.......: Run the script ParsingTest.sql to create the required objects.
Parameters. : -

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;

public class ConnectionUtil
{
  public static Connection connect(String user, String password, String url) throws Exception
  {
    Properties connectionProperties = null;
    OracleDataSource dataSource = null;
    Connection connection = null;
    
    
    try
    {
      dataSource = new OracleDataSource();
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot instantiate data source >>> " + e.getMessage());
    }
    
    connectionProperties = new Properties();
    connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_USER_NAME, user);
    connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_PASSWORD, password);
    connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_DEFAULT_ROW_PREFETCH, "1");
    dataSource.setConnectionProperties(connectionProperties);
    dataSource.setURL(url);

    try
    {
      connection = dataSource.getConnection();
      connection.setAutoCommit(false);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot establish the connection >>> " + e.getMessage());
    }
    
    //DatabaseMetaData info = connection.getMetaData ();
    //System.out.println("Driver name:              " + info.getDriverName());
    //System.out.println("Driver version:           " + info.getDriverVersion());
    //System.out.println("Database product name:    " + info.getDatabaseProductName());
    //System.out.println("Database product version: " + info.getDatabaseProductVersion());

    return connection;
  }

  public static void disconnect(Connection connection)
  {
    if (connection != null) 
    {
      try
      {
        connection.close();
      }
      catch (SQLException e)
      {
      }
    }
  }
  
  private static String metrics[] = new String[OracleConnection.END_TO_END_STATE_INDEX_MAX];

  public static void setCliendId(Connection connection, String clientId) throws Exception
  {
    try
    {
      metrics[OracleConnection.END_TO_END_CLIENTID_INDEX] = clientId;
      ((OracleConnection)connection).setEndToEndMetrics(metrics, (short)0);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot set client identifier >>> " + e.getMessage());
    }
  }
  
  public static void setModuleName(Connection connection, String module) throws Exception
  {
    try
    {
      metrics[OracleConnection.END_TO_END_MODULE_INDEX] = module;
      ((OracleConnection)connection).setEndToEndMetrics(metrics, (short)0);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot set module name >>> " + e.getMessage());
    }
  }
  
  public static void setActionName(Connection connection, String action) throws Exception
  {
    try
    {
      metrics[OracleConnection.END_TO_END_ACTION_INDEX] = action;
      ((OracleConnection)connection).setEndToEndMetrics(metrics, (short)0);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot set action name >>> " + e.getMessage());
    }
  }

  public static void enableStatementCaching(Connection connection, int size) throws Exception
  {
    try
    {
      ((OracleConnection)connection).setImplicitCachingEnabled(true);
      ((OracleConnection)connection).setStatementCacheSize(size);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot enable statement caching >>> " + e.getMessage());
    }
  }

  public static void disableStatementCaching(Connection connection) throws Exception
  {
    try
    {
      ((OracleConnection)connection).setImplicitCachingEnabled(false);
    }
    catch (SQLException e)
    {
      throw new Exception("Cannot disable statement caching >>> " + e.getMessage());
    }
  }
}
