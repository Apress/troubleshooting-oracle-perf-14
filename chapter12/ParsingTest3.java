/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ParsingTest3.java
Author......: Christian Antognini
Date........: August 2008
Description.: This file contains an implementation of test case 3.
Notes.......: Run the script ParsingTest.sql to create the required objects.
Parameters. : -

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------
17.08.2013 Suppressed warning + added CPU utilization to output
**************************************************************************/

import java.lang.management.ManagementFactory;
import java.lang.management.ThreadMXBean;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ParsingTest3
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
      System.out.println("usage: java " + ParsingTest3.class.getName() + " <user> <password> <jdbc url>");
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
      ConnectionUtil.setModuleName(connection, ParsingTest3.class.getName());

      startTime = System.currentTimeMillis();
      test(connection);
      endTime = System.currentTimeMillis();
      System.out.println("response time: " + Long.toString(endTime-startTime) + "ms");        
      System.out.println("CPU time:      " + getCpuTime() + "ms");        
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
  
  private static void test(Connection connection) throws Exception
  {
    String sql;
    PreparedStatement statement;
    ResultSet resultset;
    
    @SuppressWarnings("unused")
    String pad;
    
    try
    {
      sql = "SELECT pad FROM t WHERE val = ?";
      statement = connection.prepareStatement(sql);
      for (int i=0 ; i<10000; i++)
      {
        statement.setInt(1, i);
        resultset = statement.executeQuery();
        if (resultset.next())
        {
          pad = resultset.getString("pad");          
        }
        resultset.close();
      }
      statement.close();
    }
    catch (SQLException e)
    {
      throw new Exception("Error during execution of test >>> " + e.getMessage());
    }
  }
  
  private static long getCpuTime() 
  {
    long ret;
    
    ThreadMXBean bean = ManagementFactory.getThreadMXBean();
    if (bean.isCurrentThreadCpuTimeSupported())
    {
      ret = bean.getCurrentThreadCpuTime() / 1000000L; // convert time from nanoseconds to milliseconds
    }
    else
    {
      ret = -1L;
    }

    return ret;
  }
}
