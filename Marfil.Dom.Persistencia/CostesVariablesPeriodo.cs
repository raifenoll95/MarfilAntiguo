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
    
    public partial class CostesVariablesPeriodo
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CostesVariablesPeriodo()
        {
            this.CostesVariablesPeriodoLin = new HashSet<CostesVariablesPeriodoLin>();
        }
    
        public string empresa { get; set; }
        public int fkejercicio { get; set; }
    
        public virtual Ejercicios Ejercicios { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<CostesVariablesPeriodoLin> CostesVariablesPeriodoLin { get; set; }
    }
}