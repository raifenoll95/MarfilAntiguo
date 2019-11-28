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
            var propiedadesVisibles = new[] { "Tipo", "Traza", "Fkcuentas", "Importegiro", "Usuario"};
            var propiedades = Helpers.Helper.getProperties<CarteraVencimientosModel>();
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.PrimaryColumnns = new[] { "Id" };
            return model;
        }

        public override string GetSelectPrincipal()
        {
            return string.Format("select * from CarteraVencimientos as c where c.empresa='{0}'", Empresa);
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

                //Llamamos al base
                base.create(obj);

                //Guardamos los cambios
                _db.SaveChanges();
                tran.Complete();
            }
        }
        #endregion
    }
}
