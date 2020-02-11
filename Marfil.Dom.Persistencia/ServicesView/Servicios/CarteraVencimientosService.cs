﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Inf.Genericos.Helper;
using Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos;
using System.Text;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{

    public class CarteraVencimientosService : GestionService<CarteraVencimientosModel, Persistencia.CarteraVencimientos>
    {

        #region CONSTRUCTOR
        public CarteraVencimientosService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }
        #endregion
        
        #region List index

        public override ListIndexModel GetListIndexModel(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var model = base.GetListIndexModel(t, canEliminar, canModificar, controller);
            var situacionesService = new SituacionesTesoreriaService(_context, _db);
            var propiedadesVisibles = new[] {"Tipovencimiento", "Referencia", "Fkcuentas", "Descripcioncuenta", "Importegiro", "Fechavencimiento", "Situacion" };
            var propiedades = Helpers.Helper.getProperties<CarteraVencimientosModel>();
            model.PrimaryColumnns = new[] { "Id" };
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.ColumnasCombo.Add("Situacion", situacionesService.getAll().OfType<SituacionesTesoreriaModel>().Select(f => new Tuple<string, string>(f.Cod, f.Descripcion)));
            model.FiltroColumnas.Add("Fechavencimiento", FiltroColumnas.EmpiezaPor);
            model.ColumnaColor = "6";
            return model;
        }

        public override string GetSelectPrincipal()
        {
            var result = new StringBuilder();
            result.Append(" select c.*, cuen.descripcion as Descripcioncuenta ");
            result.Append(" from CarteraVencimientos as c ");
            result.AppendFormat(" left join Cuentas as cuen on cuen.id = c.fkcuentas and cuen.empresa ='{0}' ", _context.Empresa);
            result.AppendFormat(" where c.empresa ='{0}' ", _context.Empresa);

            return result.ToString();
        }

        #endregion     

        #region CRUD
        public override void create(IModelView obj)
        {
            using (var tran = TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as CarteraVencimientosModel;
                
                if(_db.CarteraVencimientos.Any())
                {
                    model.Id = _db.CarteraVencimientos.Where(f => f.empresa == Empresa).Select(f => f.id).Max() + 1;
                }

                else
                {
                    model.Id = 0;
                }

                if(!model.Tiponumerofactura.HasValue)
                {
                    model.Tiponumerofactura = 0;
                }
                if (!model.Monedabase.HasValue)
                {
                    model.Monedabase = 0;
                }
                if (!model.Monedagiro.HasValue)
                {
                    model.Monedagiro = 0;
                }

                model.Fecha= DateTime.Now;

                //Calculo ID
                var contador = ServiceHelper.GetNextIdContable<CarteraVencimientos>(_db, Empresa, model.Fkseriescontables);
                var identificadorsegmento = "";
                model.Referencia = ServiceHelper.GetReferenceContable<CarteraVencimientos>(_db, model.Empresa, model.Fkseriescontables, contador, model.Fecha.Value, out identificadorsegmento);
                model.Identificadorsegmento = identificadorsegmento;         

                //Llamamos al base
                base.create(obj);

                //Guardamos los cambios
                _db.SaveChanges();
                tran.Complete();
            }
        }

        public override IModelView get(string id)
        {
            var model = _converterModel.CreateView(id) as CarteraVencimientosModel;
            var serviceVencimientos = new VencimientosService(_context);

            foreach (var linea in model.LineasCartera)
            {
                model.LineasPrevisiones.Add(serviceVencimientos.get(linea.Codvencimiento.ToString()) as VencimientosModel);
            }
            return model;
        }
        #endregion
    }
}
