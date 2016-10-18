/**************************************************************************
******************* Troubleshooting Oracle Performance ********************
************************* http://top.antognini.ch *************************
***************************************************************************

File name...: ArrayInterface.cs
Author......: Christian Antognini
Date........: March 2009
Description.: This program provides an example of implementing the array
              interface with ODP.NET.
Notes.......: The table T created with array_interface.sql must exist.
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
    class ArrayInterface
    {
        static void Main(string[] args)
        {
            String user;
            String password;
            String dataSource;
            DateTime startTime;
            DateTime stopTime;

            if (args.GetLength(0) != 3)
            {
                Console.WriteLine("usage: ArrayInterface.exe <user> <password> <service name>");
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

                startTime = DateTime.Now;
                test(connection, 100000, 1);
                stopTime = DateTime.Now;
                Console.WriteLine(stopTime - startTime);

                startTime = DateTime.Now;
                test(connection, 100000, 100);
                stopTime = DateTime.Now;
                Console.WriteLine(stopTime - startTime);
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

        private static void test(OracleConnection connection, int rows, int batchSize)
        {
            String sql;
            OracleCommand command;
            OracleParameter id;
            OracleParameter pad;

            Decimal[] idValues = new Decimal[rows];
            String[] padValues = new String[rows];

            for (int i=0 ; i<rows ; i++)
            {
                idValues[i] = i;
                padValues[i] = "******************************************************************************************";
            }

            id = new OracleParameter();
            id.OracleDbType = OracleDbType.Decimal;
            id.Value = idValues;

            pad = new OracleParameter();
            pad.OracleDbType = OracleDbType.Varchar2;
            pad.Value = padValues;

            sql = "INSERT INTO t VALUES (:id, :pad)";
            command = new OracleCommand(sql, connection);
            command.ArrayBindCount = idValues.Length;
            command.Parameters.Add(id);
            command.Parameters.Add(pad);
            command.ExecuteNonQuery();
        }
    }
}
