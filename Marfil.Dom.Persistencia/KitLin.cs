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
    
    public partial class KitLin
    {
        public string empresa { get; set; }
        public int fkkit { get; set; }
        public int id { get; set; }
        public string lote { get; set; }
        public string loteid { get; set; }
        public string fkarticulos { get; set; }
        public string descripcion { get; set; }
        public double coste { get; set; }
        public double largo { get; set; }
        public double ancho { get; set; }
        public double grueso { get; set; }
        public double metros { get; set; }
        public string fkunidades { get; set; }
        public int decimalesunidades { get; set; }
        public int decimalesprecio { get; set; }
        public int cantidad { get; set; }
        public string fkalmacenes { get; set; }
    
        public virtual Kit Kit { get; set; }
    }
}
