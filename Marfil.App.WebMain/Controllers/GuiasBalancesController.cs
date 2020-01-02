using Marfil.Dom.Persistencia.Model.Contabilidad;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Marfil.Dom.Persistencia.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using Marfil.Dom.ControlsUI.Toolbar;
using Marfil.Dom.Persistencia.Model.Interfaces;

namespace Marfil.App.WebMain.Controllers
{
    public class GuiasBalancesController : GenericController<GuiasBalancesModel>
    {
        // GET: GuiasBalances
        public GuiasBalancesController(IContextService context) : base(context)
        {
        }
        
        public override string MenuName { get; set; }
        public override bool IsActivado { get; set; }
        public override bool CanCrear { get; set; }
        public override bool CanModificar { get; set; }
        public override bool CanEliminar { get; set; }

        protected override void CargarParametros()
        {
            MenuName = "GuiasBalances";
            var permisos = appService.GetPermisosMenu(MenuName);
            IsActivado = true;
            CanCrear = true;
            CanModificar = true;
            CanEliminar = true;
        }

        #region Edit
        public override ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());

            var newModel = Helper.fModel.GetModel<GuiasBalancesModel>(ContextService);
            using (var gestionService = createService(newModel))
            {
                var model = TempData["model"] != null ? TempData["model"] as GuiasBalancesModel : gestionService.get(id);
                if (model == null)
                {
                    return HttpNotFound();
                }

                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Editar, model);
                return View(model);
            }
        }
        public override ActionResult EditOperacion(GuiasBalancesModel model)
        {
            return base.EditOperacion(model);
        }
        #endregion
        #region Details
        public override ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var newModel = Helper.fModel.GetModel<GuiasBalancesModel>(ContextService);
            using (var gestionService = createService(newModel))
            {

                var model = gestionService.get(id);
                if (model == null)
                {
                    return HttpNotFound();
                }
                ViewBag.ReadOnly = true;
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Ver, model);
                return View(model);
            }
        }
        #endregion
    }
}