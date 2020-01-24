using Marfil.Dom.Persistencia.ServicesView.Servicios;
using Marfil.Inf.Genericos;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RGuiasBalances = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.GuiasBalances;

namespace Marfil.Dom.Persistencia.Model.Contabilidad
{
    public enum TipoInforme
    {
        [StringValue(typeof(RGuiasBalances), "Balca")]
        Balca,
        [StringValue(typeof(RGuiasBalances), "CTAPG")]
        Ctapg,
    }
    public enum TipoGuia 
    {
        [StringValue(typeof(RGuiasBalances), "TipoGuia1")]
        Abreviada,
        [StringValue(typeof(RGuiasBalances), "TipoGuia2")]
        Abreviado,
        [StringValue(typeof(RGuiasBalances), "TipoGuia3")]
        COOP_ABREVIA,
        [StringValue(typeof(RGuiasBalances), "TipoGuia4")]
        COOP_NORMAL,
        [StringValue(typeof(RGuiasBalances), "TipoGuia5")]
        NORMAL,
        [StringValue(typeof(RGuiasBalances), "TipoGuia6")]
        PYME
    }
    public class GuiasBalancesModel : BaseModel<GuiasBalancesModel, GuiasBalances>
    {
        public override string DisplayName => "Guias Contables";

        public int Id { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Informe")]
        public string Informe { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Informe")]
        public TipoInforme TInforme { get; set; }
        

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Guia")]
        public string Guia { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Guia")]
        public TipoGuia TGuia { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "TextoGrupo")]
        public string TextoGrupo { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Orden")]
        public string Orden { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Actpas")]
        public string Actpas { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Detfor")]
        public string Detfor { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Formula")]
        public string Formula { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "RegDig")]
        public string RegDig { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Descrip")]
        public string Descrip { get; set; }

        [Display(ResourceType = typeof(RGuiasBalances), Name = "Listado")]
        public string Listado { get; set; }

        private List<GuiasBalancesLineasModel> _GuiasBalancesLineas;

        public List<GuiasBalancesLineasModel> GuiasBalancesLineas
        {
            get { return _GuiasBalancesLineas; }
            set { _GuiasBalancesLineas = value; }
        }


        public GuiasBalancesModel()
        {

        }
        public GuiasBalancesModel(IContextService context) : base(context)
        {
            GuiasBalancesLineas = new List<GuiasBalancesLineasModel>();
        }
        public override object generateId(string id)
        {
            return int.Parse(id);
        }
    }
}
