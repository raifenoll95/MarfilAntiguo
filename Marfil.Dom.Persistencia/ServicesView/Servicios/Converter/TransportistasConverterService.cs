﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Marfil.Dom.Persistencia.Model.Terceros;
using Marfil.Dom.Persistencia.Model.Configuracion.Cuentas;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Interfaces;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    internal class TransportistasConverterService : BaseConverterModel<TransportistasModel, Transportistas>
    {
        #region CTR

        public TransportistasConverterService(IContextService context, MarfilEntities db) : base(context, db)
        {
            
        }

        #endregion

        #region Api

        public override IEnumerable<IModelView> GetAll()
        {
            var fservice = FService.Instance;
            var cuentasService = fservice.GetService(typeof(CuentasModel), Context, _db);
            var list = _db.Transportistas.Where(f => f.empresa == Empresa).ToList();


            var result = new List<TransportistasModel>();
            var fModel = new FModel();
            var fService = FService.Instance;
            var direccionesService = fService.GetService(typeof(DireccionesLinModel), Context, _db) as DireccionesService;
            foreach (var item in list)
            {
                var newitem = GetModelView(item) as TransportistasModel;
                
                newitem.Cuentas = cuentasService.get(item.fkcuentas) as CuentasModel;
                newitem.Direcciones = fModel.GetModel<DireccionesModel>(Context);
                newitem.Direcciones.Direcciones = direccionesService.GetDirecciones(TiposCuentas.Transportistas, newitem.Fkcuentas);
                newitem.Direcciones.Id = Guid.NewGuid();
                newitem.Direcciones.Tipotercero = (int)TiposCuentas.Transportistas;
                result.Add(newitem);
            }

            return result;
        }

        public override bool Exists(string id)
        {
            return _db.Set<Transportistas>().Any(f => f.fkcuentas == id && f.empresa == Empresa);
        }

        public override IModelView CreateView(string id)
        {
            var obj = _db.Set<Transportistas>().Single(f => f.fkcuentas == id && f.empresa == Empresa);
            var result = GetModelView(obj) as TransportistasModel;
            var fService = FService.Instance;
            var fModel = new FModel();
            var cuentasService = fService.GetService(typeof(CuentasModel), Context, _db);
            var direccionesService = fService.GetService(typeof(DireccionesLinModel), Context, _db) as DireccionesService;
            var contactosService = fService.GetService(typeof(ContactosLinModel), Context, _db) as ContactosService;
            var bancosmandatosService = fService.GetService(typeof(BancosMandatosLinModel), Context, _db) as BancosMandatosService;

            result.Cuentas = cuentasService.get(result.Fkcuentas) as CuentasModel;
            result.Direcciones = fModel.GetModel<DireccionesModel>(Context);
            result.Direcciones.Direcciones = direccionesService.GetDirecciones(TiposCuentas.Transportistas, obj.fkcuentas);
            result.Direcciones.Id = Guid.NewGuid();
            result.Direcciones.Tipotercero = (int)TiposCuentas.Transportistas;

            result.Contactos = fModel.GetModel<ContactosModel>(Context);
            result.Contactos.Contactos = contactosService.GetContactos(TiposCuentas.Transportistas, obj.fkcuentas);
            result.Contactos.Id = Guid.NewGuid();
            result.Contactos.Tipotercero = (int)TiposCuentas.Transportistas;
            result.Contactos.Direcciones = result.Direcciones;

            result.BancosMandatos = fModel.GetModel<BancosMandatosModel>(Context);
            result.BancosMandatos.BancosMandatos = bancosmandatosService.GetBancosMandatos(obj.fkcuentas);


            return result;
        }

        public override Transportistas CreatePersitance(IModelView obj)
        {
            var viewmodel = obj as TransportistasModel;
            var result = _db.Transportistas.Create();

            foreach (var item in result.GetType().GetProperties())
            {
                if (typeof(TransportistasModel).GetProperties().Any(f => f.Name.ToLower() == item.Name.ToLower()))
                    item.SetValue(result, viewmodel.get(item.Name));
            }

            result.fkpuertosfkpaises = viewmodel.Fkpuertos.Fkpaises;
            result.fkpuertosid = viewmodel.Fkpuertos.Id;

            return result;
        }

        public override Transportistas EditPersitance(IModelView obj)
        {
            var viewmodel = obj as TransportistasModel;
            var result = _db.Transportistas.Single(f => f.fkcuentas == viewmodel.Fkcuentas && f.empresa == viewmodel.Empresa);

            foreach (var item in result.GetType().GetProperties())
            {
                if(typeof(TransportistasModel).GetProperties().Any(f=>f.Name.ToLower()== item.Name.ToLower()))
                    item.SetValue(result, viewmodel.get(item.Name));
            }

            result.fkpuertosfkpaises = viewmodel.Fkpuertos.Fkpaises;
            result.fkpuertosid = viewmodel.Fkpuertos.Id;
            
            return result;
        }

        public override IModelView GetModelView(Transportistas obj)
        {
            var result= base.GetModelView(obj) as TransportistasModel;

            result.Fkpuertos.Fkpaises = obj.fkpuertosfkpaises;
            result.Fkpuertos.Id = obj.fkpuertosid;

            return result;
        }

        #endregion
    }
}
