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
    
    public partial class AlbaranesTotales
    {
        public string empresa { get; set; }
        public int fkalbaranes { get; set; }
        public string fktiposiva { get; set; }
        public Nullable<double> brutototal { get; set; }
        public Nullable<double> porcentajerecargoequivalencia { get; set; }
        public Nullable<double> importerecargoequivalencia { get; set; }
        public Nullable<double> porcentajedescuentoprontopago { get; set; }
        public Nullable<double> importedescuentoprontopago { get; set; }
        public Nullable<double> porcentajedescuentocomercial { get; set; }
        public Nullable<double> importedescuentocomercial { get; set; }
        public Nullable<double> basetotal { get; set; }
        public Nullable<double> porcentajeiva { get; set; }
        public Nullable<double> cuotaiva { get; set; }
        public Nullable<double> subtotal { get; set; }
        public Nullable<int> decimalesmonedas { get; set; }
    
        public virtual Albaranes Albaranes { get; set; }
    }
}
