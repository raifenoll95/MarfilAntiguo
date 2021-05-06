using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using Marfil.App.WebMain.Misc;
using Marfil.Dom.ControlsUI.Busquedas;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.ServicesView;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Newtonsoft.Json;

namespace Marfil.App.WebMain.Controllers
{
    public class MunicipiosProvinciasApiController : ApiBaseController
    {
        public MunicipiosProvinciasApiController(IContextService context) : base(context)
        {
        }

        public HttpResponseMessage Get()
        {

            var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
            var codigoprovincia = nvc["codigoprovincia"];


            using (var service = FService.Instance.GetService(typeof(MunicipiosModel), ContextService) as MunicipiosService)
            {
                var result = new ResultBusquedas<MunicipiosModel>()
                {
                    values = service.GetMunicipiosProvincia(codigoprovincia),
                    columns = new[]
                   {
                        new ColumnDefinition() { field = "Cod", displayName = "Id", visible = true },
                        new ColumnDefinition() { field = "Nombre", displayName = "Nombre", visible = true }
                    }
                };

                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(result), Encoding.UTF8, "application/json");
                return response;
            }
        }


        // GET: api/MunicipiosProvinciasApi/codigoProvincia
        [System.Web.Mvc.Authorize]
        public HttpResponseMessage Get(string id)
        {
            using (var service = FService.Instance.GetService(typeof(MunicipiosModel), ContextService) as MunicipiosService)
            {
                var result = service.GetMunicipiosProvincia(id);

                if (result == null)
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound);
                }

                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(result), Encoding.UTF8, "application/json");
                return response;
            }
        }

    }
}