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
    
    public partial class InformeMargen
    {
        public string empresa { get; set; }
        public int id { get; set; }
        public string fkArticulosCod { get; set; }
        public string fkArticulosNom { get; set; }
        public string lote { get; set; }
        public Nullable<int> tablaId { get; set; }
        public Nullable<double> cantidad { get; set; }
        public string referenciaAlbVenta { get; set; }
        public string fkClientesCod { get; set; }
        public string fkClientesNom { get; set; }
        public Nullable<double> metrosVenta { get; set; }
        public Nullable<double> precioTotalVenta { get; set; }
        public Nullable<double> precioVtaMetro { get; set; }
        public string referenciaAlbCompra { get; set; }
        public string fkProveedorCod { get; set; }
        public string fkProveedorNom { get; set; }
        public Nullable<double> metrosCompra { get; set; }
        public Nullable<double> precioTotalCompra { get; set; }
        public Nullable<double> precioCompraMetro { get; set; }
        public Nullable<double> diferenciaMetros { get; set; }
        public Nullable<double> margen { get; set; }
        public Nullable<int> margenPorcentaje { get; set; }
    }
}
