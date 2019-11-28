using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Marfil.App.WebMain.Misc;
using Marfil.Dom.ControlsUI.Toolbar;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.ServicesView;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Marfil.Inf.ResourcesGlobalization.Textos.Entidades;
using Resources;
using DevExpress.Web.Mvc;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;

namespace Marfil.App.WebMain.Controllers
{
    public class ArticulosController : GenericController<ArticulosModel>
    {
        private const string Sessionventas = "_tarifasespecificasventas_";
        private const string Sessioncompras = "_tarifasespecificascompras_";
        private const string SessionArticulosTercero = "_articulostercero";
        private const string SessionArticulosComponentes = "_articuloscomponentes";

        private const string Partialviewventas = "_tarifasEspecificasVentas";
        private const string Partialviewcompras = "_tarifasEspecificasCompras";

        private float largoTotalTemp;
        private float anchoTotalTemp;
        private float gruesoTotalTemp;

        public override string MenuName { get; set; }
        public override bool IsActivado { get; set; }
        public override bool CanCrear { get; set; }
        public override bool CanModificar { get; set; }
        public override bool CanEliminar { get; set; }
        protected override void CargarParametros()
        {
            MenuName = "articulos";
            var permisos = appService.GetPermisosMenu("articulos");
            IsActivado = permisos.IsActivado;
            CanCrear = permisos.CanCrear;
            CanModificar = permisos.CanModificar;
            CanEliminar = permisos.CanEliminar;
        }

        #region CTR

        public ArticulosController(IContextService context) : base(context)
        {

        }

        #endregion

        #region Create

        public override ActionResult Create()
        {
            if (TempData["errors"] != null)
                ModelState.AddModelError("", TempData["errors"].ToString());

            using (var gestionService = FService.Instance.GetService(typeof(ArticulosModel), ContextService))
            {
                var modelview = Helper.fModel.GetModel<ArticulosModel>(ContextService) as IModelView;

               
                if (TempData["model"] != null)
                    modelview = TempData["model"] as IModelView;

                Session[Sessionventas] = ((ArticulosModel)modelview).TarifasEspecificasVentas;
                Session[Sessioncompras] = ((ArticulosModel)modelview).TarifasEspecificasCompras;
                Session[SessionArticulosTercero] = ((ArticulosModel)modelview).ArticulosTercero;
                Session[SessionArticulosComponentes] = ((ArticulosModel)modelview).ArticulosComponentes;

                ((IToolbar)modelview).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Alta, modelview);
                return View(modelview);
            }
        }

