using Marfil.Dom.Persistencia.Model.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Contabilidad
{
    public interface IGuiasBalancesLineas { }
    public class GuiasBalancesLineasService : GestionService<GuiasBalancesLineasModel,GuiasBalancesLineas>, IGuiasBalancesLineas
    {
        public GuiasBalancesLineasService(IContextService context, MarfilEntities db = null) : base(context, db)
        {

        }
    }
}
