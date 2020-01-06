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
        #region Propiedades
        public int Id { get; set; }
        public string informe { get; set; }
        public string guia { get; set; }
        public int? GuiasBalancesId { get; set; }
        public string orden { get; set; }
        public string cuenta { get; set; }
        public string signo { get; set; }
        public string signoea { get; set; }
        #endregion

        public GuiasBalancesLineasModel()
        {

        }

        public GuiasBalancesLineasModel(IContextService context) : base(context) { }

        public override string DisplayName => "Guias de Balances Lineas";

        public override object generateId(string id)
        {
            return Id;
        }
    }
}
