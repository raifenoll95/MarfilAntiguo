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
using Marfil.Dom.Persistencia;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.ServicesView;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Newtonsoft.Json;

namespace Marfil.App.WebMain.Controllers
{
    public class CaracteristicasApiController : ApiBaseController
    {
        public CaracteristicasApiController(IContextService context) : base(context)
        {
        }
        public HttpResponseMessage Get()
        {
           
            using (var service = FService.Instance.GetService(typeof(CaracteristicasModel),ContextService))
            {
                var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
                var familia = nvc["familia"];
                var item = service.get(familia) as CaracteristicasModel;
                var result = new ResultBusquedas<CaracteristicasLinModel>()
                {
                    values = item.Lineas,
                    columns = new[]
                    {
                        new ColumnDefinition() { field = "Id", displayName = "Id", visible = true, filter = new  Filter() { condition = ColumnDefinition.STARTS_WITH }},
                        new ColumnDefinition() { field = "Descripcion", displayName = "Descripcion", visible = true },
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
          
            using (var service = FService.Instance.GetService(typeof(CaracteristicasModel),ContextService))
            {
                var nvc = HttpUtility.ParseQueryString(Request.RequestUri.Query);
                var familia = nvc["familia"];

                var list = service.get(familia) as CaracteristicasModel;
                var result = list.Lineas.Single(f => f.Id == id);
                var response = Request.CreateResponse(HttpStatusCode.OK);
                response.Content = new StringContent(JsonConvert.SerializeObject(result), Encoding.UTF8,
                    "application/json");
                return response;
               

            }
        }

       
    }
}
