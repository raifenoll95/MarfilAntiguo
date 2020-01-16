using Marfil.Dom.Persistencia.Listados.Base;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marfil.Dom.Persistencia.Listados
{
    public class ListadoAcomuladorPeriodos : ListadosModel
    {
        #region Propiedades defecto
        public override string TituloListado => "Listado Acomulado de Periodos";
        public override string IdListado => FListadosModel.ListadoAcomuladorPeriodos;
        #endregion

        #region Propiedades
        public DateTime FechaDesde { get; set; }
        public DateTime FechaHasta { get; set; }
        public bool Ejercicio { get; set; }
        public bool Existencia { get; set; }
        public bool Grupos { get; set; }
        public bool CierreEjercicio { get; set; }
        public bool IncluirAsientosSimulacion { get; set; }
        public bool ExcluirAsientosSimulacion { get; set; }
        public bool IncluirAjusteExistenciaPeriodo { get; set; }
        public bool IncluirProrrateoAmortizaciones { get; set; }
        #endregion
        public ListadoAcomuladorPeriodos()
        {

        }
        public ListadoAcomuladorPeriodos(IContextService context):base(context)
        {

        }
        internal override string GenerarFiltrosColumnas()
        {
            return base.GenerarFiltrosColumnas();
        }
        internal override string GenerarSelect()
        {
            var sb = new StringBuilder();
            sb.Append("Select * from Maes");
            return sb.ToString();
        }
    }
}
