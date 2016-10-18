/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ArrayInterfacePerf.java
Author......: Christian Antognini
Date........: August 2008
Description.: This script shows that the array interface can greatly
              improve the response time of a large load.
Notes.......: The table T created with array_interface.sql must exist.
Parameters. : <user> <password> <jdbc url>

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------
24.06.2010 Fixed number of iterations in main method
**************************************************************************/

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class ArrayInterfacePerf
{
  public static void main(String[] args)
  {
    String user;
    String password;
    String url;
    Connection connection = null;
    
    long startTime;
    long endTime;
    
    if (args.length != 3)
    {
      System.out.println("usage: java " + ArrayInterfacePerf.class.getName() + " <user> <password> <jdbc url>");
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
      connection = ConnectionUtil.connect(user, password, url);

      ConnectionUtil.setCliendId(connection, System.getProperty("user.name"));
      ConnectionUtil.setModuleName(connection, ArrayInterfacePerf.class.getName());

      startTime = System.currentTimeMillis();
      test(connection, 100000);
      endTime = System.currentTimeMillis();
      System.out.println("1 , " + (endTime-startTime));         
      connection.commit();

      for (int i=2 ; i<=100 ; i++)
      {
        startTime = System.currentTimeMillis();
        testBatch(connection, 100000, i);
        endTime = System.currentTimeMillis();
        System.out.println(Integer.toString(i) + " , " + (endTime-startTime));                
        connection.commit();
      }
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

  private static void test(Connection connection, int rows) throws Exception
  {
    String sql;
    PreparedStatement statement;
    
    try
    {
      sql = "INSERT INTO t VALUES (?, ?)";
      statement = connection.prepareStatement(sql);
      for (int i=1 ; i<=rows ; i++)
      {
        statement.setInt(1, i);
        statement.setString(2, "****************************************************************************************************");
        statement.executeUpdate();
      }
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of test >>> " + e.getMessage());
    }
  }

  private static void testBatch(Connection connection, int rows, int batchSize) throws Exception
  {
    String sql;
    PreparedStatement statement;
    
    try
    {
      sql = "INSERT INTO t VALUES (?, ?)";
      statement = connection.prepareStatement(sql);
      for (int i=1 ; i<=rows ; )
      {
        for (int j=1 ; j<=batchSize && i<=rows ; j++)
        {
          statement.setInt(1, i++);
          statement.setString(2, "****************************************************************************************************");
          statement.addBatch();
        }
        statement.executeBatch();
      }
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of test >>> " + e.getMessage());
    }
  }
}
