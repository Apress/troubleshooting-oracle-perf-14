/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ParsingTest2.cs
Author......: Christian Antognini
Date........: March 2009
Description.: This file contains an implementation of test case 2.
Notes.......: Run the script ParsingTest.sql to create the required objects.
Parameters. : <user> <password> <service name>

You can send feedbacks or questions about this script to top@antognini.ch.

Changes:
DD.MM.YYYY Description
---------------------------------------------------------------------------

**************************************************************************/

using System;
using Oracle.DataAccess.Client;

namespace TOP
{
    class ParsingTest2
    {
        static void Main(string[] args)
        {
            String user;
            String password;
            String dataSource;

            if (args.GetLength(0) != 3)
            {
                Console.WriteLine("usage: ParsingTest2.exe <user> <password> <service name>");
                return;
            }
            else
            {
                user = args[0];
                password = args[1];
                dataSource = args[2];
            }

            String connectString = "User Id=" + user + ";Password=" + password + ";Data Source=" + dataSource;
            // String connectString = "User Id=" + user + ";Password=" + password + ";Data Source=" + dataSource + ";Statement Cache Size=1";
            OracleConnection connection = new OracleConnection(connectString);

            try
            {
                connection.Open();
                connection.ClientId = "ChA";

                DateTime startTime = DateTime.Now;
                test(connection);
                DateTime stopTime = DateTime.Now;
                Console.WriteLine(stopTime-startTime);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            finally
            {
                if (connection.State == System.Data.ConnectionState.Open)
                {
                    connection.Close();
                    connection.Dispose();
                }
            }
        }

        private static void test(OracleConnection connection)
        {
            String sql;
            OracleCommand command;
            OracleParameter parameter;
            OracleDataReader reader;
            String pad;

            sql = "SELECT pad FROM t WHERE val = :val";
            command = new OracleCommand(sql, connection);
            parameter = new OracleParameter("val", OracleDbType.Int32);

            command.Parameters.Add(parameter);
            // command.AddToStatementCache = false;

            for (int i = 0; i < 10000; i++)
            {
                parameter.Value = Convert.ToInt32(i);
                reader = command.ExecuteReader();
                if (reader.Read())
                {
                    pad = reader[0].ToString();
                    //Console.WriteLine(pad);
                }
                reader.Close();
            }
        }
    }
}
