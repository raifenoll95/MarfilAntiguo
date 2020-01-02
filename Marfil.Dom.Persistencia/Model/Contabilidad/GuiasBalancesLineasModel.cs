using Marfil.Dom.Persistencia.ServicesView.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.Model.Contabilidad
{
    public class GuiasBalancesLineasModel : BaseModel<GuiasBalancesLineasModel, GuiasBalancesLineas>
    {
        public GuiasBalancesLineasModel()
        {

        }
        public GuiasBalancesLineasModel(IContextService context) : base(context) { }

        public override string DisplayName => "Guias de Balances Lineas";

        public override object generateId(string id)
        {
            throw new NotImplementedException();
        }
    }
}
