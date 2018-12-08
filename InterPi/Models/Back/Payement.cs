using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Models.Back
{
    public class Payement
    {
        public int Id { get; set; }
        public double Montant { get; set; }
        public DateTime Date { get; set; }
    }
}