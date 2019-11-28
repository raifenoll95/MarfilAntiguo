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
using System.Text;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios
{

    public class CircuitosTesoreriaCobrosService : GestionService<CircuitoTesoreriaCobrosModel, Persistencia.CircuitosTesoreriaCobros>
    {

        #region CONSTRUCTOR
        public CircuitosTesoreriaCobrosService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }
        #endregion
        
        #region List index

        public override ListIndexModel GetListIndexModel(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var model = base.GetListIndexModel(t, canEliminar, canModificar, controller);
            var propiedadesVisibles = new[] { "Tipocircuito", "Situacioninicialdescripcion", "Situacionfinaldescripcion", "Descripcion"};
            var propiedades = Helpers.Helper.getProperties<CircuitoTesoreriaCobrosModel>();
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.PrimaryColumnns = new[] { "Id" };

            return model;
        }

        public override string GetSelectPrincipal()
        {
            var result = new StringBuilder();
            result.Append(" select c.*,sitini.descripcion as Situacioninicialdescripcion,sitfin.descripcion as Situacionfinaldescripcion ");
            result.Append(" from CircuitosTesoreriaCobros as c ");
            result.Append(" left join SituacionesTesoreria as sitini on sitini.cod = c.situacioninicial ");
            result.Append(" left join SituacionesTesoreria as sitfin on sitfin.cod = c.situacionfinal ");
            result.AppendFormat(" where c.empresa ='{0}' ", _context.Empresa);

            return result.ToString();
        }

        #endregion     

        #region CRUD
        public override void create(IModelView obj)
        {
            using (var tran = TransactionScopeBuilder.CreateTransactionObject())
            {
                var model = obj as CircuitoTesoreriaCobrosModel;

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
