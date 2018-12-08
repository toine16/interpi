using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Repository
{
    public class DBConnect
    {
        
            //Strco = @"Data Source=91.216.107.196:3306;Initial Catalog=interpiho_be_InterPiho;Persist Security Info=True;User ID=staff;Password=Staff1234@";
            private MySqlConnection connection;

            //Constructor
            public DBConnect()
            {


                string server = "localhost";
                string database = "interpiho_be_InterPiho";
                string uid = "Admin";
                string password = "Test1234@";
                string port = "3306";
                string connectionString;
                connectionString = "SERVER=" + server + ";" + "PORT=" + port + ";" + "DATABASE=" +
                database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

                connection = new MySqlConnection(connectionString);
            }


            public bool OpenConnection()
            {
                try
                {
                    connection.Open();
                    return true;
                }
                catch (MySqlException ex)
                {
                    //When handling errors, you can your application's response based 
                    //on the error number.
                    //The two most common error numbers when connecting are as follows:
                    //0: Cannot connect to server.
                    //1045: Invalid user name and/or password.
                    switch (ex.Number)
                    {
                        case 0:
                            Console.WriteLine(ex.Message);
                            //MessageBox.Show("Cannot connect to server.  Contact administrator");
                            break;

                        case 1045:
                            Console.WriteLine(ex.Message);
                            // MessageBox.Show("Invalid username/password, please try again");
                            break;
                        default:
                            Console.WriteLine(ex.Message);
                            break;
                    }
                    connection.Close();
                    return false;
                }
            }

            //Close connection
            private bool CloseConnection()
            {
                try
                {
                    connection.Close();
                    return true;
                }
                catch (MySqlException ex)
                {
                    //MessageBox.Show(ex.Message);
                    return false;
                }
            }

            //Insert statement
            public void Insert()
            {
            }

            //Update statement
            public void Update()
            {
            }

            //Delete statement
            public void Delete()
            {
            }

            //Select statement
            public List<string> Select()
            {
                return new List<string>();
            }

            //Count statement
            public int Count()
            {
                return 0;
            }

            //Backup
            public void Backup()
            {
            }

            //Restore
            public void Restore()
            {
            }
        }
    
}
