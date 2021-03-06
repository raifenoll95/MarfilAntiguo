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
    
    public partial class Seguimientos
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Seguimientos()
        {
            this.SeguimientosCorreo = new HashSet<SeguimientosCorreo>();
        }
    
        public string empresa { get; set; }
        public int id { get; set; }
        public string origen { get; set; }
        public Nullable<int> tipo { get; set; }
        public string usuario { get; set; }
        public string asunto { get; set; }
        public Nullable<System.DateTime> fechadocumento { get; set; }
        public string fkempresa { get; set; }
        public string fkcontacto { get; set; }
        public string fketapa { get; set; }
        public string fkaccion { get; set; }
        public string fkclavecoste { get; set; }
        public Nullable<int> coste { get; set; }
        public string notas { get; set; }
        public string fkdocumentorelacionado { get; set; }
        public Nullable<bool> cerrado { get; set; }
        public Nullable<System.DateTime> fecharesolucion { get; set; }
        public string fkreaccion { get; set; }
        public string fkreferenciadocumentorelacionado { get; set; }
        public Nullable<System.DateTime> fechaproximoseguimiento { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<SeguimientosCorreo> SeguimientosCorreo { get; set; }
    }
}
