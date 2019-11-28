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
    
    public partial class Albaranes
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Albaranes()
        {
            this.AlbaranesLin = new HashSet<AlbaranesLin>();
            this.AlbaranesTotales = new HashSet<AlbaranesTotales>();
        }
    
        public string empresa { get; set; }
        public int id { get; set; }
        public int fkejercicio { get; set; }
        public string fkseries { get; set; }
        public string identificadorsegmento { get; set; }
        public string referencia { get; set; }
        public Nullable<System.DateTime> fechadocumento { get; set; }
        public Nullable<System.DateTime> fechavalidez { get; set; }
        public Nullable<System.DateTime> fechaentrega { get; set; }
        public Nullable<System.DateTime> fecharevision { get; set; }
        public string fkalmacen { get; set; }
        public string fkclientes { get; set; }
        public string nombrecliente { get; set; }
        public string clientedireccion { get; set; }
        public string clientepoblacion { get; set; }
        public string clientecp { get; set; }
        public string clientepais { get; set; }
        public string clienteprovincia { get; set; }
        public string clientetelefono { get; set; }
        public string clientefax { get; set; }
        public string clienteemail { get; set; }
        public string clientenif { get; set; }
        public Nullable<int> fkformaspago { get; set; }
        public string fkagentes { get; set; }
        public string fkcomerciales { get; set; }
        public Nullable<double> comisionagente { get; set; }
        public Nullable<double> comisioncomercial { get; set; }
        public Nullable<int> fkmonedas { get; set; }
        public Nullable<double> cambioadicional { get; set; }
        public Nullable<double> importebruto { get; set; }
        public Nullable<double> importebaseimponible { get; set; }
        public Nullable<double> importeportes { get; set; }
        public Nullable<double> porcentajedescuentocomercial { get; set; }
        public Nullable<double> importedescuentocomercial { get; set; }
        public Nullable<double> porcentajedescuentoprontopago { get; set; }
        public Nullable<double> importedescuentoprontopago { get; set; }
        public Nullable<double> importetotaldoc { get; set; }
        public Nullable<double> importetotalmonedabase { get; set; }
        public string notas { get; set; }
        public string fkestados { get; set; }
        public string fkobras { get; set; }
        public string incoterm { get; set; }
        public string descripcionincoterm { get; set; }
        public Nullable<int> peso { get; set; }
        public Nullable<int> confianza { get; set; }
        public Nullable<double> costemateriales { get; set; }
        public Nullable<double> tiempooficinatecnica { get; set; }
        public string fkregimeniva { get; set; }
        public string fktransportista { get; set; }
        public Nullable<double> tipocambio { get; set; }
        public string fkpuertosfkpaises { get; set; }
        public string fkpuertosid { get; set; }
        public string unidadnegocio { get; set; }
        public string referenciadocumento { get; set; }
        public string fkbancosmandatos { get; set; }
        public string cartacredito { get; set; }
        public Nullable<System.DateTime> vencimientocartacredito { get; set; }
        public Nullable<int> contenedores { get; set; }
        public string fkcuentastesoreria { get; set; }
        public string numerodocumentoproveedor { get; set; }
        public Nullable<System.DateTime> fechadocumentoproveedor { get; set; }
        public string fkclientesreserva { get; set; }
        public int tipoalbaran { get; set; }
        public string fkmotivosdevolucion { get; set; }
        public string nombretransportista { get; set; }
        public string conductor { get; set; }
        public string matricula { get; set; }
        public Nullable<int> bultos { get; set; }
        public Nullable<double> pesoneto { get; set; }
        public Nullable<double> pesobruto { get; set; }
        public Nullable<double> volumen { get; set; }
        public string envio { get; set; }
        public string fkoperarios { get; set; }
        public string fkoperadortransporte { get; set; }
        public string fkzonas { get; set; }
        public Nullable<int> fkdireccionfacturacion { get; set; }
        public string fkcriteriosagrupacion { get; set; }
        public Nullable<int> tipoportes { get; set; }
        public Nullable<double> costeportes { get; set; }
        public System.Guid fkusuarioalta { get; set; }
        public System.DateTime fechaalta { get; set; }
        public System.Guid fkusuariomodificacion { get; set; }
        public System.DateTime fechamodificacion { get; set; }
        public Nullable<System.Guid> fkcarpetas { get; set; }
        public int modo { get; set; }
        public System.Guid integridadreferencial { get; set; }
        public string fkpedidos { get; set; }
        public Nullable<bool> pedidosaldado { get; set; }
        public string fkprospectos { get; set; }
        public Nullable<int> tipoalmacenlote { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AlbaranesLin> AlbaranesLin { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<AlbaranesTotales> AlbaranesTotales { get; set; }
    }
}
