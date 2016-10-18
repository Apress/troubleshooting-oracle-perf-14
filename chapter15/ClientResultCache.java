/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ClientResultCache.java
Author......: Christian Antognini
Date........: December 2013
Description.: The class contained in this file provides an example of 
              implementation taking advantage of the client result cache.
Notes.......: Run the script chapter12/ParsingTest.sql to create the 
              required objects.
Parameters. : <user>           the name of the user
              <password>       the password of the user
              <jdbc url>       an Oracle connection string using OCI
              <stm_cache_size> the number of statements to be cached,
                               values lower than 1 disables the client
                               result cache!

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

import java.util.Properties;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;

public class ClientResultCache
{

  public static void main(String[] args)
  {
    Properties connectionProperties = null;
    OracleDataSource dataSource = null;
    Connection connection = null;
    
    if (args.length != 4)
    {
      System.out.println("usage: java " + ClientResultCache.class.getName() + " <user> <password> <jdbc url> <stm_cache_size>");
      return;
    }

    try
    {
      connectionProperties = new Properties();
      connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_USER_NAME, args[0]);
      connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_PASSWORD, args[1]);
      connectionProperties.put(OracleConnection.CONNECTION_PROPERTY_IMPLICIT_STATEMENT_CACHE_SIZE, args[3]);
      dataSource = new OracleDataSource();
      dataSource.setConnectionProperties(connectionProperties);
      dataSource.setURL(args[2]);
      connection = dataSource.getConnection();

      long rt1 = getRoundTrips(connection);
      test(connection);
      long rt2 = getRoundTrips(connection);
      System.out.println("number of network round-trips: " + Long.toString(rt2-rt1));
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
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
  }
  
  private static void test(Connection connection) throws Exception
  {
    String sql;
    PreparedStatement statement;
    ResultSet resultset;
    
    @SuppressWarnings("unused")
    String pad;
    
    try
    {
      sql = "SELECT /*+ result_cache */ pad FROM t WHERE val = 42";
      for (int i=0 ; i<10000; i++)
      {
        statement = connection.prepareStatement(sql);
        resultset = statement.executeQuery();
        if (resultset.next())
        {
          pad = resultset.getString("pad");       
        }
        resultset.close();
        statement.close();
      }
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of test >>> " + e.getMessage());
    }
  }
  
  private static long getRoundTrips(Connection connection) throws Exception
  {
    String sql;
    PreparedStatement statement;
    ResultSet resultset;
    
    long ret = -1;
    
    try
    {
      sql = "SELECT value FROM v$mystat NATURAL JOIN v$statname WHERE name = 'SQL*Net roundtrips to/from client'";
      statement = connection.prepareStatement(sql);
      resultset = statement.executeQuery();
      if (resultset.next())
      {
        ret = resultset.getLong("value");       
      }
      resultset.close();
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of getRoundTrips >>> " + e.getMessage());
    }

    return ret;
  }
  
}

