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
    
    public partial class Vencimientos
    {
        public string empresa { get; set; }
        public int id { get; set; }
        public string traza { get; set; }
        public Nullable<int> tipo { get; set; }
        public Nullable<int> origen { get; set; }
        public string usuario { get; set; }
        public string fkcuentas { get; set; }
        public Nullable<System.DateTime> fechacreacion { get; set; }
        public Nullable<System.DateTime> fechafactura { get; set; }
        public Nullable<System.DateTime> fecharegistrofactura { get; set; }
        public Nullable<System.DateTime> fechavencimiento { get; set; }
        public Nullable<System.DateTime> fechadescuento { get; set; }
        public Nullable<System.DateTime> fechapago { get; set; }
        public Nullable<int> monedabase { get; set; }
        public Nullable<int> monedagiro { get; set; }
        public Nullable<double> importegiro { get; set; }
        public Nullable<double> cambioaplicado { get; set; }
        public Nullable<double> importefactura { get; set; }
        public Nullable<int> monedafactura { get; set; }
        public string fkcuentatesoreria { get; set; }
        public string mandato { get; set; }
        public Nullable<double> importeasignado { get; set; }
        public Nullable<double> importepagado { get; set; }
        public Nullable<int> estado { get; set; }
        public string situacion { get; set; }
        public string comentario { get; set; }
        public Nullable<int> fkformaspago { get; set; }
    }
}
