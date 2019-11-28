﻿using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using System;
using System.Linq;
using System.Web.Mvc;
using Marfil.App.WebMain.Misc;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model.Interfaces;
using System.Net;
using Marfil.Dom.ControlsUI.Toolbar;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Resources;
using Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos;
using Marfil.Dom.Persistencia.Model;

namespace Marfil.App.WebMain.Controllers
{
    [Authorize]
    public class VencimientosCompraController : GenericController<VencimientosModel>
    {
        //private const string session = "_formaspagolin_";

        public override string MenuName { get; set; }
        public override bool IsActivado { get; set; }
        public override bool CanCrear { get; set; }
        public override bool CanModificar { get; set; }
        public override bool CanEliminar { get; set; }

        protected override void CargarParametros()
        {
            MenuName = "vencimientoscompra";
            var permisos = appService.GetPermisosMenu("vencimientoscompra");
            IsActivado = permisos.IsActivado;
            CanCrear = permisos.CanCrear;
            CanModificar = permisos.CanModificar;
            CanEliminar = permisos.CanEliminar;
            CanBloquear = permisos.CanBloquear;
        }

        #region CTR

        public VencimientosCompraController(IContextService context) : base(context)
        {

        }

        #endregion

        private void ClearSessionColumns(ListIndexModel Model)
        {
            var vector =
                Model.Properties.Where(
                    f =>
                        f.property.PropertyType == typeof(string));

            foreach (var item in vector)
            {
                Session[item.property.Name + "Filter"] = null;
            }
        }

        public override ActionResult Index()
        {
            var modelview = Helper.fModel.GetModel<VencimientosModel>(ContextService);
            modelview.CambiarNombre = "Previsión de pagos";
            using (var gestionService = createService(modelview as VencimientosModel) as VencimientosService)
            {
                var model = gestionService.GetListIndexModelPagos(typeof(VencimientosModel), CanEliminar, CanModificar, ControllerContext.RouteData.Values["controller"].ToString());
                model.Toolbar = GenerateToolbar(gestionService, TipoOperacion.Index, model);
                Session[model.VarSessionName] = model;
                ClearSessionColumns(model);
                return View(model);
            }
        }

        public override ActionResult Create()
        {
            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());
            var model = TempData["model"] == null ?Helper.fModel.GetModel<VencimientosModel>(ContextService) : TempData["model"] as VencimientosModel;
            using (var service = new VencimientosService(ContextService))
            {
                ((IToolbar)model).Toolbar = GenerateToolbar(service, TipoOperacion.Alta, model);
            }

            model.Tipo = TipoVencimiento.Pagos;
            model.Situacion = "Y";
            model.Origen = TipoOrigen.EntradaManual;
            model.Importeasignado = 0;
            model.Importepagado = 0;
            model.Estado = TipoEstado.Inicial;

            return View(model);

        }

        // POST: Paises/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public override ActionResult CreateOperacion(VencimientosModel model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    using (var gestionService = createService(model))
                    {
                        gestionService.create(model);
                        TempData[Constantes.VariableMensajeExito] = General.MensajeExitoOperacion;
                        return RedirectToAction("Index");
                    }
                }
                TempData["errors"] = string.Join("; ", ViewData.ModelState.Values
                   .SelectMany(x => x.Errors)
                   .Select(x => x.ErrorMessage));
                TempData["model"] = model;
                return RedirectToAction("Create");
            }
            catch (Exception ex)
            {
                //model.Context = ContextService;
                TempData["errors"] = ex.Message;
                TempData["model"] = model;
                return RedirectToAction("Create");
            }
        }

        public override ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());
            var newModel = Helper.fModel.GetModel<VencimientosModel>(ContextService);
            using (var gestionService = createService(newModel))
            {

                if (TempData["model"] != null)
                    return View(TempData["model"]);

                var model = gestionService.get(id);
                if (model == null)
                {
                    return HttpNotFound();
                }
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Editar, model);
                return View(urlDocumento(model));
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public override ActionResult EditOperacion(VencimientosModel model)
        {
            var obj = model as IModelView;
            var objExt = model as IModelViewExtension;
            try
            {
                if (ModelState.IsValid)
                {
                    using (var gestionService = createService(model))
                    {
                        gestionService.edit(model);
                        TempData[Constantes.VariableMensajeExito] = General.MensajeExitoOperacion;
                        return RedirectToAction("Index");
                    }
                }
                TempData["errors"] = string.Join("; ", ViewData.ModelState.Values
                    .SelectMany(x => x.Errors)
                    .Select(x => x.ErrorMessage));
                TempData["model"] = model;
                return RedirectToAction("Edit", new { id = obj.get(objExt.primaryKey.First().Name) });
            }
            catch (Exception ex)
            {
                model.Context = ContextService;
                TempData["errors"] = ex.Message;
                TempData["model"] = model;
                return RedirectToAction("Edit", new { id = obj.get(objExt.primaryKey.First().Name) });
            }
        }

        // GET: Paises/Details/5
        public override ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var newModel = Helper.fModel.GetModel<VencimientosModel>(ContextService);
            using (var gestionService = createService(newModel))
            {

                var model = gestionService.get(id);
                if (model == null)
                {
                    return HttpNotFound();
                }
                ViewBag.ReadOnly = true;
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Ver, model);
                return View(urlDocumento(model));
            }
        }

        public IModelView urlDocumento(IModelView obj)
        {
            var model = obj as VencimientosModel;
            var service = new VencimientosService(ContextService);
            var idFactura = service.getFacturaByTraza(model.Traza); //string
            var intFactura = Int32.Parse(idFactura); //entero

            if (model.Origen == TipoOrigen.FacturaCompra)
            {                
                model.urlDocumento = Url.Action("Details", "FacturasCompras", new { id = intFactura });
            }
            if (model.Origen == TipoOrigen.FacturaVenta)
            {
                model.urlDocumento = Url.Action("Details", "Facturas", new { id = intFactura });
            }
            return (model);
        }
    }
}