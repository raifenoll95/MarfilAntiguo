using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using Marfil.App.WebMain.Misc;
using Marfil.Dom.ControlsUI.Toolbar;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Configuracion.Empresa;
using Marfil.Dom.Persistencia.Model.Documentos.Presupuestos;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.ServicesView;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.App.WebMain.Controllers
{
    public class EmpresasController:GenericController<EmpresaModel>
    {
        public override string MenuName { get; set; }
        public override bool IsActivado { get; set; }
        public override bool CanCrear { get; set; }
        public override bool CanModificar { get; set; }
        public override bool CanEliminar { get; set; }

        protected override void CargarParametros()
        {
            
            IsActivado = ContextService.IsSuperAdmin;
            CanModificar = CanCrear =  IsActivado;
            CanEliminar = false;
        }

        #region CTR

        public EmpresasController(IContextService context) : base(context)
        {

        }

        #endregion

        #region Create

        public override ActionResult Create()
        {
            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());

            var modelview = Helper.fModel.GetModel<EmpresaModel>(ContextService);

            var aux = TempData["model"] == null ? modelview : TempData["model"] as EmpresaModel;
            aux.Paises = modelview.Paises;
            aux.PlanesGenerales = modelview.PlanesGenerales;
            aux.LstTarifasVentas = modelview.LstTarifasVentas;
            aux.LstTarifasCompras = modelview.LstTarifasCompras;
            using (var gestionService = FService.Instance.GetService(typeof(EmpresaModel), ContextService))
            {
                ((IToolbar)aux).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Alta, aux);
            }
            return View(aux);
        }

        #endregion

        #region Edit

        public override ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());

            var modelview = Helper.fModel.GetModel<EmpresaModel>(ContextService);
            using (var gestionService = createService(modelview as IModelView))
            {
                EmpresaModel model;
                if (TempData["model"] != null)
                {
                    model = TempData["model"] as EmpresaModel;
                    Session["_empresa_" + id] = null;
                }
                else
                    model = gestionService.get(id) as EmpresaModel;

                if (model == null)
                {
                    return HttpNotFound();
                }

                model.Paises = modelview.Paises;
                model.PlanesGenerales = modelview.PlanesGenerales;
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Editar, model);
                
                
                return View(model);
            }
        }

        #endregion

        #region Details

        public override ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            var modelview = Helper.fModel.GetModel<EmpresaModel>(ContextService);
            using (var gestionService = createService(modelview as IModelView))
            {
                
                var model = gestionService.get(id) as EmpresaModel;
                if (model == null)
                {
                    return HttpNotFound();
                }

                model.Paises = modelview.Paises;
                model.PlanesGenerales = modelview.PlanesGenerales;
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Ver, model);

                return View(model);
            }
        }

        #endregion
       
    }
}