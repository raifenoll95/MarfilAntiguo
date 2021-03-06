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
    
    public partial class CarteraVencimientos
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public CarteraVencimientos()
        {
            this.PrevisionesCartera = new HashSet<PrevisionesCartera>();
        }
    
        public string empresa { get; set; }
        public int id { get; set; }
        public string traza { get; set; }
        public Nullable<int> tipovencimiento { get; set; }
        public string usuario { get; set; }
        public string fkcuentas { get; set; }
        public Nullable<System.DateTime> fechacreacion { get; set; }
        public Nullable<System.DateTime> fechavencimiento { get; set; }
        public Nullable<System.DateTime> fechadescuento { get; set; }
        public Nullable<System.DateTime> fechapago { get; set; }
        public Nullable<System.DateTime> fecharemesa { get; set; }
        public Nullable<int> monedabase { get; set; }
        public Nullable<int> monedagiro { get; set; }
        public Nullable<double> importegiro { get; set; }
        public Nullable<double> cambioaplicado { get; set; }
        public string fkcuentastesoreria { get; set; }
        public string mandato { get; set; }
        public string situacion { get; set; }
        public string comentario { get; set; }
        public string codigoremesa { get; set; }
        public Nullable<int> tiponumerofactura { get; set; }
        public Nullable<int> fkformaspago { get; set; }
        public string fkseriescontables { get; set; }
        public string referencia { get; set; }
        public string identificadorsegmento { get; set; }
        public Nullable<System.DateTime> fecha { get; set; }
        public string letra { get; set; }
        public string banco { get; set; }
        public string fkseriescontablesremesa { get; set; }
        public string referenciaremesa { get; set; }
        public string identificadorsegmentoremesa { get; set; }
        public string importeletra { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<PrevisionesCartera> PrevisionesCartera { get; set; }
    }
}
