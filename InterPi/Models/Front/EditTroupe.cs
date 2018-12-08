using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Models.Front
{
    public class EditTroupe
    {
        public int Id { get; set; }
        public string NomSection { get; set; }
        public string Lieu { get; set; }
        public int NbrAnimateurs { get; set; }
        public int NbrAnimes { get; set; }
        public string Mail { get; set; }
        public string Telephone { get; set; }
        public bool Payement { get; set; }
        public double Montant { get; set; }
        public string FilePath { get; set; }
        public HttpPostedFileBase File { get; set; }
    }
}