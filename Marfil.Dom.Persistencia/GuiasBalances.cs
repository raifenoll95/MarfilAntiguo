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
    
    public partial class GuiasBalances
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public GuiasBalances()
        {
            this.GuiasBalancesLineas = new HashSet<GuiasBalancesLineas>();
        }
    
        public int Id { get; set; }
        public Nullable<int> InformeId { get; set; }
        public Nullable<int> GuiaId { get; set; }
        public string textogrupo { get; set; }
        public string orden { get; set; }
        public string actpas { get; set; }
        public string detfor { get; set; }
        public string formula { get; set; }
        public string regdig { get; set; }
        public string descrip { get; set; }
        public string listado { get; set; }
    
        public virtual TipoGuia TipoGuia { get; set; }
        public virtual TipoInforme TipoInforme { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<GuiasBalancesLineas> GuiasBalancesLineas { get; set; }
    }
}
