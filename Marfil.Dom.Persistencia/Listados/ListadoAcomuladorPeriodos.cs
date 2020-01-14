using Marfil.Dom.Persistencia.Listados.Base;
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
        public DateTime Desde { get; set; }
        public DateTime Hasta { get; set; }
        #endregion

        internal override string GenerarSelect()
        {
            throw new NotImplementedException();
        }
    }
}
