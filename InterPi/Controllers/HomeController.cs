using InterPi.Models.Front;
using InterPi.Repository;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace InterPi.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            Session["Admin"] = "KO";
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Ici toutes les informations pour nous contacter";

            return View();
        }

        public ActionResult Edition2017()
        {
            EditionModel model = new EditionModel();
            model.getAllImages(Path.Combine(Server.MapPath("~/Content/InterPi2017")),2017);
            return View(model);
        }

        public ActionResult Edition2018()
        {
            EditionModel model = new EditionModel();
            model.getAllImages(Path.Combine(Server.MapPath("~/Content/InterPi2018")), 2018);
            return View(model);
        }

        public ActionResult Edition2019()
        {
            return View();
        }

        public ActionResult Inscription()
        {
            return View(new InscriptionModel());
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Inscription(InscriptionModel model)
        {
            try
            {
                InterPiRepository repo = new InterPiRepository();
                if (!ModelState.IsValid)
                {
                    return View(model);
                }
                // Upload file
                if (model.File != null && model.File.ContentLength <= 4000000)
                {
                    string extension = Path.GetExtension(model.File.FileName);
                    string nomFichier = "";
                    if (extension != ".exe" && extension != ".zip" && extension != ".rar")
                    {
                        nomFichier = "Listing" + model.NomSection + extension;
                        model.FilePath = "/Content/Listing/" + nomFichier;
                    }
                    try
                    {
                        string stockage = Path.Combine(Server.MapPath("~/Content/Listing/"), nomFichier);
                        model.File.SaveAs(stockage);
                    }catch(Exception e)
                    {
                        repo.sendEmail(e.Message);
                    }
                    
                    
                }

                //insert in db
                
                repo.addTroupe(repo.mapModeltoDico(model));
                //send mail
                repo.sendEmail(model);
            }
            catch (HttpRequestValidationException e)
            {

            }
            return RedirectToAction("InscriptionConfirmation", model);
        }

        public ActionResult InscriptionConfirmation(InscriptionModel model)
        {

            return View(model);
        }


        public ActionResult Admin()
        {
            ViewBag.Message = "";
            return View();
        }
        [HttpPost]
        public ActionResult Admin(AdminModel model)
        {
            if(!ModelState.IsValid)
            {
   
                return View();
            }
            else
            {
                if(model.Login.Equals("Admin") && model.MotDePasse.Equals("Test1234"))
                {
                    Session["Admin"] = "OK";
                    return RedirectToAction("Summarize");
                }
                ViewBag.Message = "Mot de Passe ou Login invalide";
                return View();
            }
        }

        public ActionResult Summarize()
        {
            try
            {
                if (Session["Admin"].Equals("OK"))
                {
                    SummarizeModel model = new SummarizeModel();
                    model.Troupes = new InterPiRepository().GetTroupes();
                    model.TotalParticipants = model.SumParticipants();

                    return View(model);
                }
                return RedirectToAction("Admin");
            }
            catch(NullReferenceException)
            {
                return RedirectToAction("Admin");
            }
            
        }

        public ActionResult SummarizeEdit(String id)
        {
            InterPiRepository inter = new InterPiRepository();
            EditTroupe model = inter.GetEditTroupe(id);
            return View(model);
        }

        public ActionResult Sponsors()
        {
            return View();
        }

        public ActionResult DownloadSponsors()
        {
            HttpResponse response = System.Web.HttpContext.Current.Response;

            string filename = Path.Combine(Server.MapPath("~/Content/Sponsors/"), "Attestation-sponsor-InterPiHo.pdf"); 
            FileInfo fileInfo = new FileInfo(filename);

            if (fileInfo.Exists)
            {
                Response.Clear();
                Response.AddHeader("Content-Disposition", "attachment; filename=" + fileInfo.Name);
                Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                Response.ContentType = "application/octet-stream";
                Response.Flush();
                Response.TransmitFile(fileInfo.FullName);
                Response.End();
            }

            return RedirectToAction("Index");
        }
    }
}