using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Models.Back
{
    public class Participant
    {
        public int Id { get; set; }
        public string Nom { get; set; }
        public string Prenom { get; set; }
        public string Totem { get; set; }
        public string Role { get; set; }
    }
}