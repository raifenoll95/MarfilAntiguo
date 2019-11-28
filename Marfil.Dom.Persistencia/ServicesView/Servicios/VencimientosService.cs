using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Marfil.Dom.Persistencia.Helpers;
using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.FicherosGenerales;
using Marfil.Dom.Persistencia.Model.Interfaces;
using Marfil.Inf.Genericos.Helper;
using Marfil.Dom.Persistencia.Model.Documentos.CobrosYPagos;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{

    public class VencimientosService : GestionService<VencimientosModel, Persistencia.Vencimientos>
    {

        #region CONSTRUCTOR
        public VencimientosService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }
        #endregion    

        #region CRUD
        public override void create(IModelView obj)
        {
            using (var tran = TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as VencimientosModel;
                
                if(_db.Vencimientos.Any())
                {
                    model.Id = _db.Vencimientos.Where(f => f.empresa == Empresa).Select(f => f.id).Max() + 1;
                }

                else
                {
                    model.Id = 0;
                }

                //Llamamos al base
                base.create(obj);

                //Guardamos los cambios
                _db.SaveChanges();
                tran.Complete();
            }
        }
        #endregion

        public string getFacturaByTraza(string traza)
        {
            var id = _db.Facturas.Where(f => f.empresa == Empresa && f.referencia == traza).Select(f => f.id).SingleOrDefault();
            return id.ToString();
        }


        //Index Vencimientos Cobros
        public ListIndexModel GetListIndexModelCobros(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var fmodel = new FModel();
            var obj = fmodel.GetModel<VencimientosModel>(_context);
            var instance = obj as IModelView;
            var extension = obj as IModelViewExtension;
            var display = obj as ICanDisplayName;
            var model = new ListIndexModel()
            {
                Entidad = display.DisplayName,
                List = GetAllCobros<VencimientosModel>(),
                PrimaryColumnns = extension.primaryKey.Select(f => f.Name).ToList(),
                VarSessionName = "__" + t.Name,
                Properties = instance.getProperties(),
                Controller = controller,
                PermiteEliminar = canEliminar,
                PermiteModificar = canModificar,
                ExcludedColumns = new[] { "Toolbar" }
            };

            var propiedadesVisibles = new[] { "Traza", "Origen", "Fkcuentas", "Importegiro", "Importeasignado", "Importepagado", "Usuario" };
            var propiedades = Helpers.Helper.getProperties<VencimientosModel>();
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.PrimaryColumnns = new[] { "Id" };
            return model;
        }

        public IEnumerable<T> GetAllCobros<T>() where T : VencimientosModel
        {
            var a = _db.Database.SqlQuery<T>(GetSelectPrincipalCobros()).ToList();
            return a;
        }

        public string GetSelectPrincipalCobros()
        {
            return string.Format("select * from Vencimientos as v where v.tipo = 0 and v.empresa='{0}'", Empresa);
        }

        //--Pagos

        public ListIndexModel GetListIndexModelPagos(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var fmodel = new FModel();
            var obj = fmodel.GetModel<VencimientosModel>(_context);
            var instance = obj as IModelView;
            var extension = obj as IModelViewExtension;
            var display = obj as ICanDisplayName;
            var model = new ListIndexModel()
            {
                Entidad = display.DisplayName,
                List = GetAllPagos<VencimientosModel>(),
                PrimaryColumnns = extension.primaryKey.Select(f => f.Name).ToList(),
                VarSessionName = "__" + t.Name,
                Properties = instance.getProperties(),
                Controller = controller,
                PermiteEliminar = canEliminar,
                PermiteModificar = canModificar,
                ExcludedColumns = new[] { "Toolbar" }
            };

            var propiedadesVisibles = new[] { "Traza", "Origen", "Fkcuentas", "Importegiro", "Importeasignado", "Importepagado", "Usuario" };
            var propiedades = Helpers.Helper.getProperties<VencimientosModel>();
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.PrimaryColumnns = new[] { "Id" };
            return model;
        }

        public IEnumerable<T> GetAllPagos<T>() where T : VencimientosModel
        {
            var a = _db.Database.SqlQuery<T>(GetSelectPrincipalPagos()).ToList();
            return a;
        }

        public string GetSelectPrincipalPagos()
        {
            return string.Format("select * from Vencimientos as v where v.tipo = 1 and v.empresa='{0}'", Empresa);
        }
    }
    }
