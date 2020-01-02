using Marfil.Dom.Persistencia.Model;
using Marfil.Dom.Persistencia.Model.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Contabilidad
{
    public interface IGuiasBalances { }
    public class GuiasBalancesService : GestionService<GuiasBalancesModel,GuiasBalances> , IGuiasBalances
    {
        public GuiasBalancesService(IContextService context, MarfilEntities db = null) : base(context,db)
        {

        }

        public override ListIndexModel GetListIndexModel(Type t, bool canEliminar, bool canModificar, string controller)
        {
            var model = base.GetListIndexModel(t, canEliminar, canModificar, controller);
            var unidadesService = new UnidadesService(_context, _db);
            var propiedadesVisibles = new[] { "Id", "Informe", "Guia", "TextoGrupo", "Orden", "Actpas", "Detfor", "Formula", "RegDig", "Descrip", "Listado" };
            var propiedades = Helpers.Helper.getProperties<GuiasBalancesModel>();
            model.ExcludedColumns =
                propiedades.Where(f => !propiedadesVisibles.Any(j => j == f.property.Name)).Select(f => f.property.Name).ToList();
            model.FiltroColumnas.Add("Id", FiltroColumnas.EmpiezaPor);
            //model.ColumnasCombo.Add("Fkgruposmateriales", ListGruposmateriales());
            return model;
        }
    }
}
