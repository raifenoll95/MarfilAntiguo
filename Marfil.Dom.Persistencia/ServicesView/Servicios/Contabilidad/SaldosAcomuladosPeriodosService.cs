using Marfil.Dom.Persistencia.Listados;
using Marfil.Dom.Persistencia.Model.Contabilidad;
using System;
using System.Collections.Generic;
using System.Data.Entity;
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

        public void GenerarMovimiento(ListadoAcomuladorPeriodos model, TipoOperacionMaes tipo)// short multiplo)
        {
            var movs = _db.Movs.Include(i => i.MovsLin)
                .Where(w => w.empresa == model.Empresa && w.fechaalta <= Convert.ToDateTime(model.SeccionDesde) && w.fechaalta >= Convert.ToDateTime(model.SeccionHasta));

            if (model.Ejercicio)//R2
            {
                var r2 = movs.Where(w => w.tipoasiento.ToUpper() == "R2");
            }

            if (model.Existencia) //R3
            {
                var r3 = movs.Where(w => w.tipoasiento.ToUpper() == "R3");
            }
            if (model.Grupos) //R4
            {
                var r4 = movs.Where(w => w.tipoasiento.ToUpper() == "R4");
            }

            if (model.CierreEjercicio)//R5
            {
                var r5 = movs.Where(w => w.tipoasiento.ToUpper() == "R5");
            }

            if (model.IncluirAsientosSimulacion)//F2
            {
                var f2 = movs.Where(w => w.tipoasiento.ToUpper() == "F2");
            }

            if (model.ExcluirAsientosSimulacion)//F3
            {
                var f3 = movs.Where(w => w.tipoasiento.ToUpper() == "F3");
            }

        }
    }
}
