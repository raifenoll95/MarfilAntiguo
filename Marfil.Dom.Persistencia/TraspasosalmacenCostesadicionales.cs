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
    
    public partial class TraspasosalmacenCostesadicionales
    {
        public string empresa { get; set; }
        public int fktraspasosalmacen { get; set; }
        public int id { get; set; }
        public int tipodocumento { get; set; }
        public string referenciadocumento { get; set; }
        public Nullable<double> importe { get; set; }
        public Nullable<double> porcentaje { get; set; }
        public Nullable<double> total { get; set; }
        public int tipocoste { get; set; }
        public int tiporeparto { get; set; }
        public string notas { get; set; }
    
        public virtual Traspasosalmacen Traspasosalmacen { get; set; }
    }
}
