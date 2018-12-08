using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace InterPi.Models.Front
{
    public class AdminModel
    {
        [Required]
        public string Login { get; set; }
        [Required]
        [DataType(DataType.Password)]
        [DisplayName("Mot de passe")]
        public string MotDePasse { get; set; }
    }
}