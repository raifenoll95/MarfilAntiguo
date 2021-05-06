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
    public class MunicipiosApiController : ApiBaseController
    {
        public MunicipiosApiController(IContextService context) : base(context)
        {
        }

        public HttpResponseMessage Get()
        {

            var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
            var nombremunicipio = nvc["nombremunicipio"];


            using (var service = FService.Instance.GetService(typeof(MunicipiosModel), ContextService) as MunicipiosService)
            {
                var result = new ResultBusquedas<MunicipiosModel>()
                {
                    values = service.GetMunicipioNombre(nombremunicipio),
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

        // GET: api/MunicipiosApi/nombreMunicipio

        public HttpResponseMessage Get(string nombre)
        {
            using (var service = FService.Instance.GetService(typeof(MunicipiosModel), ContextService) as MunicipiosService)
            {
                var result = service.GetMunicipioNombre(nombre);

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