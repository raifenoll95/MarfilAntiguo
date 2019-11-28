﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.Http;
using Marfil.App.WebMain.Misc;
using Marfil.Dom.ControlsUI.Busquedas;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Configuracion;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model.Iva;
using Marfil.Dom.Persistencia.ServicesView;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Newtonsoft.Json;

namespace Marfil.App.WebMain.Controllers
{
    public class SeriesApiController : ApiBaseController
    {
        public SeriesApiController(IContextService context) : base(context)
        {
        }

        public HttpResponseMessage Get()
        {
            
            using (var service = FService.Instance.GetService(typeof(SeriesModel),ContextService) )
            {
                var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
                var tipodocumento = nvc["tipodocumento"];
                var vector = service.getAll().Select(f => (SeriesModel) f).Where(f=>f.Bloqueado==false && (string.IsNullOrEmpty(f.Fkejercicios) || f.Fkejercicios== ContextService.Ejercicio));
                if (!string.IsNullOrEmpty(tipodocumento))
                {
                    vector = vector.Where(f => f.Tipodocumento == tipodocumento);
                }

                var result = new ResultBusquedas<SeriesModel>()
                {
                    values = vector,
                    columns = new[]
                    {
                        new ColumnDefinition() { field = "Id", displayName = "Id", visible = true, filter = new  Filter() { condition = ColumnDefinition.STARTS_WITH }},
                        new ColumnDefinition() { field = "Descripcion", displayName = "Descripción", visible = true },
                        new ColumnDefinition() { field = "Fkejerciciosdescripcion", displayName = "Ejercicio", visible = true },
                    }
                };


                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(result), Encoding.UTF8, "application/json");
                return response;
            }
        }

        // GET: api/Supercuentas/5
        public HttpResponseMessage Get(string id)
        {
            
            using (var service = FService.Instance.GetService(typeof(SeriesModel),ContextService))
            {
                var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
                var tipodocumento = nvc["tipodocumento"];
                var list = service.get(tipodocumento + "-" + id) as SeriesModel;
                

                if (!list.Bloqueado && ( (string.IsNullOrEmpty(list.Fkejercicios) || list.Fkejercicios == ContextService.Ejercicio)))
                {
                    var response = Request.CreateResponse(HttpStatusCode.OK);
                    response.Content = new StringContent(JsonConvert.SerializeObject(list), Encoding.UTF8,
                        "application/json");
                    return response;
                }
                else
                {
                    var response = Request.CreateResponse(HttpStatusCode.Conflict);
                    
                    return response;
                }
                


            }
        }
    }
}
