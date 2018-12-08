using InterPi.Models.Front;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace InterPi.Controllers
{
    public class APIController : ApiController
    {
        // GET: api/API
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/API/2017
        public IEnumerable<string> Get(int id)
        {
            EditionModel model = new EditionModel();
            
            string mappedPath = System.Web.Hosting.HostingEnvironment.MapPath("~/Content/InterPi" + id);
            model.getAllImages(mappedPath, id);
            return model.listImage;
        }

        // POST: api/API
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/API/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/API/5
        public void Delete(int id)
        {
        }
    }
}
