﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Marfil.Dom.Persistencia.Listados;
using Marfil.Dom.Persistencia.ServicesView.Servicios;

namespace Marfil.App.WebMain.Controllers
{
    public class ListadoDetalladoPresupuestosComprasController : ListadosController<ListadosDetalladoPresupuestosCompras>
    {
        public ListadoDetalladoPresupuestosComprasController(IContextService context) : base(context)
        {
        }
    }
}