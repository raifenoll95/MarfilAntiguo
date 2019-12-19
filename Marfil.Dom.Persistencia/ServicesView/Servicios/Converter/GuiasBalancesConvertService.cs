using Marfil.Dom.Persistencia.Model.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Converter
{
    class GuiasBalancesConvertService : BaseConverterModel<GuiasBalancesModel, GuiasBalances>
    {
        public GuiasBalancesConvertService(IContextService context, MarfilEntities db) : base(context, db)
        {
                
        }
    }
}
