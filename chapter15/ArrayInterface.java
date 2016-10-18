/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ArrayInterface.java
Author......: Christian Antognini
Date........: August 2008
Description.: This script provide an example of implementing the array
              interface with JDBC.
Notes.......: The table T created with array_interface.sql must exist.
Parameters. : <user> <password> <jdbc url> <batch size>

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------
24.06.2010 Added check for the return value of the executeBatch method
23.12.2013 Fixed warning + added parameter <batch size>
**************************************************************************/

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class ArrayInterface
{
  public static void main(String[] args)
  {
    final int NUMBER_OF_ROWS_TO_INSERT = 100000;

    String user;
    String password;
    String url;
    int batchSize;
    Connection connection = null;
    
    long startTime;
    long endTime;
    
    if (args.length != 4)
    {
      System.out.println("usage: java " + ArrayInterface.class.getName() + " <user> <password> <jdbc url> <array size>");
      return;
    }
    else
    {
      user = args[0];
      password = args[1];
      url = args[2];
      batchSize = Integer.parseInt(args[3]);
    }
    
    if (batchSize < 1)
    {
      batchSize = 1;
    }

    try
    {
      connection = ConnectionUtil.connect(user, password, url);

      ConnectionUtil.setCliendId(connection, System.getProperty("user.name"));
      ConnectionUtil.setModuleName(connection, ArrayInterface.class.getName());

      ConnectionUtil.setActionName(connection, "test");
      startTime = System.currentTimeMillis();
      test(connection, NUMBER_OF_ROWS_TO_INSERT);
      endTime = System.currentTimeMillis();
      System.out.println("response time in milliseconds without array interface: " + Long.toString(endTime-startTime));         
      connection.commit();

      ConnectionUtil.setActionName(connection, "testBatch");
      startTime = System.currentTimeMillis();
      testBatch(connection, NUMBER_OF_ROWS_TO_INSERT, batchSize);
      endTime = System.currentTimeMillis();
      System.out.println("response time in milliseconds with array interface:    " + Long.toString(endTime-startTime));         
      connection.commit();
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
    int[] counts;
    
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
        counts = statement.executeBatch();

        // if the execution is successful, SUCCESS_NO_INFO is returned for every statement 
        // (this is a limitation of the Oracle JDBC driver)
        // otherwise, an SQLExection exception is raised
        for (int j=0 ; j<batchSize ; j++)
        {
          if (counts[j] != PreparedStatement.SUCCESS_NO_INFO)
          {
            throw new Exception("Return value of execution nr. " + Integer.toString(i+1) + " is not SUCCESS_NO_INFO");
          }
        }
      }
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of testBatch >>> " + e.getMessage());
    }
  }
}