        //create operacion
        public override ActionResult CreateOperacion(ArticulosModel model)
        {
            try
            {

                var a = 3;

                var modelview = Helper.fModel.GetModel<ArticulosModel>(ContextService);
                model.TarifasEspecificasVentas = Session[Sessionventas] as TarifaEspecificaArticulo;
                model.TarifasEspecificasCompras = Session[Sessioncompras] as TarifaEspecificaArticulo;
                model.ArticulosTercero = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;
                model.ArticulosComponentes = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;

                using (var gestionService = createService(modelview))
                {
                    ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Alta, model);
                    if (ModelState.IsValid)
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
                model.Context = ContextService;
                TempData["errors"] = ex.Message;
                TempData["model"] = model;
                return RedirectToAction("Create");
            }
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
            var newModel = Helper.fModel.GetModel<ArticulosModel>(ContextService);
            using (var gestionService = createService(newModel))
            {
                var model = TempData["model"] != null ? TempData["model"] as ArticulosModel: gestionService.get(id);
               
                if (model == null)
                {
                    return HttpNotFound();
                }
                Session[Sessionventas] = ((ArticulosModel)model).TarifasEspecificasVentas;
                Session[Sessioncompras] = ((ArticulosModel)model).TarifasEspecificasCompras;
                Session[SessionArticulosTercero] = ((ArticulosModel)model).ArticulosTercero;
                Session[SessionArticulosComponentes] = ((ArticulosModel)model).ArticulosComponentes;

                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Editar, model);

                model = UrlAlbaran(model);

                return View(model);
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public override ActionResult EditOperacion(ArticulosModel model)
        {
            var obj = model as IModelView;
            var objExt = model as IModelViewExtension;
            try
            {
                if (ModelState.IsValid)
                {
                    using (var gestionService = createService(model))
                    {
                        
                        model.TarifasEspecificasVentas = Session[Sessionventas] as TarifaEspecificaArticulo;
                        model.TarifasEspecificasCompras = Session[Sessioncompras] as TarifaEspecificaArticulo;
                        model.ArticulosTercero = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;
                        model.ArticulosComponentes = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;

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

        #endregion

        #region Details

        // GET: Paises/Details/5
        public override ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            var newModel = Helper.fModel.GetModel<ArticulosModel>(ContextService);
            using (var gestionService = createService(newModel))
            {
                
                var model = gestionService.get(id);
                if (model == null)
                {
                    return HttpNotFound();
                }
                Session[Sessionventas] = ((ArticulosModel)model).TarifasEspecificasVentas;
                Session[Sessioncompras] = ((ArticulosModel)model).TarifasEspecificasCompras;
                Session[SessionArticulosTercero] = ((ArticulosModel)model).ArticulosTercero;
                Session[SessionArticulosComponentes] = ((ArticulosModel)model).ArticulosComponentes;

                ViewBag.ReadOnly = true;                
                ((IToolbar)model).Toolbar = GenerateToolbar(gestionService, TipoOperacion.Ver, model);

                model = UrlAlbaran(model);

                return View(model);
            }
        }


        #endregion

        #region Url Albaranes

        private IModelView UrlAlbaran(IModelView model)
        {
            var url = "";
            
            if (((ArticulosModel)model).modoAlbaranEntrada == 0)
            {
                url = Url.Action("Details", "AlbaranesCompras");
                url += "/" + ((ArticulosModel)model).idAlbaranEntrada.ToString();                
            }
            else
            {
                url = Url.Action("Details", "RecepcionesStock");
                url += "/" + ((ArticulosModel)model).idAlbaranEntrada.ToString();                
            }
            ((ArticulosModel)model).urlAlbaranEntrada = url;

            url = "";
            if (((ArticulosModel)model).modoAlbaranSalida == 0)
            {
                url = Url.Action("Details", "Albaranes");
                url += "/" + ((ArticulosModel)model).idAlbaranSalida.ToString();                
            }
            else
            {
                url = Url.Action("Details", "EntregasStock");
                url += "/" + ((ArticulosModel)model).idAlbaranSalida.ToString();                
            }
            ((ArticulosModel)model).urlAlbaranSalida = url;

            return model;
        }

        #endregion

        #region Grid Devexpress


        [ValidateInput(false)]
        public ActionResult ArticulosLin(string id)
        {
            var session = id == "Compras" ? Sessioncompras : Sessionventas;
            var partialView = id == "Compras" ? Partialviewcompras : Partialviewventas;
            var model = Session[session] as TarifaEspecificaArticulo;
            return PartialView(partialView, model);
        }
     
        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosLinUpdate(string id,[ModelBinder(typeof(DevExpress.Web.Mvc.DevExpressEditorsBinder))] TarifasEspecificasArticulosViewModel item)
        {
            var session = id == "Compras" ? Sessioncompras : Sessionventas;
            var partialView = id == "Compras" ? Partialviewcompras : Partialviewventas;
            var model = Session[session] as TarifaEspecificaArticulo;

            try
            {
                if (ModelState.IsValid)
                {
                    if (item.Obligatorio && !item.Precio.HasValue)
                    {
                        ModelState.AddModelError("Precio", string.Format(General.ErrorCampoObligatorio, Tarifas.Precio));
                       
                    }
                    else
                    {
                        var editItem = model.Lineas.Single(f => f.Id == item.Id);

                        editItem.Precio = item.Precio;
                        editItem.Descuento = item.Descuento;
                        Session[session] = model;
                    }
                    
                }
            }
            catch (ValidationException)
            {
                throw;
            }

            return PartialView(partialView, model);
        }


        [ValidateInput(false)]
        public ActionResult ArticulosTercero()
        {
            var model = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;
            return PartialView("_Movsarticulostercero", model);
        }

        [ValidateInput(false)]
        public ActionResult ArticulosComponentes()
        {
            var model = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;
            return PartialView("_Movsarticuloscomponentes", model);
        }



        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosTerceroAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ArticulosTerceroModel item)
        {
            
            var model = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;

            var servicioCuentas = FService.Instance.GetService(typeof(CuentasModel), ContextService) as CuentasService;
            var descripcion = servicioCuentas.GetDescripcionCuenta(item.CodTercero) ?? "";

            if(descripcion=="")
            {
                throw new ValidationException("No existe ninguna cuenta asociada al número de cuenta: " + item.CodTercero);
            }

            //No se pueden repetir codigos de terceros
            if (model.Count>=1)
            {
                foreach(var tercero in model)
                {
                    if(tercero.CodTercero==item.CodTercero)
                    {
                        throw new ValidationException("Ya existe un registro con el código de tercero: " + tercero.CodTercero);
                    }
                }
            }

            item.CodArticulo = "0000";
            item.Id = model.Count() + 1; //0+1=1

            //Añadimos el item al model
            try
            {
                if (ModelState.IsValid)
                {
                    model.Add(item);
                    Session[SessionArticulosTercero] = model;
                }
            }
            catch (ValidationException)
            {
                
                throw;
            }

            return PartialView("_Movsarticulostercero", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosComponentesAddNew([ModelBinder(typeof(DevExpressEditorsBinder))] ArticulosComponentesModel item)
        {

            var model = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;

            if (item.Merma<0 || item.Merma>99)
            {
                throw new ValidationException("El campo merma debe tener valores entre 0 y 99");
            }

            var servicioArticulos = FService.Instance.GetService(typeof(ArticulosModel), ContextService) as ArticulosService;
            var descripcion = servicioArticulos.descripcionArticulo(item.IdComponente) ?? "";

            if (descripcion == "")
            {
                throw new ValidationException("No existe ningun artículo con código: " + item.IdComponente);
            }

            item.Id = model.Count() + 1; //0+1=1

            //Añadimos el item al model
            try
            {
                if (ModelState.IsValid)
                {
                    model.Add(item);
                    Session[SessionArticulosComponentes] = model;
                }
            }
            catch (ValidationException)
            {

                throw;
            }

            return PartialView("_Movsarticuloscomponentes", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosTerceroUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ArticulosTerceroModel item)
        {

            var model = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;

            try
            {
                if (ModelState.IsValid)
                {
                    var editItem = model.Single(f => f.Id == item.Id); //Sacamos la cuenta del tercero a editar
                    editItem.CodArticulo = editItem.CodArticulo;
                    editItem.CodTercero = item.CodTercero;
                    editItem.DescripcionTercero = item.DescripcionTercero;
                    editItem.CodArticuloTercero = item.CodArticuloTercero;
                    editItem.Descripcion = item.Descripcion;
                    Session[SessionArticulosTercero] = model;
                }
            }
            catch (ValidationException)
            {
                throw;
            }

            return PartialView("_Movsarticulostercero", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosComponentesUpdate([ModelBinder(typeof(DevExpressEditorsBinder))] ArticulosComponentesModel item)
        {

            var model = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;

            try
            {
                if (ModelState.IsValid)
                {
                    var editItem = model.Single(f => f.Id == item.Id); //Sacamos la cuenta del tercero a editar
                    editItem.IdComponente = editItem.IdComponente;
                    editItem.DescripcionComponente = item.DescripcionComponente;
                    editItem.Piezas = item.Piezas;
                    editItem.Largo = item.Largo;
                    editItem.Ancho = item.Ancho;
                    editItem.Grueso = item.Grueso;
                    Session[SessionArticulosComponentes] = model;
                }
            }
            catch (ValidationException)
            {
                throw;
            }

            return PartialView("_Movsarticuloscomponentes", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosTerceroDelete(string id)
        {
            var model = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;
            model.Remove(model.Single(f => f.Id.ToString() == id));

            //Ir actualizando los ID en caso de que sufran cambios (eliminacion de lineas) EN CASO DE QUE QUEDEN LINEAS
            if (model.Count() >= 1)
            {
                int count = 1;
                foreach (var linea in model)
                {

                    linea.Id = count;
                    count++;
                }
            }

            Session[SessionArticulosTercero] = model;
            return PartialView("_Movsarticulostercero", model);
        }

        [HttpPost, ValidateInput(false)]
        public ActionResult ArticulosComponentesDelete(string id)
        {
            var model = Session[SessionArticulosComponentes] as List<ArticulosComponentesModel>;
            model.Remove(model.Single(f => f.Id.ToString() == id));

            //Ir actualizando los ID en caso de que sufran cambios (eliminacion de lineas) EN CASO DE QUE QUEDEN LINEAS
            if (model.Count() >= 1)
            {
                int count = 1;
                foreach (var linea in model)
                {

                    linea.Id = count;
                    count++;
                }
            }

            Session[SessionArticulosComponentes] = model;
            return PartialView("_Movsarticuloscomponentes", model);
        }

        public ActionResult CustomGridViewEditingPartial(string key)
        {
            ViewData["key"] = key;
            var model = Session[SessionArticulosTercero] as List<ArticulosTerceroModel>;
            return PartialView("_Movsarticulostercero", model);
        }

        #endregion

        public ActionResult comprobarDescripcionCuentaTercero(string numeroCuenta)
        {
            var servicioCuenta = FService.Instance.GetService(typeof(CuentasModel), ContextService) as CuentasService;
            var descripcion = servicioCuenta.GetDescripcionCuenta(numeroCuenta) ?? "";
            var data = new { status = "ok", descripcion = descripcion};
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public ActionResult comprobarDescripcionArticulo(string idArticulo)
        {
            var servicioArticulo = FService.Instance.GetService(typeof(ArticulosModel), ContextService) as ArticulosService;
            var descripcion = servicioArticulo.descripcionArticulo(idArticulo) ?? "";
            var data = new { status = "ok", descripcion = descripcion };
            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}