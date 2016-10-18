/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: RowPrefetching.cs
Author......: Christian Antognini
Date........: March 2009
Description.: This program provides an example of implementing the row
              prefetching with ODP.NET.
Notes.......: The table T created with row_prefetching.sql must exist.
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
    class RowPrefetching
    {
        static void Main(string[] args)
        {
            String user;
            String password;
            String dataSource;

            if (args.GetLength(0) != 3)
            {
                Console.WriteLine("usage: RowPrefetching.exe <user> <password> <service name>");
                return;
            }
            else
            {
                user = args[0];
                password = args[1];
                dataSource = args[2];
            }

            String connectString = "User Id=" + user + ";Password=" + password + ";Data Source=" + dataSource;
            OracleConnection connection = new OracleConnection(connectString);

            try
            {
                connection.Open();

                for (int i = 1; i <= 100; i++)
                {
                    DateTime startTime = DateTime.Now;
                    test(connection, i);
                    DateTime stopTime = DateTime.Now;
                    Console.WriteLine(i + " , " + (stopTime - startTime));
                }
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

        private static void test(OracleConnection connection, int fetchSize)
        {
            String sql;
            OracleCommand command;
            OracleDataReader reader;
            Decimal id;
            String pad;

            sql = "SELECT id, pad FROM t";
            command = new OracleCommand(sql, connection);
            command.AddToStatementCache = false;
            reader = command.ExecuteReader();
            reader.FetchSize = command.RowSize * fetchSize;
            while (reader.Read())
            {
                id = reader.GetDecimal(0);
                pad = reader.GetString(1);
                // process data
                // Console.WriteLine(id + " , " + pad);
            }
            reader.Close();
        }
    }
}
