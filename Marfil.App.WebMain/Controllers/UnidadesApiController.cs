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
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Configuracion;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Newtonsoft.Json;
using Marfil.Dom.Persistencia.Model.Iva;
using Marfil.Dom.Persistencia.ServicesView;

namespace Marfil.App.WebMain.Controllers
{
    public class UnidadesApiController : ApiBaseController
    {
        public UnidadesApiController(IContextService context) : base(context)
        {
        }

        public HttpResponseMessage Get()
        {
            
            using (var service =FService.Instance.GetService(typeof(UnidadesModel),ContextService))
            {
                var result = new ResultBusquedas<UnidadesModel>()
                {
                    values = service.getAll().Select(f=>(UnidadesModel)f),
                    columns = new[]
                    {
                        new ColumnDefinition() { field = "Id", displayName = "Id", visible = true, filter = new  Filter() { condition = ColumnDefinition.STARTS_WITH }},
                        new ColumnDefinition() { field = "Codigounidad", displayName = "Código unidad", visible = true, filter = new  Filter() { condition = ColumnDefinition.STARTS_WITH }},
                        new ColumnDefinition() { field = "Descripcion", displayName = "Descripción", visible = true },
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
            
            using (var service = FService.Instance.GetService(typeof(UnidadesModel),ContextService))
            {

                var list = service.get(id) as UnidadesModel;
                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(list), Encoding.UTF8,
                    "application/json");
                return response;
               

            }
        }
    }
}
