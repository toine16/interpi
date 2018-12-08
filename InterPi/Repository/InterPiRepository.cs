using InterPi.Models.Back;
using InterPi.Models.Front;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Reflection;
using System.Text;
using System.Web;

namespace InterPi.Repository
{
    public class InterPiRepository
    {
        public MySqlConnection db;
        private string _strco;
        public string Strco
        {
            get
            {
                return _strco;
            }

            set
            {
                _strco = value;
            }
        }

        public SqlConnection Con
        {
            get
            {
                return _con;
            }

            set
            {
               _con = value;
            }
        }
        private SqlConnection _con;

        public InterPiRepository()
        {
          //  Strco = @"Data Source=ANTOINE-PC\SQLEXPRESS;Initial Catalog=InterPiHO;Persist Security Info=True;User ID=sa;Password=Test1234@";
            Strco = @"Data Source=localhost:3306;Initial Catalog=interpiho_be_InterPiho;Persist Security Info=True;User ID=staff;Password=Staff1234@";
           // Con = new SqlConnection(Strco);

            string server = "localhost";
            string database = "interpiho_be_InterPiho";
            //string uid = "root";
           // string password = "";
            string uid = "Admin";
            string password = "Test1234@";
            string port = "3306";
            string connectionString;
            connectionString = "SERVER=" + server + ";" + "PORT=" + port + ";" + "DATABASE=" +
            database + ";" + "UID=" + uid + ";" + "PASSWORD=" + password + ";";

            db = new MySqlConnection(connectionString);
            
        }

        public Dictionary<string,string> mapModeltoDico(InscriptionModel model)
        {
            Dictionary<string, string> dico = new Dictionary<string, string>();
            /* Type type = model.GetType();
             foreach(PropertyInfo prop in type.GetProperties())
             {
                 dico.Add(prop.Name,prop.GetValue(prop).ToString());
             }*/
            dico.Add("Edition", model.Edition.ToString());
            dico.Add("Lieu", model.Lieu);
            dico.Add("NomSection", model.NomSection);
            dico.Add("NbrAnimateurs", model.NbrAnimateurs.ToString());
            dico.Add("NbrAnimes", model.NbrAnimes.ToString());
            dico.Add("Mail", model.Mail);
            dico.Add("Telephone", model.Telephone);

            if(model.FilePath == null)
            {
                dico.Add("ListingParticipants", "Null");
            }
            else
            {
                dico.Add("ListingParticipants", model.FilePath);
            }
            

            return dico;
        }

        public void addTroupe(Dictionary<string,string> parametres)
        {
            db.Open();

            MySqlCommand command = new MySqlCommand("Insert into troupes(NomSection,Lieu,Mail,Telephone,NbrAnimateurs,NbrAnimes,ListingParticipants) values(@NomSection,@Lieu,@Mail,@Telephone,@NbrAnimateurs,@NbrAnimes,@ListingParticipants)", db);
            foreach(KeyValuePair<string,string> pair in parametres)
            {
                command.Parameters.AddWithValue(pair.Key, pair.Value);
            }
            
            command.ExecuteScalar();

            command = new MySqlCommand("Select MAX(Id) from troupes",db);
            int IdTroupe =(int)command.ExecuteScalar();

            command = new MySqlCommand("Insert into editiontroupes(IdTroupe,IdEdition) values(@IdTroupe,@IdEdition)", db);
            command.Parameters.AddWithValue("IdTroupe", IdTroupe);
            command.Parameters.AddWithValue("IdEdition", parametres["Edition"]);

            command.ExecuteScalar();
             
        }
        public EditTroupe GetEditTroupe(string id)
        {
            db.Open();

            SqlCommand command = new SqlCommand("Select * from Troupes", Con);
            SqlDataReader reader = command.ExecuteReader();
            EditTroupe o = new EditTroupe();
                while (reader.Read())
                {
                    

                    o.Lieu = reader["Lieu"].ToString();
                    o.Mail = reader["Mail"].ToString();
                    o.NbrAnimateurs = (int)reader["NbrAnimateurs"];
                    o.NbrAnimes = (int)reader["NbrAnimes"];
                    o.NomSection = reader["NomSection"].ToString();
                    o.Telephone = reader["Telephone"].ToString();
                    o.Id = (int)reader["Id"];

                    
                }
            
            return o;
        }

        public List<Troupe> GetTroupes()
        {
            List<Troupe> result = new List<Troupe>();
            db.Open();

            MySqlCommand command = new MySqlCommand("Select * from troupes", db);
            MySqlDataReader reader = command.ExecuteReader();
            {
                while (reader.Read())
                {
                    Troupe o = new Troupe();
                    
                    o.Lieu = reader["Lieu"].ToString();
                    o.Mail = reader["Mail"].ToString();
                    o.NbrAnimateurs = (int)reader["NbrAnimateurs"];
                    o.NbrAnimes = (int)reader["NbrAnimes"];
                    o.NomSection = reader["NomSection"].ToString();
                    o.Telephone = reader["Telephone"].ToString();
                    o.Id = (int)reader["Id"];

                    result.Add(o);
                }
            }
            return result;
        }
        public string buildEmail(InscriptionModel model)
        {
            StringBuilder str = new StringBuilder();
            str.Append("Nous vous confirmons que vous êtes bien inscrit pour l'édition 2019 de l'InterPiHo.");
            str.AppendLine();
            str.Append("Toutefois, votre inscription ne sera définitive que lorsque vous aurez effectué le payement(les informations relatives à celui-ci vous seront envoyées par mail plus tard) , ainsi que fourni un listing de vos participants.Pour toutes modifications de votre inscription et pour nous envoyer le listing de vos animés, merci d\'utiliser cette adresse.");
            str.AppendLine();
            str.Append(" Résumé de votre inscription :");
            str.AppendLine();
            str.Append("Nom du poste : ");
            str.Append(model.NomSection);
            str.AppendLine();
            str.Append("Ville : ");
            str.Append(model.Lieu);
            str.AppendLine();
            str.Append("Numéro de téléphone : ");
            str.Append(model.Telephone);
            str.AppendLine();
            str.Append("Animateurs : ");
            str.Append(model.NbrAnimateurs);
            str.AppendLine();
            str.Append("Animés : ");
            str.Append(model.NbrAnimes);

            str.AppendLine();
            str.AppendLine();
            str.Append("Bien à vous, le staff InterPiHo");

            return (str.ToString());
        }


        public void sendEmail(InscriptionModel model)
        {
            var fromAddress = new MailAddress("staffinterpiho@gmail.com", "From Staff InterPiHo");
            var toAddress = new MailAddress(model.Mail, model.NomSection);
            const string fromPassword = "InterPiHo1234";
            const string subject = "Confirmation de votre inscription";

            string body = buildEmail(model);

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }
        public void sendEmail(string body)
        {
            var fromAddress = new MailAddress("staffinterpiho@gmail.com", "From Staff InterPiHo");
            var toAddress = new MailAddress("antoine.brousmiche@gmail.com");
            const string fromPassword = "InterPiHo1234";
            const string subject = "Confirmation de votre inscription";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };
            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }
    }
}