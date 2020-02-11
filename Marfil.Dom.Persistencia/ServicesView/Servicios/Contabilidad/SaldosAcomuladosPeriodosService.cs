using Marfil.Dom.Persistencia.Model.Contabilidad;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.ServicesView.Servicios.Contabilidad
{
    public class SaldosAcomuladosPeriodosService : GestionService<SaldosAcomuladosPeriodosModel, SaldosAcomuladosPeriodos>
    {
        public SaldosAcomuladosPeriodosService(IContextService context, MarfilEntities db = null) : base(context, db)
        {
        }

        public void GenerarMovimiento(SaldosAcomuladosPeriodosModel model, TipoOperacionMaes tipo)// short multiplo)
        {
            var movs = _db.Movs.Where(w => w.empresa == model.Empresa && w.fkejercicio == model.fkEjercicio);
            
        }
    }
}
