using InterPi.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            DBConnect db = new DBConnect(@"Data Source=91.216.107.196:3306;Initial Catalog=interpiho_be_InterPiho;Persist Security Info=True;User ID=staff;Password=Staff1234@");
            

            Console.WriteLine(db.OpenConnection());
            Console.ReadLine();

            db = new DBConnect(@"Data Source=interpiho.be:3306;Initial Catalog=interpiho_be_InterPiho;Persist Security Info=True;User ID=staff;Password=Staff1234@");


            Console.WriteLine(db.OpenConnection());
            Console.ReadLine();

        }
    }
}
