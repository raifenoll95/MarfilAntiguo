﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model.Iva;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.App.WebMain.Controllers
{
    public class RegimenIvaController : GenericController<RegimenIvaModel>
    {
        public override string MenuName { get; set; }
        public override bool IsActivado { get; set; }
        public override bool CanCrear { get; set; }
        public override bool CanModificar { get; set; }
        public override bool CanEliminar { get; set; }
        protected override void CargarParametros()
        {
            MenuName = "regimeniva";
            var permisos = appService.GetPermisosMenu("regimeniva");
            IsActivado = permisos.IsActivado;
            CanCrear = permisos.CanCrear;
            CanModificar = permisos.CanModificar;
            CanEliminar = permisos.CanEliminar;
        }

        #region CTR

        public RegimenIvaController(IContextService context) : base(context)
        {

        }

        #endregion
    }
}