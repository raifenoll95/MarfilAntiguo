using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Validation
{
    internal class ImputacionCostesValidation : BaseValidation<ImputacionCostes>
    {
        public string EjercicioId { get; set; }

        public ImputacionCostesValidation(IContextService context, MarfilEntities db) : base(context, db)
        {
        }

        public override bool ValidarGrabar(ImputacionCostes model)
        {

            return true;
        }
    }
}
