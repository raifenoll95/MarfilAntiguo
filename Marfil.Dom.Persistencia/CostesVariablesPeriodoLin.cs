//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Marfil.Dom.Persistencia
{
    using System;
    using System.Collections.Generic;
    
    public partial class CostesVariablesPeriodoLin
    {
        public string empresa { get; set; }
        public int fkejercicio { get; set; }
        public int id { get; set; }
        public string tablavaria { get; set; }
        public string descripcion { get; set; }
        public double precio { get; set; }
    
        public virtual CostesVariablesPeriodo CostesVariablesPeriodo { get; set; }
    }
}
