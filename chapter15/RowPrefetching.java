/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: RowPrefetching.java
Author......: Christian Antognini
Date........: August 2008
Description.: This script provide an example of implementing row
              prefetching with JDBC.
Notes.......: The table T created with row_prefetching.sql must exist.
Parameters. : <user> <password> <jdbc url> <fetch size>

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------
23.12.2013 Suppressed warning + added parameter <fetch size>
**************************************************************************/

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class RowPrefetching
{
  public static void main(String[] args)
  {
    String user;
    String password;
    String url;
    int fetchSize;
    Connection connection = null;
    
    long startTime;
    long endTime;
    
    if (args.length != 4)
    {
      System.out.println("usage: java " + RowPrefetching.class.getName() + " <user> <password> <jdbc url> <fetch size>");
      return;
    }
    else
    {
      user = args[0];
      password = args[1];
      url = args[2];
      fetchSize = Integer.parseInt(args[3]);
    }

    try
    {
      connection = ConnectionUtil.connect(user, password, url);

      ConnectionUtil.setCliendId(connection, System.getProperty("user.name"));
      ConnectionUtil.setModuleName(connection, RowPrefetching.class.getName());

      startTime = System.currentTimeMillis();
      test(connection, fetchSize);
      endTime = System.currentTimeMillis();
      
      System.out.println("fetch size:    " + Integer.toString(fetchSize));
      System.out.println("response time: " + Long.toString(endTime-startTime));                
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    finally
    {
      ConnectionUtil.disconnect(connection);
    }
  }

  private static void test(Connection connection, int fetchSize) throws Exception
  {
    String sql;
    PreparedStatement statement;
    ResultSet resultset;
    @SuppressWarnings("unused")
    long id;
    @SuppressWarnings("unused")
    String pad;
    
    try
    {
      sql = "SELECT id, pad FROM t";
      statement = connection.prepareStatement(sql);
      statement.setFetchSize(fetchSize);
      resultset = statement.executeQuery();
      while (resultset.next())
      {
        id = resultset.getLong("id");
        pad = resultset.getString("pad"); 
        // process data
      }
      resultset.close();
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of test >>> " + e.getMessage());
    }
  }
}
