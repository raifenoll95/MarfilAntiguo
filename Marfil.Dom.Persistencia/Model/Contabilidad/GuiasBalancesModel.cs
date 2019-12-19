using Marfil.Dom.Persistencia.ServicesView.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.Model.Contabilidad
{
    public class GuiasBalancesModel : BaseModel<GuiasBalancesModel, GuiasBalances>
    {
        public override string DisplayName => "Guias Contables";

        public int Id { get; set; }
        public string Informe { get; set; }
        public string Guia { get; set; }
        public string TextoGrupo { get; set; }
        public string Orden { get; set; }
        public string Actpas { get; set; }
        public string Detfor { get; set; }
        public string Formula { get; set; }
        public string RegDig { get; set; }
        public string Descrip { get; set; }
        public string Listado { get; set; }
        //public List<GuiasBalancesLineas> GuiasBalancesLineas { get; set; }

        public GuiasBalancesModel()
        {

        }
        public GuiasBalancesModel(IContextService context) : base(context)
        {

        }
        public override object generateId(string id)
        {
            return int.Parse(id);
        }
    }
}
