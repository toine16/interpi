using InterPi.Models.Back;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace InterPi.Models.Front
{
    public class InscriptionModel
    {
        public InscriptionModel()
        {
            Edition = 2019;
        }

        [ScaffoldColumn(false)]
        public int Edition { get; set; }

        [Required]
        [DisplayName("Nom du poste/chaîne")]
        public string NomSection { get; set; }
        [Required]
        [DisplayName("D'où venez-vous ? (Ville)")]
        public string Lieu { get; set; }

        [Required]
        [DisplayName("Numéro de téléphone")]
        [DataType(DataType.PhoneNumber)]
        public string Telephone { get; set; }

        [Required]
        [DisplayName("Adresse email")]
        [DataType(DataType.EmailAddress)]
        public string Mail { get; set; }

        [Required]
        [DisplayName("Nombre d'animateurs")]
        [Range(1, 100)]
        public int NbrAnimateurs { get; set; }

        [Required]
        [DisplayName("Nombre d'animés")]
        [Range(1,100)]
        public int NbrAnimes{ get; set; }

        [DisplayName("Listing des participants")]
        [DataType(DataType.Upload)]
        public string FilePath { get; set; }
        public HttpPostedFileBase File { get; set; }


    }
}