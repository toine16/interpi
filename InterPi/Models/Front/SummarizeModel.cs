using InterPi.Models.Back;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace InterPi.Models.Front
{
    public class SummarizeModel
    {
        public List<Troupe> Troupes { get; set; }
        public SummarizeModel()
        {
            Troupes = new List<Troupe>();
        }

        public int TotalParticipants { get; set; }

        public int SumParticipants()
        {
            int retour = 0;
            foreach(Troupe tp in Troupes)
            {
                retour += tp.NbrAnimes;
            }
            return retour;
        }

    }
}