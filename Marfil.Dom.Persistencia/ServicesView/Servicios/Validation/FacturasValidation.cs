﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model.Configuracion;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.Model.Documentos.Facturas;
using Marfil.Dom.Persistencia.Model.Iva;
using Marfil.Inf.Genericos.Helper;
using Resources;
using RFacturas = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.Facturas;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Validation
{

    internal class FacturasValidation : BaseValidation<Facturas>
    {
        public string EjercicioId { get; set; }
        public bool CambiarEstado { get; set; }
        public bool FlagActualizarCantidadesServidas { get; set; }


        public FacturasValidation(IContextService context, MarfilEntities db) : base(context, db)
        {

        }

        #region Validar grabar

        public override bool ValidarGrabar(Facturas model)
        {
            if (!CambiarEstado)
            {
                ValidarEstado(model);
                ValidarCabecera(model);
                ValidarLineas(model);
                CalcularTotales(model);
                CalcularTotalesCabecera(model);
                ValidarVencimientos(model);
            }

            return base.ValidarGrabar(model);
        }

        private void ValidarEstado(Facturas model)
        {
            string message;

            if (!_appService.ValidarEstado(model.fkestados, _db, out message))
                throw new ValidationException(message);

            var estadosService = new EstadosService(Context, _db);
            var configuracionService = new ConfiguracionService(Context, _db);
            var configuracionModel = configuracionService.GetModel();
            var estadoactualObj = estadosService.get(model.fkestados) as EstadosModel;
            if (!string.IsNullOrEmpty(configuracionModel.Estadototal) && estadoactualObj.Tipoestado <= TipoEstado.Curso && 
                _db.Movs.Where(m=> m.traza == model.referencia).Count() > 0)
            {
                model.fkestados = configuracionModel.Estadofacturasventastotal;
            }
        }

        private bool ValidaRangoEjercicio(Facturas model)
        {
            var result = true;
            var ejercicio = model.fkejercicio;
            var ejercicioobj = _db.Ejercicios.Single(f => f.empresa == model.empresa && f.id == ejercicio);
            var fechadocumento = model.fechadocumento.Value;
            return fechadocumento >= ejercicioobj.desde.Value && fechadocumento <= ejercicioobj.hasta.Value;
        }

        private void ValidarCabecera(Facturas model)
        {
            if (model.fechadocumento == null)
                throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fechadocumento));
            if (model.fkclientes == null)
                throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fkclientes));
            if (!model.fkmonedas.HasValue)
                throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fkmonedas));
            if (!model.fkformaspago.HasValue)
                throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fkformaspago));

            var clienteObj = _db.Clientes.Single(f => f.empresa == model.empresa && f.fkcuentas == model.fkclientes);
            var serieObj =
                _db.Series.Single(f => f.empresa == model.empresa && f.tipodocumento == "FRA" && f.id == model.fkseries);


            if (serieObj.fkmonedas.HasValue && serieObj.fkmonedas != clienteObj.fkmonedas)
                throw new ValidationException(RFacturas.ErrorMonedaClienteSerie);

            if (!ValidaRangoEjercicio(model))
                throw new ValidationException(RFacturas.ErrorFechaEjercicio);

            var formapagoobj = _db.FormasPago.Single(f => f.id == model.fkformaspago);
            if (formapagoobj.mandato.HasValue && formapagoobj.mandato.Value && string.IsNullOrEmpty(model.fkbancosmandatos))
            {
                var mandato = _db.BancosMandatos.SingleOrDefault(
                    f => f.fkcuentas == model.fkclientes && f.defecto == true && !string.IsNullOrEmpty(f.idmandato));
                var vector = model.fkestados.Split('-');
                var tipoestado = Funciones.Qint(vector[0]);
                var idestado = vector[1];
                var estadoObj = _db.Estados.Single(f =>f.documento == tipoestado &&  f.id == idestado);
                if (mandato == null && estadoObj.tipoestado == (int) TipoEstado.Finalizado)
                {
                    throw new ValidationException(RFacturas.ErrorFormaPagoMandatoRequerido);
                }
                else 
                {
                    WarningList.Add(RFacturas.WarningFormaPagoMandatoRequerido);
                }

                model.fkbancosmandatos = mandato?.id;
            }
            
            CalcularComisiones(model);
        }

        private void CalcularComisiones(Facturas model)
        {
            var comision = Calculobrutocomision(model);
            var cuotaDescuentoComercial = 0.0;
            var cuotaDescuentoProntoPago = 0.0;
            var cuotaDescuentoRecargoFinanciero = 0.0;
            var netocomision = 0.0;
            var brutocomisionoriginal = comision;
            var decimales = _db.Monedas.Single(f => f.id == model.fkmonedas).decimales ?? 2;

            if (model.comisiondescontardescuentocomercial.HasValue && model.comisiondescontardescuentocomercial.Value)
            {
                cuotaDescuentoComercial = comision*(model.porcentajedescuentocomercial ?? 0.0)/100.0;
                comision -= cuotaDescuentoComercial;
            }

            if (model.comsiondescontardescuentoprontopago.HasValue && model.comsiondescontardescuentoprontopago.Value)
            {
                cuotaDescuentoProntoPago = comision * (model.porcentajedescuentoprontopago ?? 0.0) / 100.0;
                comision -= cuotaDescuentoProntoPago;
            }


            if (model.comisiondescontarrecargofinancieroformapago.HasValue && model.comisiondescontarrecargofinancieroformapago.Value && model.fkformaspago.HasValue)
            {
                var formapagoObj = _db.FormasPago.SingleOrDefault(f => f.id == model.fkformaspago.Value);
                if (formapagoObj != null)
                {
                    cuotaDescuentoRecargoFinanciero = comision * (formapagoObj.recargofinanciero ?? 0.0) / 100.0;
                    comision -= cuotaDescuentoRecargoFinanciero;
                }
            }

            netocomision = comision;

            model.brutocomision = Math.Round(brutocomisionoriginal, decimales);
            model.cuotadescuentocomercialcomision = Math.Round(cuotaDescuentoComercial, decimales);
            model.cuotadescuentoprontopagocomision = Math.Round(cuotaDescuentoProntoPago, decimales);
            model.cuotadescuentorecargofinancieroformapagocomision = Math.Round(cuotaDescuentoRecargoFinanciero, decimales);
            model.netobasecomision = Math.Round(netocomision, decimales);

            model.importecomisionagente = Math.Round(netocomision * (model.comisionagente ?? 0.0)/100.0, decimales);
            model.importecomisioncomercial = Math.Round(netocomision * (model.comisioncomercial ?? 0.0) / 100.0, decimales);
        }

        private double Calculobrutocomision(Facturas model)
        {
            var lineas = model.FacturasLin.Join(_db.Articulos, f => f.fkarticulos, j => j.id, (factura, articulo) => new {factura, articulo}).Where(f=>(f.articulo.excluircomisiones??false)==false);

            return lineas.Sum(item => item.factura.importe ?? 0);
        }

        private void ValidarLineas(Facturas model)
        {
            var familiasProductosService = FService.Instance.GetService(typeof(FamiliasproductosModel), Context, _db) as FamiliasproductosService;
            foreach (var item in model.FacturasLin)
            {
                if (string.IsNullOrEmpty(item.fkarticulos))
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fkarticulos));

                if (!item.cantidad.HasValue)
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Cantidad));

                if (!item.metros.HasValue)
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Metros));

                if (!item.precio.HasValue)
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Precio));

                if (string.IsNullOrEmpty(item.fktiposiva))
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Fktiposiva));
                
                if (item.porcentajedescuento.HasValue)
                    item.importedescuento = Math.Round((double)(item.precio * item.metros * item.porcentajedescuento) / 100.0, 2);
                
                var art = _db.Articulos.Single(f => f.empresa == model.empresa && f.id == item.fkarticulos);
                var codGrupo = art.fkgruposiva;
                if (!art.tipoivavariable)
                {
                    var tiposivaService = FService.Instance.GetService(typeof(TiposIvaModel), Context, _db) as TiposivaService;
                    item.fktiposiva = tiposivaService.GetTipoIva(codGrupo, model.fkregimeniva).Id;
                }
                
                double cantidad = item.metros ?? 0;
                double precio = item.precio ?? 0;
                double importedescuento = item.importedescuento ?? 0;

                var baseimponible = cantidad * precio - importedescuento;

                item.importe = baseimponible;

                if (!item.importe.HasValue)
                    throw new ValidationException(string.Format(General.ErrorCampoObligatorio, RFacturas.Importe));

                var familiacodigo = ArticulosService.GetCodigoFamilia(item.fkarticulos);
                //familiasProductosService.ValidarDimensiones(familiacodigo, item.largo, item.ancho, item.grueso);

                //ang calcular importe neto
                item.importenetolinea = Math.Round((baseimponible * (1 - ((model.porcentajedescuentocomercial??0)/100)) * (1-((model.porcentajedescuentoprontopago ?? 0)/100))), (item.decimalesmonedas ?? 2));
            }

            var vector = model.FacturasLin.OrderBy(f => f.orden).ToList();
            for (var i = 0; i < vector.Count(); i++)
                vector[i].orden = (i + 1) * ApplicationHelper.EspacioOrdenLineas;
        }

        private void CalcularTotales(Facturas model)
        {
            model.FacturasTotales.Clear();
            var vector = model.FacturasLin.GroupBy(f => f.fktiposiva);
            var decimales = _db.Monedas.Single(f => f.id == model.fkmonedas).decimales;
            foreach (var item in vector)
            {
                var newItem = _db.FacturasTotales.Create();
                var objIva = _db.TiposIva.Single(f => f.empresa == model.empresa && f.id == item.Key);
                newItem.empresa = model.empresa;
                newItem.fkfacturas = model.id;
                newItem.fktiposiva = item.Key;
                newItem.porcentajeiva = objIva.porcentajeiva;

                newItem.brutototal = Math.Round((double)(item.Sum(f => (f.metros) * (f.precio)) - item.Sum(f => f.importedescuento)), decimales.Value);
                newItem.porcentajerecargoequivalencia = objIva.porcentajerecargoequivalente;
                newItem.porcentajedescuentoprontopago = model.porcentajedescuentoprontopago ?? 0;
                newItem.porcentajedescuentocomercial = model.porcentajedescuentocomercial ?? 0;
                newItem.importedescuentocomercial = Math.Round((double)(newItem.brutototal * (model.porcentajedescuentocomercial ?? 0) / 100.0), decimales.Value);
                var basepp = newItem.brutototal - newItem.importedescuentocomercial;
                newItem.importedescuentoprontopago = Math.Round((double)((double)(basepp) * ((model.porcentajedescuentoprontopago ?? 0) / 100.0)), decimales.Value);
                newItem.basetotal = newItem.brutototal - (newItem.importedescuentoprontopago + newItem.importedescuentocomercial);
                newItem.cuotaiva = Math.Round((double)((newItem.basetotal) * (objIva.porcentajeiva / 100.0)), decimales.Value);
                newItem.importerecargoequivalencia = Math.Round((double)((newItem.basetotal) * (objIva.porcentajerecargoequivalente / 100.0)), decimales.Value);
                newItem.baseretencion = newItem.basetotal;
                newItem.porcentajeretencion = model.porcentajeretencion ?? 0;                
                newItem.importeretencion = Math.Round((double)((newItem.basetotal) * (newItem.porcentajeretencion / 100.0)), decimales.Value);

                newItem.subtotal = newItem.basetotal + newItem.cuotaiva + newItem.importerecargoequivalencia - newItem.importeretencion;
                
                model.FacturasTotales.Add(newItem);
            }
        }

        private void CalcularTotalesCabecera(Facturas model)
        {
            var decimales = _db.Monedas.Single(f => f.id == model.fkmonedas).decimales ?? 0;

            model.importebruto = Math.Round((double)model.FacturasTotales.Sum(f => f.brutototal), decimales);
            model.importedescuentoprontopago = Math.Round((double)model.FacturasTotales.Sum(f => f.importedescuentoprontopago), decimales);
            model.importedescuentocomercial = Math.Round((double)model.FacturasTotales.Sum(f => f.importedescuentocomercial), decimales);
            model.importebaseimponible = Math.Round((double)model.FacturasTotales.Sum(f => f.basetotal), decimales);
            model.importetotaldoc = Math.Round((double)model.FacturasTotales.Sum(f => f.subtotal), decimales);

            //todo revisar esto y recalcular el importe total
            model.importetotalmonedabase = model.FacturasTotales.Sum(f => f.subtotal * (model.cambioadicional ?? 1.0));

            //ang - comprobar total neto lineas
            if (model.importebaseimponible != model.FacturasLin.Sum(l=>l.importenetolinea))
            {
                model.FacturasLin.Last().importenetolinea += model.importebaseimponible - model.FacturasLin.Sum(l => l.importenetolinea);
            }
        }

        private void ValidarVencimientos(Facturas model)
        {
            var decimales = _db.Monedas.Single(f => f.id == model.fkmonedas).decimales ?? 0;
            if (model.FacturasVencimientos.Any())
            {
                var total = Math.Round(model.FacturasVencimientos.Sum(f => f.importevencimiento) ??0.0, decimales);
                if(total!=model.importetotaldoc)
                    throw new ValidationException(RFacturas.ErrorImporteVencimientosTotal);
            }
        }

        #endregion

        #region Eliminar

        public override bool ValidarBorrar(Facturas model)
        {
            if (_db.Movs.Any(f => f.traza == model.referencia && f.empresa == model.empresa))
                throw new ValidationException("No se puede borrar una factura contabilizada");

            return base.ValidarBorrar(model);
        }

        #endregion


    }
}
