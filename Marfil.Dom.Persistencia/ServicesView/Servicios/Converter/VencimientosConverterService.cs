using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using System.Collections.Generic;
using System.Linq;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos;
using System;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    internal class VencimientosConverterService : BaseConverterModel<VencimientosModel, Persistencia.Vencimientos>
    {
        public VencimientosConverterService(IContextService context, MarfilEntities db) : base(context, db)
        {
        }

        public override IEnumerable<IModelView> GetAll()
        {
            return _db.Set<Persistencia.Vencimientos>().Select(GetModelView);
        }

        public override IModelView CreateView(string id)
        {
            var idnum = Int32.Parse(id);
            var obj = _db.Set<Persistencia.Vencimientos>().Single(f => f.empresa == Empresa && f.id == idnum);
            var result = GetModelView(obj) as VencimientosModel;
            return result;
        }

        public override Persistencia.Vencimientos CreatePersitance(IModelView obj)
        {
            var viewmodel = obj as VencimientosModel;
            var result = _db.Set<Persistencia.Vencimientos>().Create();
            result.id = viewmodel.Id.Value;
            result.empresa = viewmodel.Empresa;
            result.traza = viewmodel.Traza;          
            result.tipo = (int)viewmodel.Tipo;
            result.origen = (int)viewmodel.Origen;
            result.usuario = Context.Usuario;
            result.fkcuentas = viewmodel.Fkcuentas;
            result.fechacreacion = DateTime.Now;
            result.fechafactura = viewmodel.Fechafactura;
            result.fecharegistrofactura = viewmodel.Fecharegistrofactura;
            result.fechavencimiento = viewmodel.Fechavencimiento;
            result.fechadescuento = viewmodel.Fechadescuento;
            result.fechapago = viewmodel.Fechapago;
            result.monedabase = viewmodel.Monedabase;
            result.monedagiro = viewmodel.Monedagiro;
            result.importegiro = viewmodel.Importegiro;
            result.importefactura = viewmodel.Importefactura;
            result.cambioaplicado = viewmodel.Cambioaplicado;
            result.monedafactura = viewmodel.Monedafactura;
            result.fkformaspago = viewmodel.Fkformaspago;
            result.fkcuentatesoreria = viewmodel.Fkcuentatesoreria;
            result.mandato = viewmodel.Mandato;
            result.importeasignado = viewmodel.Importeasignado;
            result.importepagado = viewmodel.Importepagado;
            result.estado = (int)viewmodel.Estado;
            result.situacion = viewmodel.Situacion;
            result.comentario = viewmodel.Comentario;
            return result;
        }

        public override Persistencia.Vencimientos EditPersitance(IModelView obj)
        {
            var viewmodel = obj as VencimientosModel;
            var result = _db.Vencimientos.Where(f => f.id == viewmodel.Id && f.empresa == Empresa).Single();
            result.empresa = viewmodel.Empresa;
            result.traza = viewmodel.Traza;
            result.tipo = (int)viewmodel.Tipo;
            result.origen = (int)viewmodel.Origen;
            result.usuario = viewmodel.Usuario;
            result.fkcuentas = viewmodel.Fkcuentas;
            result.fechacreacion = viewmodel.Fechacreacion;
            result.fechafactura = viewmodel.Fechafactura;
            result.fecharegistrofactura = viewmodel.Fecharegistrofactura;
            result.fechavencimiento = viewmodel.Fechavencimiento;
            result.fechadescuento = viewmodel.Fechadescuento;
            result.fechapago = viewmodel.Fechapago;
            result.monedabase = viewmodel.Monedabase;
            result.monedagiro = viewmodel.Monedagiro;
            result.importegiro = viewmodel.Importegiro;
            result.importefactura = viewmodel.Importefactura;
            result.cambioaplicado = viewmodel.Cambioaplicado;
            result.monedafactura = viewmodel.Monedafactura;
            result.fkcuentatesoreria = viewmodel.Fkcuentatesoreria;
            result.fkformaspago = viewmodel.Fkformaspago;
            result.mandato = viewmodel.Mandato;
            result.importeasignado = viewmodel.Importeasignado;
            result.importepagado = viewmodel.Importepagado;
            result.estado = (int)viewmodel.Estado;
            result.situacion = viewmodel.Situacion;
            result.comentario = viewmodel.Comentario;
            return result;
        }

        public override IModelView GetModelView(Persistencia.Vencimientos viewmodel)
        {
            var result = new VencimientosModel
            {
                Empresa = viewmodel.empresa,
                Id = viewmodel.id,
                Traza = viewmodel.traza,
                Tipo = (TipoVencimiento)viewmodel.tipo,
                Origen = (TipoOrigen)viewmodel.origen,
                Usuario = viewmodel.usuario,
                Fkcuentas = viewmodel.fkcuentas,
                Fechacreacion = viewmodel.fechacreacion,
                Fechafactura = viewmodel.fechafactura,
                Fecharegistrofactura = viewmodel.fecharegistrofactura,
                Fechavencimiento = viewmodel.fechavencimiento,
                Fechadescuento = viewmodel.fechadescuento,
                Fechapago = viewmodel.fechapago,
                Monedabase = viewmodel.monedabase.Value,
                Monedagiro = viewmodel.monedagiro.Value,
                Importegiro = viewmodel.importegiro.Value,
                Importefactura = viewmodel.importefactura.Value,
                Cambioaplicado = viewmodel.cambioaplicado.Value,
                Monedafactura = viewmodel.monedafactura.Value,
                Fkcuentatesoreria = viewmodel.fkcuentatesoreria,
                Fkformaspago = viewmodel.fkformaspago,
                Mandato = viewmodel.mandato,
                Importeasignado = viewmodel.importeasignado.Value,
                Importepagado = viewmodel.importepagado.Value,
                Estado = (TipoEstado)viewmodel.estado,
                Situacion = viewmodel.situacion,
                Comentario = viewmodel.comentario
            };
           
            return result;
        }
    }
}
