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
    
    public partial class Transformaciones
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Transformaciones()
        {
            this.Transformacionescostesadicionales = new HashSet<Transformacionescostesadicionales>();
            this.Transformacionesentradalin = new HashSet<Transformacionesentradalin>();
            this.Transformacionessalidalin = new HashSet<Transformacionessalidalin>();
        }
    
        public string empresa { get; set; }
        public int id { get; set; }
        public int fkejercicio { get; set; }
        public string fkseries { get; set; }
        public string identificadorsegmento { get; set; }
        public string referencia { get; set; }
        public Nullable<System.DateTime> fechadocumento { get; set; }
        public string fkalmacen { get; set; }
        public string fkproveedores { get; set; }
        public string nombreproveedor { get; set; }
        public string notas { get; set; }
        public string fktransportista { get; set; }
        public string referenciadocumentoproveedor { get; set; }
        public Nullable<System.DateTime> fechadocumentoproveedor { get; set; }
        public string nombretransportista { get; set; }
        public string conductor { get; set; }
        public string matricula { get; set; }
        public string fkoperarios { get; set; }
        public string fkoperadortransporte { get; set; }
        public string fkzonas { get; set; }
        public System.Guid fkusuarioalta { get; set; }
        public System.DateTime fechaalta { get; set; }
        public System.Guid fkusuariomodificacion { get; set; }
        public System.DateTime fechamodificacion { get; set; }
        public Nullable<System.Guid> integridadreferencialflag { get; set; }
        public string fkestados { get; set; }
        public Nullable<int> tipoalmacenlote { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transformacionescostesadicionales> Transformacionescostesadicionales { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transformacionesentradalin> Transformacionesentradalin { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Transformacionessalidalin> Transformacionessalidalin { get; set; }
    }
}