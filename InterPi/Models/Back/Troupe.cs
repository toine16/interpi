using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Models.Back
{
    public class Troupe
    {
        public int Id { get; set; }
        public string NomSection { get; set; }
        public string Lieu { get; set; }
        public int NbrAnimes { get; set; }
        public int NbrAnimateurs { get; set; }
        public string Mail { get; set; }
        public string Telephone { get; set; }


    }
}