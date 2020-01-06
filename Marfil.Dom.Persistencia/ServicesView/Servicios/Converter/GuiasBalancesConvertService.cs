using Marfil.Dom.Persistencia.Model.Contabilidad;
using Marfil.Dom.Persistencia.Model.Interfaces;
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

        public override IModelView GetModelView(GuiasBalances obj)
        {
            var result = base.GetModelView(obj) as GuiasBalancesModel;
            result.GuiasBalancesLineas = obj.GuiasBalancesLineas.ToList().Select(g => new GuiasBalancesLineasModel()
            {
                cuenta = g.cuenta,
                guia = g.guia,
                GuiasBalancesId = g.GuiasBalancesId,
                Id = g.Id,
                informe = g.informe,
                orden = g.orden,
                signo = g.signo,
                signoea = g.signoea
            }).ToList();
            return result;
        }
    }
}
