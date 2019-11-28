using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using System.Collections.Generic;
using System.Linq;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos;
using System;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    internal class CarteraVencimientosConverterService : BaseConverterModel<CarteraVencimientosModel, Persistencia.CarteraVencimientos>
    {
        public CarteraVencimientosConverterService(IContextService context, MarfilEntities db) : base(context, db)
        {
        }

        public override IEnumerable<IModelView> GetAll()
        {
            return _db.Set<Persistencia.CarteraVencimientos>().Select(GetModelView);
        }

        public override IModelView CreateView(string id)
        {
            var idnum = Int32.Parse(id);
            var obj = _db.Set<Persistencia.CarteraVencimientos>().Single(f => f.empresa == Empresa && f.id == idnum);
            var result = GetModelView(obj) as CarteraVencimientosModel;
            return result;
        }

        public override Persistencia.CarteraVencimientos CreatePersitance(IModelView obj)
        {
            var viewmodel = obj as CarteraVencimientosModel;
            var result = _db.Set<Persistencia.CarteraVencimientos>().Create();
            result.id = viewmodel.Id.Value;
            result.empresa = viewmodel.Empresa;
            result.traza = viewmodel.Traza;          
            result.tipo = (int)viewmodel.Tipo;
            result.usuario = Context.Usuario;
            result.fkcuentas = viewmodel.Fkcuentas;
            result.fechacreacion = DateTime.Now;
            result.fechavencimiento = viewmodel.Fechavencimiento;
            result.fechadescuento = viewmodel.Fechadescuento;
            result.fechapago = viewmodel.Fechapago;
            result.monedabase = viewmodel.Monedabase;
            result.monedagiro = viewmodel.Monedagiro;
            result.importegiro = viewmodel.Importegiro;
            result.cambioaplicado = viewmodel.Cambioaplicado;
            result.fkcuentatesoreria = viewmodel.Fkcuentatesoreria;
            result.mandato = viewmodel.Mandato;
            result.situacion = viewmodel.Situacion;
            result.comentario = viewmodel.Comentario;
            return result;
        }

        public override Persistencia.CarteraVencimientos EditPersitance(IModelView obj)
        {
            var viewmodel = obj as CarteraVencimientosModel;
            var result = _db.CarteraVencimientos.Where(f => f.id == viewmodel.Id && f.empresa == Empresa).Single();
            result.empresa = viewmodel.Empresa;
            result.traza = viewmodel.Traza;
            result.tipo = (int)viewmodel.Tipo;
            result.usuario = viewmodel.Usuario;
            result.fkcuentas = viewmodel.Fkcuentas;
            result.fechacreacion = viewmodel.Fechacreacion;
            result.fechavencimiento = viewmodel.Fechavencimiento;
            result.fechadescuento = viewmodel.Fechadescuento;
            result.fechapago = viewmodel.Fechapago;
            result.monedabase = viewmodel.Monedabase;
            result.monedagiro = viewmodel.Monedagiro;
            result.importegiro = viewmodel.Importegiro;
            result.cambioaplicado = viewmodel.Cambioaplicado;
            result.fkcuentatesoreria = viewmodel.Fkcuentatesoreria;
            result.mandato = viewmodel.Mandato;;
            result.situacion = viewmodel.Situacion;
            result.comentario = viewmodel.Comentario;
            return result;
        }

        public override IModelView GetModelView(Persistencia.CarteraVencimientos viewmodel)
        {
            var result = new CarteraVencimientosModel
            {
                Empresa = viewmodel.empresa,
                Id = viewmodel.id,
                Traza = viewmodel.traza,
                Tipo = (TipoVencimiento)viewmodel.tipo,
                Usuario = viewmodel.usuario,
                Fkcuentas = viewmodel.fkcuentas,
                Fechacreacion = viewmodel.fechacreacion,
                Fechavencimiento = viewmodel.fechavencimiento,
                Fechadescuento = viewmodel.fechadescuento,
                Fechapago = viewmodel.fechapago,
                Monedabase = viewmodel.monedabase.Value,
                Monedagiro = viewmodel.monedagiro.Value,
                Importegiro = viewmodel.importegiro.Value,
                Cambioaplicado = viewmodel.cambioaplicado.Value,
                Fkcuentatesoreria = viewmodel.fkcuentatesoreria,
                Mandato = viewmodel.mandato,
                Situacion = viewmodel.situacion,
                Comentario = viewmodel.comentario
            };
           
            return result;
        }
    }
}
