//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
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
