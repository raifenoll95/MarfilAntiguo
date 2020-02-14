using Marfil.Dom.Persistencia.Listados.Base;
using Marfil.Dom.Persistencia.Model.Contabilidad.Movs;
using Marfil.Dom.Persistencia.ServicesView.Servicios;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using RAPeriodos = Marfil.Inf.ResourcesGlobalization.Textos.Entidades.ListadoAcomuladoPeriodos;

namespace Marfil.Dom.Persistencia.Listados
{
    public class ListadoAcomuladorPeriodos : ListadosModel
    {
        #region Propiedades defecto
        public override string TituloListado => "Listado Acomulado de Periodos";
        public override string IdListado => FListadosModel.ListadoAcomuladorPeriodos;
        #endregion

        #region Propiedades
        [Display(ResourceType = typeof(RAPeriodos), Name = "FechaDesde")]
        public DateTime FechaDesde { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "FechaHasta")]
        public DateTime FechaHasta { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "SeccionDesde")]
        public string SeccionDesde { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "SeccionHasta")]
        public string SeccionHasta { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "Ejercicio")]
        public bool Ejercicio { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "Existencia")]
        public bool Existencia { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "Grupos")]
        public bool Grupos { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "CierreEjercicio")]
        public bool CierreEjercicio { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "IncluirAsientosSimulacion")]
        public bool IncluirAsientosSimulacion { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "ExcluirAsientosSimulacion")]
        public bool ExcluirAsientosSimulacion { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "IncluirAjusteExistenciaPeriodo")]
        public bool IncluirAjusteExistenciaPeriodo { get; set; }

        [Display(ResourceType = typeof(RAPeriodos), Name = "IncluirProrrateoAmortizaciones")]
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
            var sb = new StringBuilder();
            string filtro = string.Empty;
            bool flag = false;
            string valor = string.Empty;

            if (!string.IsNullOrEmpty(FechaDesde.ToShortDateString()) || !string.IsNullOrEmpty(FechaHasta.ToShortDateString()))
            {
                filtro = $" convert(nvarchar(10),fecha,103) BETWEEN '{FechaDesde.ToShortDateString()}' AND '{FechaHasta.ToShortDateString()}'";
            }
            if (Ejercicio)
            {
                if (flag)
                    valor += ",";
                valor += "'R2'";
                flag = true;
            }
            if(Existencia)
            {
                if (flag)
                    valor += ",";

                valor += "'R3'";
                flag = true;
            }
            if(Grupos)
            {
                if (flag)
                    valor += ",";

                valor += "'R4'";
                flag = true;
            }
            if (CierreEjercicio)
            {
                if (flag)
                    valor += ",";

                valor += "'R5'";
                flag = true;
            }
            if (IncluirAsientosSimulacion)
            {
                if (flag)
                    valor += ",";

                valor += "'F2'";
                flag = true;
            }
            if (ExcluirAsientosSimulacion)
            {
                if (flag)
                    valor += ",";

                valor += "'F3'";
                flag = true;
            }

            if(flag)
            {
                filtro += $" AND tipoasiento in({valor})";
            }
            sb.Append(filtro);
            return sb.ToString();
        }
        internal override string GenerarSelect()
        {
            var sb = new StringBuilder();
            sb.Append("Select * from Movs");
            return sb.ToString();
        }
    }
}
