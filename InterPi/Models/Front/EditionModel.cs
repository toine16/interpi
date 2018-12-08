using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;


namespace InterPi.Models.Front
{
    public class EditionModel
    {
        public List<string> listImage { get; set; }

        public void getAllImages(string path,int Edition)
        {
           listImage = new List<string>();
            // pour tout les fichiers du dossier, récupérer le nom des fichirs 
            //(Getfiles donne le chemin absolut depuis la racine)
           foreach (string i in Directory.GetFiles(path).ToList())
            {
                listImage.Add("/Content/InterPi"+Edition+"/" + i.Split('\\').Last());
            }
        }
       

    }
}